fx_version 'bodacious'
games { 'gta5' }

description 'ESX THIEF - redigeret af MarDev'

version '1.0.0'

shared_script {
	'@es_extended/locale.lua',
	'locales/da.lua',
    'config.lua',
}

client_scripts {
    'client/main.lua',
	'client/headclient.lua'
}

server_scripts {
	'server/main.lua',
	'server/headserver.lua'
}

ui_page('index.html')

files {
    'index.html'
}

dependency 'es_extended'