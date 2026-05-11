fx_version 'cerulean'
game 'gta5'
description 'crm-racing'
author 'HSN'
version '1.0.0'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server/server-config.lua',
    'server/main.lua',
    'server/functions.lua',
    'server/player.lua',
}


client_scripts {
    'config.lua',
    'client/*.lua'
}

ui_page {
    'ui/index.html',
}

files {
    'ui/index.html',
    'ui/fonts/*.otf',
    'ui/fonts/*.OTF',
    'ui/fonts/*.ttf',
    'ui/images/*.png',
    'ui/mapStyles/**/**/*.jpg',
    'ui/*.js',
    'ui/style.css',
    'ui/tailwind.config.js',
    'ui/package-lock.json',
    'ui/package.json',
    'ui/blips/*.png'
}

escrow_ignore {
    'config.lua',
    'server/server-config.lua',
    'server/main.lua',
    'server/functions.lua',
    'server/player.lua',
    'client/*.lua'
}

lua54 'yes'
