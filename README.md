# redrox-grua

Sistema de grúa y limpieza masiva de vehículos abandonados para **QBCore** (FiveM) con **cartel visual animado (NUI)**.

## Características

- 🖼️ **Cartel visual arriba al centro (NUI)**: Banner animado moderno (glassmorphism) con icono de grúa, cuenta regresiva en vivo y barra de progreso sincronizada.
- 🔒 **Restringido a Administradores**: Ejecución mediante permisos nativos de QBCore (`admin`, `god`, etc.).
- 🚗 **Detección precisa de ocupantes**: Chequea el asiento del conductor y todos los asientos de pasajeros en el servidor para **no borrar autos que tengan gente adentro**.
- 🧍 **Protección de tráfico NPC**: Opción `Config.IgnoreAmbientVehicles` para no borrar autos de tráfico ambiental generados por GTA V.
- 🛡️ **Protección de vehículos de emergencia**: Opción en `config.lua` para proteger ambulancias, patrullas, etc.
- 🔊 **Feedback sonoro**: Notificación con sonidos nativos de alerta y éxito de GTA Online.
- ⚙️ **Avisos adicionales configurables**: Podés combinar el cartel con mensajes por `chat`, `qb-core notify` o `ox_lib`.

---

## Instalación

1. Colocá la carpeta `redrox-grua` dentro de la carpeta `resources/` de tu servidor.
2. Agregá `ensure redrox-grua` en tu `server.cfg`.
3. Reiniciá el recurso en consola con `restart redrox-grua`.

---

## Uso

Comando en el chat del juego (requiere rango admin):

```text
/grua
```

---

## Configuración (`config.lua`)

```lua
Config.Command = 'grua'                -- Comando
Config.Permission = 'admin'            -- Permiso QBCore ('admin', 'god', etc.)
Config.Countdown = 30                  -- Tiempo total en segundos
Config.ShowBanner = true               -- Cartel arriba al centro en pantalla (NUI)
Config.WarningTimes = { 30, 15, 5 }    -- Segundos en los que se envía aviso extra
Config.IgnoreAmbientVehicles = true    -- Ignorar tráfico de NPCs del mapa
Config.IgnoreEmergencyVehicles = false -- Proteger vehículos de emergencia
Config.NotifyType = 'chat'             -- 'chat', 'qb', 'ox', o 'none'
```

---

## Export para otros scripts

Podés disparar la grúa programáticamente desde el lado del servidor con:

```lua
exports['redrox-grua']:StartGruaCleanup()
```
