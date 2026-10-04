# redrox-grua

Sistema de grúa y limpieza masiva de vehículos abandonados para **QBCore** (FiveM) con **cartel visual animado (NUI)**[cite: 3].

## Características

- 🖼️ **Cartel visual arriba al centro (NUI)**: Banner animado moderno (glassmorphism) con icono de grúa, cuenta regresiva en vivo y barra de progreso sincronizada[cite: 3].
- 🔒 **Restringido a Administradores**: Ejecución mediante permisos nativos de QBCore (`admin`, `god`, etc.)[cite: 3].
- 🚗 **Detección precisa de ocupantes**: Chequea el asiento del conductor y todos los asientos de pasajeros en el servidor para **no borrar autos que tengan gente adentro**[cite: 3, 4].
- 🧍 **Protección de tráfico NPC**: Opción `Config.IgnoreAmbientVehicles` para no borrar autos de tráfico ambiental generados por GTA V[cite: 3, 4].
- 🛡️ **Protección de vehículos de emergencia**: Opción en `config.lua` para proteger ambulancias, patrullas, etc.[cite: 1, 3, 4]
- 🔊 **Feedback sonoro**: Notificación con sonidos nativos de alerta y éxito de GTA Online[cite: 3].
- ⚙️ **Avisos adicionales configurables**: Podés combinar el cartel con mensajes por `chat`, `qb-core notify` o `ox_lib`[cite: 1, 3].

---

## Instalación

1. Colocá la carpeta `redrox-grua` dentro de la carpeta `resources/` de tu servidor[cite: 3].
2. Agregá `ensure redrox-grua` en tu `server.cfg`[cite: 3].
3. Reiniciá el recurso en consola con `restart redrox-grua`[cite: 3].

---

## Uso

Comando en el chat del juego (requiere rango admin)[cite: 3]:

```text
/grua
