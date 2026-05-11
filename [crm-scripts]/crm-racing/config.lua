Config = {}
Config.Database = "oxmysql" -- oxmysql // ghmattimysql // mysql-async
Config.Framework = "esx" -- or esx
Config.ServerName = "CRM" -- your server name
Config.ImageType = "steam" --discord // steam
Config.PlayerWaitTime = 1 -- minute
Config.MinPlayersForStart = 2
Config.VehicleCollision = true
Config.ShowPlayerNamesInRace = true
Config.BlipConfig = {}
Config.MaximumRouteCount = 200
Config.MinimumRouteCountForAddRoute = 5

Config.Texts =  {
    ["inracealready"] = "You're already in a race!",
    ["maxplayers"] = "Max Players",
    ["creatednewrace"] = "Your race has been created!",
    ["notatlocation"] = "You are not in the race location and kicked!",
    ["racestartin"] = "Please follow waypoint. The race will start in",
    ["racedeactivated"] = "Your race has been deactivated!",
    ["finishrace"] = "You finished the race ",
    ["needmoreroute"] = "You need to add some more routes!",
    ["maxroute"] = "Max Route!",
    ["startinrace"] = "Race startin' within ",
    ["createrace"] = "A new race released click to join",
    ["racestartin"] = "Your race startin' within 30 seconds please get in the car and get ready!",
    ["openui"] = {key = "j", text = "Open Racing UI", command = "OpenRace", item = "racing"} -- you can set item = false if you don't want to use item
}

