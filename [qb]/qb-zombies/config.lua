--[[ Default Config Settings ]]--
Config = {}
Config.Debug = false						-- Set to true for debuging.
Config.NoPeds = false						-- Set to true for no peds.
Config.MuteAmbience = true						-- Set to true to mute ambience.
Config.NotHealthRecharge = true						-- Set true to not all health auto recharge.

--[[ Zombie Spawn Config Settings ]]--
Config.SpawnZombie = 30 						-- Number of zombies to spawn per player.
Config.MinSpawnDistance = 1 						-- Minimum distance zombies spawn from player.
Config.MaxSpawnDistance = 42						-- Max distance zombies spawn from player.
Config.DespawnDistance = 80 						-- How far away the zombies spawn.

--[[ Zombie Loot Config Settings ]]--
Config.ZombieDropLoot = true -- For zombies to drop loot, set to true.
Config.RandomChance = math.random(1, 100)  				-- Random number for giveaway chance.
Config.ItemAmount = math.random(1,2) 				-- Random number for the ammout of item given.
Config.AddtionalItem = true 					-- Set to true to give extra item on loot.
Config.AddItem = 'heavyarmor' 					-- Extra item to give player.
Config.AddItemAmount = math.random(1,2) 				-- Random number for the ammout of extra item given.
Config.ProbabilityMoneyLoot = 80 						-- 33 = 30%
Config.ProbabilityItemLoot = 80 						-- 53-33 = 20%

--[[ Zombie Loot Items Config Settings ]]--
Config.Items = {
	[1] = "pistol_ammo",
	[2] = "rifle_ammo",
	[3] = "smg_ammo",
	[4] = "weapon_compactrifle",
	[5] = "tosti",
	[6] = "twerks_candy",
	[7] = "weapon_gusenberg",
	[8] = "sandwich",
	[9] = "water_bottle",
	[10] = "kurkakola",
	[11] = "fishingbait",
	[12] = "lockpick",
	[13] = "firework1",
	[14] = "cleaningkit",
	[15] = "lockpick",
	[16] = "electronickit",
	[17] = "trojan_usb",
	[18] = "advancedrepairkit",
	[19] = "bandage",
	[20] = "painkillers",
}

--[[ Zombie Safezone Config Settings ]]--
Config.SafeZone = true						-- Set to true to activate for safezones.
Config.SafeZoneRadioBlip = false						-- Set to true to activate safezone blips.

--[[ Zombie Safezone Location Settings ]]--
Config.SafeZoneCoords = {
	{x = 227.67, y = -877.97, z = 30.49, radio = 4200},
	{x = 351.34, y = 3564.28, z = 33.57, radio = 4200}
	
}

--[[ Zombie Area Config Settings ]]
Config.ZombieArea = {
    center = {x = 4510.6582, y = -4492.4946, z = 4.1904},
    heading = 107.0510,
    radius = 1000
}

-- Corpse handling
Config.MaxCorpses = 10 -- Maximum number of dead zombie bodies allowed in the world at once. Oldest are removed when exceeded.
