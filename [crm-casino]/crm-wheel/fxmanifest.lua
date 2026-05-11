fx_version 'adamant'
game 'gta5'
description 'VNS Lucky Wheel'
version '1.5.6'


server_scripts {
	'@mysql-async/lib/MySQL.lua',
    '@crm-core/locale.lua',
    'locales/*.lua',
	'config.lua',
	'server.lua'
}

client_scripts {
    '@crm-core/locale.lua',
    'locales/*.lua',
	'config.lua',
	'client.lua',
}

dependency 'crm-core'