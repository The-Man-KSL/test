resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'crm'


ui_page 'html/ui.html'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/server.lua'
}

client_scripts {
	'config.lua',
	'client/*.lua',
}

files {
	'html/*.png', 
	'html/*.js',
	'html/index.js',
	'html/*.html',
	'html/ui.html'
}