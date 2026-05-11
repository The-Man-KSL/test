fx_version 'adamant'

game 'gta5'

author 'Tuna#1565'
description 'Chat script'

version '0.1.0'

escrow_ignore {
	'Config.lua',
}

lua54 'yes'

shared_scripts {
	'Config.lua',
	'Common/*.lua'
}

client_scripts {
	'Client/*.lua'
}

server_scripts {
	'Server/*.lua'
}

ui_page 'UI/index.html'

files {
    'UI/index.html',
    'UI/scripts/*.js',
    'UI/styles/*.css',
	'UI/img/*.png',
	'UI/img/*.jpg'
}

dependency 'crm-asset'

escrow_ignore {
	'config.lua',
	'client/events.lua',
	'server/events.lua',
  }
dependency '/assetpacks'