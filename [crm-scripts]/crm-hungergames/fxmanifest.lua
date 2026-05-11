fx_version('cerulean')
games({ 'gta5' })


shared_scripts('config.lua',
'@crm-core/imports.lua');

server_scripts({
    'server.lua',
    'config.lua',
    '@oxmysql/lib/MySQL.lua'
});

ui_page({'html/index.html'})

files({
    'html/index.html',
    'html/style.css',
    'html/index.js',
    'html/winning.mp3'
})

shared_scripts { 
	'@crm-core/imports.lua',
	'@crm-core/locale.lua',
	'config.lua'
}


client_scripts({
    'client.lua',
    'config.lua'
});