fx_version 'adamant'

game 'gta5'

description 'ESX Status'

version '1.7.5'

lua54 'yes'

shared_script '@crm-core/imports.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/classes/status.lua',
	'client/main.lua'
}

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/css/app.css',
	'html/scripts/app.js'
}

dependency 'crm-core'
