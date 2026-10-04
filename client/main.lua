local QBCore = exports['qb-core']:GetCoreObject()

-- Reproduce sonidos de alerta nativos en el cliente
local function PlayAlertSound(soundType)
    if soundType == 'warning' then
        PlaySoundFrontend(-1, 'Event_Start_Text', 'GTAO_FM_Events_Soundset', true)
    elseif soundType == 'success' then
        PlaySoundFrontend(-1, 'DELIVERY_DELIVERED', 'HUD_AWARDS', true)
    end
end

-- Envía notificación secundaria (ox_lib / qb / chat)
local function SendSecondaryNotify(message, notifyType)
    if not Config.NotifyType or Config.NotifyType == 'none' then return end

    if Config.NotifyType == 'ox' or (GetResourceState('ox_lib') == 'started' and Config.NotifyType == 'auto') then
        if GetResourceState('ox_lib') == 'started' then
            exports.ox_lib:notify({
                id = 'redrox_grua_notify',
                title = 'Grúa Municipal',
                description = message,
                type = (notifyType == 'warning' or notifyType == 'error') and 'warning' or 'success',
                duration = 6000,
                position = 'top-right'
            })
            return
        end
    end

    if Config.NotifyType == 'chat' then
        TriggerEvent('chat:addMessage', {
            color = { 255, 180, 0 },
            multiline = true,
            args = { 'GRÚA', message }
        })
    else
        local qbType = notifyType
        if qbType == 'warning' then qbType = 'error' end
        if QBCore and QBCore.Functions and QBCore.Functions.Notify then
            QBCore.Functions.Notify(message, qbType, 6000)
        else
            TriggerEvent('QBCore:Notify', message, qbType, 6000)
        end
    end
end

-- Inicia el cartel y la cuenta regresiva en pantalla
RegisterNetEvent('redrox-grua:client:startCountdown', function(totalSeconds)
    PlayAlertSound('warning')

    if Config.ShowBanner then
        SendNUIMessage({
            action = 'start',
            totalSeconds = totalSeconds
        })
    end
end)

-- Actualiza los segundos restantes en el cartel NUI
RegisterNetEvent('redrox-grua:client:updateCountdown', function(remainingSeconds, totalSeconds)
    if Config.ShowBanner then
        SendNUIMessage({
            action = 'update',
            remainingSeconds = remainingSeconds,
            totalSeconds = totalSeconds
        })
    end
end)

-- Finaliza la limpieza, muestra resultado en cartel y reproduce sonido
RegisterNetEvent('redrox-grua:client:cleanupFinished', function(deletedCount)
    PlayAlertSound('success')

    if Config.ShowBanner then
        SendNUIMessage({
            action = 'finished',
            deletedCount = deletedCount
        })
    end
end)

-- Evento para notificaciones secundarias
RegisterNetEvent('redrox-grua:client:showNotify', function(message, notifyType)
    SendSecondaryNotify(message, notifyType)
end)
