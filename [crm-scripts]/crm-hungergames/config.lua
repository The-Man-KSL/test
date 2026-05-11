Config = {}

Config.OLDESX = false -- USE FALSE FOR OLD ESX //

Config.OnlyCoords = { -- WHERE THE PLAYER CAN USE THE COMMAND ( /hungergames )
    Enabled = false, 
    Coords = vector3(132.306, -1309.271, 28.99515),
    Distance = 200 
}

Config.Positions = {
    {x = 977.087, y = -2952.281, z = 5.907334},
    {x = 1257.087, y = -3178.281, z = 5.907334},
    {x = 1010.087, y = -3343.281, z = 5.907334},
    {x = 739.087, y = -3160.281, z = 5.907334},
    {x = 1177.087, y = -3168.281, z = 5.907334},
    {x = 1186.087, y = -3017.281, z = 5.907334},
} -- MAKE SURE TO HAVE POSITIONS AS MANY AS YOU HAVE MAX PLAYERS, OR ELSE IT WILL NOT WORK! ( FOR EXAMPLE IF YOU HAVE 6 POSITIONS BUT 8 PLAYERS JOINED THE GAME 2 OF THEM WILL NOT SPAWN!)

Config.LootLocations = { -- ADD AS MANY LOOT LOCATIONS AS YOU WANT
    vector3(990.2447, -2981.834, 5.90047),
    vector3(864.7849, -2973.79, 7.475422),
    vector3(892.7546, -3035.43, 5.896654),
    vector3(892.7546, -3035.43, 5.896654),
    vector3(937.4085, -3184.44, 5.897563),
    vector3(1029.746, -3200.033, 5.90077),
    vector3(1118.763, -3193.878, 5.907419),
    vector3(1152.195, -3140.462, 5.891243),
    vector3(1165.124, -3167.062, 5.800608),
    vector3(924.7084, -3208.962, 5.895463),
    vector3(867.8343, -3291.567, 5.881361),
    vector3(1047.119, -3320.853, 5.909547),
    vector3(1086.142, -3256.718, 5.896869),
    vector3(1224.23, -3229.373, 5.917488),
    vector3(885.2202, -3054.198, 5.90716),
    vector3(819.0925, -3114.532, 5.899883),
    vector3(849.7806, -3219.741, 5.892829),
    vector3(829.382, -3288.629, 5.900026),
}

Config.MinPlayers = 1 -- MIN PLAYERS REQUIRED TO START THE HUNGERGAMES

Config.MaxPlayers = 8 -- MAX PLAYERS THAT CAN JOIN!

Config.WinPayment = true
Config.Payamount = 5750000

Config.Language = {
    StartingSoon = 'Hunger Games starting soon!',
    GameEnded = 'The game has ended, YOU HAVE WON!',
    Joined = 'You have joined the Hunger Games lobby! ',
    LobbyFull = 'Lobby FULL!',
    AlreadyJoined = 'Already Joined!',
    InProgress = 'Game in progress!',
    ClearInventory = 'Clear your INVENTORY FIRST!',
    Eliminated = 'Eliminated',
    Victory = 'Victory',
    Started = 'Match Started',
    Gamenotinvclear = 'Your inventory was not clear!',
    Open = '[E] - Open',
    LobbyLeft = 'You have left the lobby!',
}

Config.CheckInventory = true -- OX INVENTORY NEEDED FOR THIS TO WORK!!!! OR EDIT IN THE CLIENT.LUA FILE TO YOUR INVENTORY CHECK

Config.RevivePlayerAfterDeath = true -- REVIVE THE PLAYER AFTER DEATH, IF YOU HAVE DIFFERENT AMBULANCE JOB PLEASE EDIT IT IN THE CLIENT.LUA FILE!
