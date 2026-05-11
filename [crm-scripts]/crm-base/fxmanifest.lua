resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
this_is_a_map 'yes'

fx_version 'adamant'

game 'gta5'

description 'crm-base'

client_scripts {

	'@crm-core/locale.lua',
	'locales/en.lua',
	'NativeUI.lua',
	'client/*.lua'

}

shared_script 'config.lua'


file 'xml/gabz_timecycle_mods_1.xml'
data_file 'xml/TIMECYCLEMOD_FILE' 'gabz_timecycle_mods_1.xml'

file 'xml/playboisetup2.xml'
data_file 'xml/TIMECYCLEMOD_FILE' 'playboisetup2.xml'

server_scripts {

	'@crm-core/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locales/en.lua',
	'server/*.lua'
}
