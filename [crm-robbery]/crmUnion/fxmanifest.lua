fx_version 'cerulean'
games { 'rdr3', 'gta5' }

lua54 'yes'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

server_scripts {
	'server.lua',
    'editable_server.lua'
}

client_scripts {
    'editable_functions.lua',
	'client.lua'
}

escrow_ignore {
    'config.lua',
    'editable_functions.lua',
    'editable_server.lua'
}