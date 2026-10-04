fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'RedRox'
description 'Sistema de grúa / limpieza de vehículos abandonados con cartel NUI para administradores'
version '1.1.0'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/style.css',
    'ui/script.js'
}
