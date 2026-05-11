fx_version 'adamant'
game 'gta5'
description 'VNS Casino Slots Machine'
version '2.1.3'


server_scripts {
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