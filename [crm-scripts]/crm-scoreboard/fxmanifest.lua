fx_version "adamant"

description "EYES Store"
author "! Raider#0101"
version '1.0.0'
repository 'https://discord.gg/EkwWvFS'

game "gta5"

client_script { 
"main/client.lua"
}

server_script {
"@oxmysql/lib/MySQL.lua",
"main/server.lua",
"main/shared.lua"
}

shared_script "main/shared.lua"

ui_page "index.html"


files {
    'index.html',
    'vue.js',
    'assets/**/*.*',
    'assets/font/*.otf',  
}


escrow_ignore { 'main/shared.lua' }

lua54 'yes'
-- dependency '/assetpacks'