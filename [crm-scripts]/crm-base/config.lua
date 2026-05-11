Config = {}

-----------------------------------------
-- Drugs Start
-----------------------------------------

Config.MarkerType   = 1 -- Marker visible or not. -1 = hiden  Set to 1 for a visible marker. To have a list of avaible marker go to https://docs.fivem.net/game-references/markers/
Config.DrawDistance = 100.0 --Distance where the marker be visible from
Config.ZoneSize     = {x = 8.0, y = 8.0, z = 3.0} -- Size of the marker
Config.MarkerColor  = {r = 0, g = 0, b = 0} --Color of the marker

Config.RequiredCopsCoke  = 0 --Ammount of cop that need to be online to be able to harvest/process/sell coke
Config.RequiredCopsSalvia  = 0 --Ammount of cop that need to be online to be able to harvest/process/sell salvia
Config.RequiredCopsEcstasy  = 0 --Ammount of cop that need to be online to be able to harvest/process/sell ecstasy
Config.RequiredCopsMeth  = 0 --Ammount of cop that need to be online to be able to harvest/process/sell meth
Config.RequiredCopsWeed  = 0 --Ammount of cop that need to be online to be able to harvest/process/sell weed
Config.RequiredCopsOpium = 0 --Ammount of cop that need to be online to be able to harvest/process/sell opium

Config.TimeToFarmWeed     = 1.75  * 1000 -- Ammount of time to harvest weed
Config.TimeToProcessWeed  = 5  * 1000 -- Ammount of time to process weed
Config.TimeToSellWeed     = 4  * 1000 -- Ammount of time to sell weed

Config.TimeToFarmOpium    = 1.75  * 1000 -- Ammount of time to harvest coke
Config.TimeToProcessOpium = 5  * 1000 -- Ammount of time to process coke
Config.TimeToSellOpium    = 4  * 1000 -- Ammount of time to sell coke

Config.TimeToFarmCoke     = 1.75  * 1000 -- Ammount of time to harvest coke
Config.TimeToProcessCoke  = 5  * 1000 -- Ammount of time to process coke
Config.TimeToSellCoke     = 4  * 1000 -- Ammount of time to sell coke

Config.TimeToFarmSalvia     = 1.75  * 1000 -- Ammount of time to harvest salvia
Config.TimeToProcessSalvia  = 5  * 1000 -- Ammount of time to process salvia
Config.TimeToSellSalvia     = 4  * 1000 -- Ammount of time to sell salvia

Config.TimeToFarmEcstasy     = 1.75  * 1000 -- Ammount of time to harvest ecstasy
Config.TimeToProcessEcstasy  = 5  * 1000 -- Ammount of time to process ecstasy
Config.TimeToSellEcstasy     = 4  * 1000 -- Ammount of time to sell ecstasy

Config.TimeToFarmMeth     = 1.75  * 1000 -- Ammount of time to harvest meth
Config.TimeToProcessMeth  = 5 * 1000 -- Ammount of time to process meth
Config.TimeToSellMeth     = 4  * 1000 -- Ammount of time to sell meth

Config.Locale = 'en'

Config.Zones = {
	CokeField =			{x=-246.34,  y=368.53,  z=-0.91},
	CokeProcessing =	{x=-238.28,  y=364.29,  z=-0.91},
	CokeDealer =		{x=358.26,    y=54.06,   z=14.91},

    SalviaField =	    {x=430.7,     y=-1741.28,  z=29.6},
	SalviaProcessing =	{x=440.08,    y=-1727.91,  z=29.6},
	SalviaDealer =		{x=-1114.11,    y=-501.12,   z=35.81},

    EcstasyField =	    {x=980.14,     y=-1396.76,  z=31.68},
	EcstasyProcessing =	{x=989.25,    y=-1381.61,  z=31.55},
	EcstasyDealer =		{x=136.43,    y=-1278.82,   z=29.36},

	MethField =			{x=1005.721,  y=-3200.301,  z=-38.519},
	MethProcessing =	{x=1014.878,  y=-3194.871,  z=-38.993},
	MethDealer =		{x=1743.06,      y=-1623.37,   z=112.41},

	WeedField =			{x=-706.1089,  y=2427.4185,  z=13.8422},
	WeedProcessing =	{x=1037.527,  y=-3205.368,  z=-38.17},
	WeedDealer =		{x=214.56, y=135.17, z=14.7},

    OpiumField =        {x=-225.27,   y=-2655.13,   z=6.0},
    OpiumProcessing =   {x=-234.71,   y=-2651.7,   z=6.0},
    OpiumDealer =       {x=-690.94,  y=-1155.59,   z=10.81}
}

-----------------------------------------
-- Drugs End
-----------------------------------------


-----------------------------------------
-- Start Rotating Redzoe
-----------------------------------------


config = {

    -- Use this like for blip and color references: https://docs.fivem.net/docs/game-references/blips/ --
    MarkerDistance = 100.0, -- How far they can see the Marker of the zone (MarkerDistance + Radius of the zone)
    zones = {
        {
            x = 1364.29,
            y = -579.54,
            z = 70.38,
            radius = 150.0,
            color = 1,
            Marker = {
                Type = 1,
                Size = {x = 100.0, y = 100.0, z = 100.0},
                Color = {r = 255, g = 0, b = 0, a = 150}
            }
        }, {
            x = 344.15,
            y = -2040.44,
            z = 19.65,
            radius = 150.0,
            color = 1,
            Marker = {
                Type = 1,
                Size = {x = 100.0, y = 100.0, z = 100.0},
                Color = {r = 255, g = 0, b = 0, a = 150}
            }
        }, {
            x = 961.05,
            y = -1586.37,
            z = 29.65,
            radius = 150.0,
            color = 1,
            Marker = {
                Type = 1,
                Size = {x = 100.0, y = 100.0, z = 100.0},
                Color = {r = 255, g = 0, b = 0, a = 150}
            }
        }, {
            x = -1172.71,
            y = -1572.33,
            z = 2.65,
            radius = 150.0,
            color = 1,
            Marker = {
                Type = 1,
                Size = {x = 100.0, y = 100.0, z = 100.0},
                Color = {r = 255, g = 0, b = 0, a = 150}
            }
        }
    },

    timer = 270, -- How often will the zone change (In Seconds). --

    draw_blip = false, -- If "true" it will draw a blip in center of zone. --

    draw_route = false, -- "draw_blip" must be "true" for this to work. If "true" then it will draw a GPS route to the zone. --

    blip_text = "REDZONE", -- "draw_blip" must be "true" for this to work. This will change the name of the blip on the map. --

}


-----------------------------------------
-- End Rotating Redzoe
-----------------------------------------




-----------------------------------------
-- Start RepairKit
-----------------------------------------

Config.InfiniteRepairs		= false -- Should one repairkit last forever?
Config.RepairTime			= 15 -- In seconds, how long should a repair take?
Config.IgnoreAbort			= true -- Remove repairkit from inventory even if user aborts repairs?
Config.AllowMecano			= false -- Allow mechanics to use this repairkit?

-----------------------------------------
-- End RepairKit
-----------------------------------------