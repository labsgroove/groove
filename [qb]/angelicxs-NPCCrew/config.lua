----------------------------------------------------------------------
-- Thanks for supporting AngelicXS Scripts!							--
-- Support can be found at: https://discord.gg/tQYmqm4xNb			--
-- More paid scripts at: https://angelicxs.tebex.io/ 				--
-- More FREE scripts at: https://github.com/GouveiaXS/ 				--
-- Images are provided for new items if you choose to add them 		--
----------------------------------------------------------------------

-- Model info: https://docs.fivem.net/docs/game-references/ped-models/
-- Blip info: https://docs.fivem.net/docs/game-references/blips/

Config = {}

Config.UseESX = false						-- Use ESX Framework
Config.UseQBCore = true						-- Use QBCore Framework (Ignored if Config.UseESX = true)

Config.UseCustomNotify = false				-- Use a custom notification script, must complete event below.
-- Only complete this event if Config.UseCustomNotify is true; mythic_notification provided as an example
RegisterNetEvent('angelicxs-NPCCrew:CustomNotify')
AddEventHandler('angelicxs-NPCCrew:CustomNotify', function(message, type)
    --exports.mythic_notify:SendAlert(type, message, 4000)
    --exports['okokNotify']:Alert('', message, 4000, type, false)
end)

Config.NHMenu = false						-- Use NH-Menu [https://github.com/whooith/nh-context]
Config.QBMenu = true						-- Use QB-Menu (Ignored if Config.NHMenu = true) [https://github.com/qbcore-framework/qb-menu]
Config.OXLib = false						-- Use the OX_lib (Ignored if Config.NHInput or Config.QBInput = true) [https://github.com/overextended/ox_lib]  !! must add shared_script '@ox_lib/init.lua' and lua54 'yes' to fxmanifest!!

-- Visual Preference
Config.Use3DText = false 					-- Use 3D text for NPC/Job interactions; only turn to false if Config.UseThirdEye is turned on and IS working.
Config.UseThirdEye = true 					-- Enables using a third eye (third eye requires the following arguments debugPoly, useZ, options {event, icon, label}, distance)
Config.ThirdEyeName = 'qb-target' 			-- Name of third eye aplication


Config.NPCCrew ={
    ['ballas'] = {                                              -- Crew Name
        ['CrewBosses'] = {                                      -- Crewboss information, can have multiple loctions, spawn is where the peds come from
            {boss = vector4(4502.3047, -4530.6938, 4.1719, 193.3836), spawn = vector4(4510.8247, -4522.3389, 4.1606, 236.4138), model = 'goat'},
        },
        ['CrewInfo'] = {                                        -- Number of crew NPC provided and the cost
            {number = 1, cost = 5000},
            {number = 2, cost = 10000},
            {number = 3, cost = 15000},
            {number = 4, cost = 16000},
            {number = 5, cost = 17000},
            {number = 6, cost = 18000},
            {number = 7, cost = 19000},
            {number = 8, cost = 20000},
            {number = 9, cost = 21000},
            {number = 10, cost = 22000},
        },
        ['HostileGang'] = true,                                -- If true will be hostile to other crews/gangs (in this list) on sight
        ['ModelTypes'] = {                                      -- List of model types that a gang member may spawn as
            'a_c_retriever',
            'a_c_rottweiler',
            'a_c_husky',
            'a_c_shepherd',
            'a_c_chop',
        },
        ['PedWeapons'] = { 
            'weapon_unarmed',                                     -- List of weapons gang member may spawn with
        },
        ['BlipSprite'] = 442,                                    -- Sprite for blips for each boss location, if not desired turn to FALSE to turn off blips
        ['BlipName'] = 'Ballas Crewboss',                       -- Name of blips
        ['BlipColour'] = 27,                                     -- Colour of blips
    },
    ['lostmc'] = {                                                -- Crew Name
        ['CrewBosses'] = {                                      -- Crewboss information, can have multiple loctions, spawn is where the peds come from
            {boss = vector4(984.4580, -100.3600, 74.8455, 309.7283), spawn = vector4(973.8644, -101.7174, 74.8495, 311.8285), model = 'g_m_y_salvaboss_01'},
        },
        ['CrewInfo'] = {                                        -- Number of crew NPC provided and the cost
        {number = 1, cost = 5000},
        {number = 2, cost = 10000},
        {number = 3, cost = 15000},
        {number = 4, cost = 20000},
        {number = 5, cost = 25000},
        {number = 6, cost = 30000},
        {number = 7, cost = 35000},
        {number = 8, cost = 40000},
        {number = 9, cost = 45000},
        {number = 10, cost = 50000},
        },
        ['HostileGang'] = true,                                -- If true will be hostile to other crews/gangs (in this list) on sight
        ['ModelTypes'] = {                                      -- List of model types that a gang member may spawn as
            'g_f_y_lost_01',
            'g_m_y_lost_01',
            'g_m_y_lost_02',
            'g_m_y_lost_03',
        },
        ['PedWeapons'] = {                                      -- List of weapons gang member may spawn with
            'weapon_microsmg',
            'weapon_specialcarbine_mk2',
        },
        ['BlipSprite'] = 84,                                    -- Sprite for blips for each boss location, if not desired turn to FALSE to turn off blips
        ['BlipName'] = 'Lost MC',                         -- Name of blips
        ['BlipColour'] = 40,                                     -- Colour of blips
    },
    
    ['cartel'] = {                                                -- Crew Name      !!!! 'none' crews can be hired by anyone not in a gangs (for ESX not in one of the gangs above) !!!!
        ['CrewBosses'] = {                                      -- Crewboss information, can have multiple loctions, spawn is where the peds come from
            {boss = vector4(-1137.2078, -1718.6794, 4.8529, 29.6138), spawn = vector4(-1129.7343, -1712.6266, 4.3038, 340.9915), model = 'g_m_m_chiboss_01'},
        },
        ['CrewInfo'] = {                                        -- Number of crew NPC provided and the cost
        {number = 1, cost = 5000},
        {number = 2, cost = 10000},
        {number = 3, cost = 15000},
        {number = 4, cost = 16000},
        {number = 5, cost = 17000},
        {number = 6, cost = 18000},
        {number = 7, cost = 19000},
        {number = 8, cost = 20000},
        {number = 9, cost = 21000},
        {number = 10, cost = 22000},
        },
        ['ModelTypes'] = {                                      -- List of model types that a gang member may spawn as
            'a_c_cat_01',
        },
        ['PedWeapons'] = {                                      -- List of weapons gang member may spawn with
            'weapon_unarmed',
        },
        ['BlipSprite'] = 442,                                    -- Sprite for blips for each boss location, if not desired turn to FALSE to turn off blips
        ['BlipName'] = 'Crewboss',                              -- Name of blips
        ['BlipColour'] = 24,                                     -- Colour of blips
    },

    ['pm'] = {                                                -- Crew Name      !!!! 'none' crews can be hired by anyone not in a gangs (for ESX not in one of the gangs above) !!!!
    ['CrewBosses'] = {                                      -- Crewboss information, can have multiple loctions, spawn is where the peds come from
        {boss = vector4(449.0896, -974.4630, 30.6896, 167.9543), spawn = vector4(451.4448, -976.1131, 30.6896, 93.0731), model = 's_m_y_cop_01'},
    },
    ['CrewInfo'] = {                                        -- Number of crew NPC provided and the cost
        {number = 1, cost = 5000},
        {number = 2, cost = 10000},
        {number = 3, cost = 15000},
        {number = 4, cost = 20000},
        {number = 5, cost = 25000},
        {number = 6, cost = 30000},
        {number = 7, cost = 35000},
        {number = 8, cost = 40000},
        {number = 9, cost = 45000},
        {number = 10, cost = 50000},
    },
    ['ModelTypes'] = {                                      -- List of model types that a gang member may spawn as
            's_m_y_swat_01',
    },
    ['PedWeapons'] = {                                      -- List of weapons gang member may spawn with
        'weapon_heavysniper_mk2',
        'weapon_specialcarbine_mk2',
    },
    ['BlipSprite'] = 84,                                    -- Sprite for blips for each boss location, if not desired turn to FALSE to turn off blips
    ['BlipName'] = 'Crewboss',                              -- Name of blips
    ['BlipColour'] = 2,                                     -- Colour of blips
},

['exe'] = {                                                -- Crew Name      !!!! 'none' crews can be hired by anyone not in a gangs (for ESX not in one of the gangs above) !!!!
    ['CrewBosses'] = {                                      -- Crewboss information, can have multiple loctions, spawn is where the peds come from
        {boss = vector4(-1825.1111, 3015.4851, 32.8102, 150.0922), spawn = vector4(-1869.8326, 2954.8232, 32.8103, 330.7000), model = 's_m_y_marine_03'},
    },
    ['CrewInfo'] = {                                        -- Number of crew NPC provided and the cost
        {number = 1, cost = 5000},
        {number = 2, cost = 10000},
        {number = 3, cost = 15000},
        {number = 4, cost = 20000},
        {number = 5, cost = 25000},
        {number = 6, cost = 30000},
        {number = 7, cost = 35000},
        {number = 8, cost = 40000},
        {number = 9, cost = 45000},
        {number = 10, cost = 50000},
    },
    ['ModelTypes'] = {                                      -- List of model types that a gang member may spawn as
            's_m_y_blackops_01',
            's_m_y_blackops_02',
    },
    ['PedWeapons'] = {                                      -- List of weapons gang member may spawn with
        'weapon_heavysniper_mk2',
        'weapon_specialcarbine_mk2',
    },
    ['BlipSprite'] = 84,                                    -- Sprite for blips for each boss location, if not desired turn to FALSE to turn off blips
    ['BlipName'] = 'Crewboss',                              -- Name of blips
    ['BlipColour'] = 2,                                     -- Colour of blips
},

['bahamas'] = {                                                -- Crew Name      !!!! 'none' crews can be hired by anyone not in a gangs (for ESX not in one of the gangs above) !!!!
    ['CrewBosses'] = {                                      -- Crewboss information, can have multiple loctions, spawn is where the peds come from
        {boss = vector4(-1397.1143, -628.9891, 30.3193, 307.8691), spawn = vector4(-1392.2847, -640.1198, 28.6736, 306.0927), model = 'a_f_y_topless_01'},
    },
    ['CrewInfo'] = {                                        -- Number of crew NPC provided and the cost
        {number = 1, cost = 5000},
        {number = 2, cost = 10000},
        {number = 3, cost = 15000},
        {number = 4, cost = 20000},
        {number = 5, cost = 25000},
        {number = 6, cost = 30000},
        {number = 7, cost = 35000},
        {number = 8, cost = 40000},
        {number = 9, cost = 45000},
        {number = 10, cost = 50000},
    },
    ['ModelTypes'] = {                                      -- List of model types that a gang member may spawn as
            'a_f_y_topless_01',
    },
    ['PedWeapons'] = {                                      -- List of weapons gang member may spawn with
        'weapon_heavysniper_mk2',
        'weapon_specialcarbine_mk2',
    },
    ['BlipSprite'] = 84,                                    -- Sprite for blips for each boss location, if not desired turn to FALSE to turn off blips
    ['BlipName'] = 'Bahamas',                              -- Name of blips
    ['BlipColour'] = 50,                                     -- Colour of blips
},
    
}

-- Language Configuration
Config.LangType = {
	['error'] = 'error',
	['success'] = 'success',
	['info'] = 'primary'
}

Config.Lang = {
	['request_crew_3d'] = 'Aperte ~r~[E]~w~ para contratar sua equipe.',
    ['request_crew'] = 'Contratar equipe',
    ['menu_header'] = "Opções de equipe",
    ['member'] = "Membros de equipe: ",
    ['cost'] = "Preço $ ",
    ['cancel'] = "Sair",
    ['crew_bought'] = "Pronto! Sua equipe está a caminho.",
    ['no_cash'] = "Você precisa de mais dinheiro.",
    ['crew_up'] = 'Ainda existem membros na sua equipe!',
}
