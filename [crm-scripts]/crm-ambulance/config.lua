Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be in order for the markers to be drawn (in GTA units).
Config.Debug                      = ESX.GetConfig().EnableDebug
Config.Marker                     = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}

Config.ReviveReward               = 700  -- Revive reward, set to 0 if you don't want it enabled
Config.SaveDeathStatus              = true -- Save Death Status?
Config.LoadIpl                    = true -- Disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

Config.DistressBlip = {
	Sprite = 310,
	Color = 48,
	Scale = 2.0
}

Config.EarlyRespawnTimer          = 60000 * 1  -- time til respawn is available
Config.BleedoutTimer              = 60000 * 10 -- time til the player bleeds out

Config.EnablePlayerManagement     = false -- Enable society managing (If you are using esx_society).

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = false
Config.RemoveItemsAfterRPDeath    = false

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.OxInventory                = ESX.GetConfig().OxInventory
Config.RespawnPoints = {
	{coords = vector3(48.1494, -57.8828, 4.9391), heading = 114.3618}, -- Central Los Santos
	{coords = vector3(48.5200, -77.3632, 4.9353), heading = 82.0277} -- Sandy Shores
}

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(-1853.2333, -337.9479, 49.4444),
			sprite = 61,
			scale  = 0.7,
			color  = 2
		},

		AmbulanceActions = {
			vector3(-1814.9996, -351.3738, 53.7911)
		},

		Pharmacies = {
			vector3(-1832.8229, -381.5929, 49.3997)
		},

		Vehicles = {
			{
				Spawner = vector3(-1877.2222, -336.0402, -70.8613),
				InsideShop = vector3(-1877.2222, -336.0402, -70.8613),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(-1877.3461, -336.4397, 49.2717), heading = 135.7998, radius = 4.0},
					{coords = vector3(-1879.8643, -334.0232, 49.2511), heading = 140.2441, radius = 4.0},
					{coords = vector3(-1882.1683, -331.9268, 49.2344), heading = 135.3825, radius = 6.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(-1866.6300, -335.4720, 10.8043),
				InsideShop = vector3(-1866.6300, -335.4720, 10.8043),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(-1867.3385, -352.6018, 58.0338), heading = 140.9423, radius = 10.0},
					{coords = vector3(-1820.6873, -371.6404, 58.0639), heading = 134.5661, radius = 10.0}
				}
			}
		},

		FastTravels = {
			{
				From = vector3(88.4134, -63.2356, 4.9397),
				To = {coords = vector3(53.4719, -63.0864, 109.5993), heading = 82.0},
				Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = true}
			},

			{
				From = vector3(275.3, -1361, 23.5),
				To = {coords = vector3(295.8, -1446.5, 28.9), heading = 0.0},
				Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(247.3, -1371.5, 23.5),
				To = {coords = vector3(333.1, -1434.9, 45.5), heading = 138.6},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(335.5, -1432.0, 45.50),
				To = {coords = vector3(249.1, -1369.6, 23.5), heading = 0.0},
				Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(234.5, -1373.7, 20.9),
				To = {coords = vector3(320.9, -1478.6, 28.8), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(317.9, -1476.1, 28.9),
				To = {coords = vector3(238.6, -1368.4, 23.5), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false}
			}
		},

		FastTravelsPrompt = {
			{
				From = vector3(237.4, -1373.8, 26.0),
				To = {coords = vector3(251.9, -1363.3, 38.5), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(256.5, -1357.7, 36.0),
				To = {coords = vector3(235.4, -1372.8, 26.3), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = _U('fast_travel')
			}
		}

	}
}

Config.AuthorizedVehicles = {
	Trainee = {
		{ model = 'emstahoe_hi', label = 'EMS Tahoe', price = 1}, 
        { model = 'emsfpiu', label = 'EMS FPIU', price = 1},
        { model = 'emscharger', label = 'EMS Charger', price = 1}
	},

	emergency_medical_technician = {
		{ model = 'emstahoe_hi', label = 'EMS Tahoe', price = 1}, 
        { model = 'emsfpiu', label = 'EMS FPIU', price = 1},
        { model = 'emscharger', label = 'EMS Charger', price = 1}
	},

	paramedic = {
		{ model = 'emstahoe_hi', label = 'EMS Tahoe', price = 1}, 
        { model = 'emsfpiu', label = 'EMS FPIU', price = 1},
        { model = 'emscharger', label = 'EMS Charger', price = 1}
	},

	paramedic_fto = {
		{ model = 'emstahoe_hi', label = 'EMS Tahoe', price = 1}, 
        { model = 'emsfpiu', label = 'EMS FPIU', price = 1},
        { model = 'emscharger', label = 'EMS Charger', price = 1}
	},

	medic_supervisor = {
		{ model = 'emstahoe_hi', label = 'EMS Tahoe', price = 1}, 
        { model = 'emsfpiu', label = 'EMS FPIU', price = 1},
        { model = 'emscharger', label = 'EMS Charger', price = 1}
	},

	assistant_chief_of_ems = {
		{ model = 'emstahoe_hi', label = 'EMS Tahoe', price = 1}, 
        { model = 'emsfpiu', label = 'EMS FPIU', price = 1},
        { model = 'emscharger', label = 'EMS Charger', price = 1}
	},

	chief_of_ems = {
		{ model = 'emstahoe_hi', label = 'EMS Tahoe', price = 1}, 
        { model = 'emsfpiu', label = 'EMS FPIU', price = 1},
        { model = 'emscharger', label = 'EMS Charger', price = 1}
	}

}

Config.AuthorizedHelicopters = {

	ambulance = {},

	doctor = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 150000 }
	},

	chief_doctor = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 150000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 300000 }
	},

	boss = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 10000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 250000 }
	}

}
