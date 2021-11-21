fx_version 'adamant'
game 'gta5'

client_scripts {
	'@es_extended/locale.lua',
	'NativeUI.lua',
	'menu.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'server.lua',
	'config.lua',
    '@mysql-async/lib/MySQL.lua'
}

dependencies {
	'es_extended',
	'mysql-async',
	'NativeUI',
	'es_admin2'
}
