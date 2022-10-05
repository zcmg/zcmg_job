fx_version 'cerulean'
games { 'gta5' }

author 'zcmg#5307'
description 'v1.3'

shared_scripts {
	'config.lua',
	'@es_extended/imports.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}
