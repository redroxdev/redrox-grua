Config = {}

-- Nombre del comando
Config.Command = 'grua'

-- Permiso requerido en QBCore ('admin', 'god', etc.)
Config.Permission = 'admin'

-- Tiempo total de espera antes de la limpieza (en segundos)
Config.Countdown = 30

-- Segundos en los que se emitirá un aviso secundario adicional
Config.WarningTimes = { 30, 15, 5 }

-- Mostrar cartel visual arriba al centro de la pantalla (NUI)
Config.ShowBanner = true

-- Proteger vehículos de emergencia (policía, ambulancia, etc.) aunque estén vacíos
Config.IgnoreEmergencyVehicles = false

-- Ignorar tráfico ambiental / autos de NPCs generados por el mapa
Config.IgnoreAmbientVehicles = true

-- Clases de vehículos que se consideran de emergencia (18 = Emergency)
Config.EmergencyClasses = { 18 }

-- Tipo de notificación secundaria: 'ox' (ox_lib), 'chat', 'qb' (QBCore Notify), o 'none'
Config.NotifyType = 'ox'

-- Textos configurables
Config.Messages = {
    warning = 'La grúa pasará en %s segundos. ¡Subite a tu vehículo si no querés que se lo lleve!',
    deleted = 'Se han remolcado %s vehículos abandonados del mapa.',
    inProgress = 'Ya hay una limpieza de vehículos en curso. Por favor esperá a que finalice.',
    noPermission = 'No tenés permisos para ejecutar este comando.'
}
