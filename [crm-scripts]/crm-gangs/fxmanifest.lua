
lua54 'yes' 




fx_version 'cerulean'
games { 'rdr3', 'gta5' }
client_script '@crm-core/locale.lua'
server_script '@crm-core/locale.lua'
this_is_a_map 'yes'
lua54 'yes'
description 'CRM Scripts'
version '1.0.0'


shared_script '@ox_lib/init.lua'

ui_page {
    'nui/index.html',
}

lua54 'yes'

shared_script '@ox_lib/init.lua'
files {
    'nui/index.html',
    'nui/main.js',
    'nui/main.css',
    'nui/logo.png',
    'nui/gtafont.woff',
    'nui/gtafont.woff2',
}




client_scripts {
    '@crm-core/locale.lua',
    '@crm-core/imports.lua',
    'shared/*.lua',
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@crm-core/locale.lua',
    '@crm-core/imports.lua',
    'shared/*.lua',
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'

}

server_exports {
    'IsRolePresent',
    'GetRoles'
}


export 'GeneratePlate'




exports {
    'AddCircleZone',
    'AddBoxZone',
    'AddPolyZone',
    'RemoveZone'
}



this_is_a_map 'yes'




lua54 'yes'



