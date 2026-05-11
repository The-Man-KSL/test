fx_version "cerulean"
game "gta5"
author "Csoki"

dependency "crm-core"
dependency "oxmysql"

shared_scripts {
	"@crm-core/imports.lua",
	"@crm-core/locale.lua",
	"locales/*.lua",
	"shared.lua",
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"server.lua"
}

client_script "client.lua"

files {
	"ui/dist/**",
}

ui_page "ui/dist/index.html"
-- ui_page "http://localhost:3000"
