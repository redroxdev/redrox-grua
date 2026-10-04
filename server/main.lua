local QBCore = exports['qb-core']:GetCoreObject()
local isCleaning = false

--- Función auxiliar para verificar si un vehículo tiene algún ocupante (conductor o pasajero)
--- @param vehicle number Entidad del vehículo
--- @return boolean isOccupied Retorna true si hay algún ped dentro
local function IsVehicleOccupied(vehicle)
    if not DoesEntityExist(vehicle) then return false end

    -- Asiento del conductor (-1)
    local driver = GetPedInVehicleSeat(vehicle, -1)
    if driver and driver > 0 and DoesEntityExist(driver) then
        return true
    end

    -- Asientos de pasajeros (0 a 10)
    for seat = 0, 10 do
        local occupant = GetPedInVehicleSeat(vehicle, seat)
        if occupant and occupant > 0 and DoesEntityExist(occupant) then
            return true
        end
    end

    return false
end

--- Función para verificar si el vehículo debe ser ignorado (ambientales NPC o emergencias)
--- @param vehicle number Entidad del vehículo
--- @return boolean
local function ShouldIgnoreVehicle(vehicle)
    if not DoesEntityExist(vehicle) then return true end

    -- Ignorar vehículos ambientales generados por el tráfico de GTA V (NPCs)
    if Config.IgnoreAmbientVehicles then
        local popType = GetEntityPopulationType(vehicle)
        -- Tipos 2 a 6 corresponden a tráfico ambiental de GTA V
        if popType >= 2 and popType <= 6 then
            return true
        end
    end

    -- Ignorar vehículos de emergencia si está habilitado
    if Config.IgnoreEmergencyVehicles then
        local class = GetVehicleClass(vehicle)
        if class then
            for _, emergencyClass in ipairs(Config.EmergencyClasses or {}) do
                if class == emergencyClass then
                    return true
                end
            end
        end
    end

    return false
end

--- Envía aviso secundario opcional (chat o notificación)
--- @param message string Mensaje
--- @param notifyType string 'warning' o 'success'
local function BroadcastSecondary(message, notifyType)
    if Config.NotifyType == 'chat' then
        TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 180, 0 },
            multiline = true,
            args = { 'GRÚA', message }
        })
    elseif Config.NotifyType == 'qb' or Config.NotifyType == 'ox' then
        TriggerClientEvent('redrox-grua:client:showNotify', -1, message, notifyType)
    end
end

--- Ejecuta el proceso de cuenta regresiva, cartel visual y limpieza
local function StartGruaCleanup()
    if isCleaning then return end
    isCleaning = true

    CreateThread(function()
        local totalSeconds = Config.Countdown
        local remaining = totalSeconds

        -- Mapeo de avisos secundarios
        local warningMap = {}
        for _, sec in ipairs(Config.WarningTimes or {}) do
            warningMap[sec] = true
        end

        -- Avisar a los clientes que inicia el cartel y la cuenta regresiva
        TriggerClientEvent('redrox-grua:client:startCountdown', -1, totalSeconds)

        while remaining > 0 do
            -- Enviar actualización segundo a segundo al cartel NUI
            TriggerClientEvent('redrox-grua:client:updateCountdown', -1, remaining, totalSeconds)

            -- Aviso secundario en los segundos configurados
            if warningMap[remaining] then
                local msg = string.format(Config.Messages.warning, tostring(remaining))
                BroadcastSecondary(msg, 'warning')
            end

            Wait(1000)
            remaining = remaining - 1
        end

        -- Ejecutar la limpieza de vehículos
        local vehicles = GetAllVehicles()
        local deletedCount = 0

        for _, vehicle in ipairs(vehicles) do
            if DoesEntityExist(vehicle) then
                if not IsVehicleOccupied(vehicle) and not ShouldIgnoreVehicle(vehicle) then
                    DeleteEntity(vehicle)
                    deletedCount = deletedCount + 1
                end
            end
        end

        -- Enviar evento de finalización al cartel NUI y aviso secundario
        TriggerClientEvent('redrox-grua:client:cleanupFinished', -1, deletedCount)

        local finalMsg = string.format(Config.Messages.deleted, tostring(deletedCount))
        BroadcastSecondary(finalMsg, 'success')

        isCleaning = false
    end)
end

-- Registro del comando en QBCore
QBCore.Commands.Add(Config.Command, 'Pasar la grúa y remolcar vehículos abandonados', {}, false, function(source, _)
    if isCleaning then
        TriggerClientEvent('QBCore:Notify', source, Config.Messages.inProgress, 'error')
        return
    end

    StartGruaCleanup()
end, Config.Permission)

-- Export para invocar desde otros recursos
exports('StartGruaCleanup', StartGruaCleanup)
