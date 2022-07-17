--
-- Created by 0TEX0.
-- Basé sur le un menu je sais plus lequel.
-- J'espère que ça vous fera plaisir.
-- Tout est modifiable.
--

fx_version 'adamant'
games {'gta3','gta5'}

author '0TEX0'
version '1.0.0'


--RAGEUI
client_scripts {
    "internal/RageUI/RMenu.lua",
    "internal/RageUI/menu/RageUI.lua",
    "internal/RageUI/menu/Menu.lua",
    "internal/RageUI/menu/MenuController.lua",
    "internal/RageUI/components/*.lua",
    "internal/RageUI/menu/elements/*.lua",
    "internal/RageUI/menu/items/*.lua",
    "internal/RageUI/menu/panels/*.lua",
    "internal/RageUI/menu/windows/*.lua"
}

-- MENU CLIENT
client_scripts { 
    'client/client.lua'
}

shared_scripts {
    'config.lua'
}

--SERVEUR
server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua'
}


dependencies {
    'es_extended'
}
