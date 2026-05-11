fx_version 'adamant'
game 'gta5'
author 'okok#3488'
description 'okokReports'
version '1.1'
lua54 'yes'
ui_page 'web/ui.html'
files {
	'web/*.*',
}
shared_script 'config.lua'

shared_script '@ox_lib/init.lua'

client_scripts {
	'client.lua',
}
server_scripts {
	'server.lua',
}

