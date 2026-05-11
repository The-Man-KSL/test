fx_version 'adamant'

game 'gta5'

description 'ESX Ambulance Job'

lua54 'yes'
version '1.7.5'

shared_scripts { 
	'@crm-core/imports.lua',
	'@crm-core/locale.lua',
	'locales/*.lua',
	'config.lua'
}


server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

client_scripts {
	'client/main.lua',
	'client/job.lua',
	'client/vehicle.lua',
}

dependencies {
	'crm-core'
}
