fx_version 'adamant'
game 'gta5'
author 'oskar'
description 'Radio List'
lua54 'yes'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua',
    '@oxmysql/lib/MySQL.lua',
}

shared_script '@ox_lib/init.lua'

ui_page 'index.html'

files {
    'index.html'
}