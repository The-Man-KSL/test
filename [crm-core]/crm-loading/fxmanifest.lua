fx_version 'cerulean'
game 'gta5'

client_script {
    "config.lua",
	'client.lua',
}

server_script {
	"config.lua",
	"server.lua",
}

loadscreen 'nui/index.html'
loadscreen_cursor 'yes'
-- ui_page 'nui/index.html'

files {
	"nui/**/*"
}

lua54 'yes'
escrow_ignore {
	"nui/**/*",
	"config.lua",
	"server.lua",
	"client.lua",
	
}
dependency '/assetpacks'
dependency '/assetpacks'