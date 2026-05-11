fx_version 'adamant'
game 'gta5'
lua54 'yes'
author 'Josh'
description 'CRM Identity'
version '1.0.6'


shared_script {
	'@crm-core/imports.lua',
	'config/config.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

client_scripts {
	'client/main.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/js/script.js',
	'html/css/style.css',
	'config/translation.js'
}