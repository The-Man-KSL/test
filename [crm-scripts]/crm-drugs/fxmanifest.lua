
lua54 'yes' 




fx_version 'cerulean'
games { 'rdr3', 'gta5' }

lua54 'yes'

shared_script '@ox_lib/init.lua'

shared_scripts {
	"config.lua"
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'

}

lua54 'yes'
