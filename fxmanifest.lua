fx_version 'cerulean'
games { 'gta5' }

author 'zcmg#5307'
description 'v1.1'

client_scripts {
	'client.lua',
}

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

dependencies {
	'es_extended'
}
