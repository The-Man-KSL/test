fx_version 'adamant'

game 'gta5'

author 'okok#3488'
description 'okokBanking'

ui_page 'web/ui.html'

lua54 'yes'

files {
	'web/*.*'
}

shared_script 'config.lua'
shared_script '@ox_lib/init.lua'

client_scripts {
	'client.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}