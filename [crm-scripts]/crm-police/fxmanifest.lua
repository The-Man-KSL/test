fx_version 'cerulean'
game 'gta5'
version '1.0,0'
author 'Crm'
url 'https://discord.gg/devcrm'
lua54 'yes'

shared_script '@ox_lib/init.lua'

server_scripts {
    'policeConfig.lua',
    'server/*.lua'
} 

client_scripts {
    'policeConfig.lua',
    'client/*.lua'
}

escrow_ignore {
    'policeConfig.lua',
}

dependencies {
    'ox_lib'
}





 

 


