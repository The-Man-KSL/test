local InGame = false
local ZoneCoords = {x = 1014.118, y = -3142.056, z = 5.900771}
local radius = 300.0
local modelids = {}
local randomitem
local kills = 0
local playersingame = 0
local canAddKill = true
local cam = nil
local hungergameslobby = false
local coordsbefore = nil
local Data
local ESX = nil


Citizen.CreateThread(function()
    if Config.OLDESX then 
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    else
        ESX = exports["crm-core"]:getSharedObject()
    end
end)

local randomloots = {
    {name = 'WEAPON_CARBINERIFLE', amount = 1, ammoname = 'ammo-9', ammoamount = 88 },
    {name = 'WEAPON_SPECIALCARBINE', amount = 1, ammoname = 'ammo-9', ammoamount = 88 },
    {name = 'WEAPON_PISTOL', amount = 1, ammoname = 'ammo-9', ammoamount = 88 },
    {name = 'armour', amount = 1, ammoname = nil, ammoamount = 0 },
    --{name = 'WEAPON_SMG', amount = 1, ammoname = 'ammo-rifle', ammouamount = 88 },
}


function Draw3DText(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local p = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	local scale = (1 / distance) * 0.68
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov 
	if onScreen then
	SetTextScale(0.0, scale)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 210)
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	end
end



RegisterCommand('hg', function()
    if Config.OnlyCoords.Enabled then 
        print(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.OnlyCoords.Coords.x, Config.OnlyCoords.Coords.y, Config.OnlyCoords.Coords.z))
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.OnlyCoords.Coords.x, Config.OnlyCoords.Coords.y, Config.OnlyCoords.Coords.z) < Config.OnlyCoords.Distance then 
            if not InGame then
                ESX.TriggerServerCallback('hungergames:getdatawins', function(data)  
                
                    if Config.CheckInventory then 
                        if json.encode(exports.ox_inventory:GetPlayerItems()) ~= '[]' then 
                            ShowSubtitle(Config.Language.ClearInventory, 4800)
                        else
                            coordsbefore = GetEntityCoords(GetPlayerPed(-1))
                            SendNUIMessage({
                                type = 'lobbyscreen',
                                wins = data
                            })
                            StartFreeCam(68)
                            hungergameslobby = true
                            SetNuiFocus(true,true)
                            NetworkStartSoloTutorialSession()
                        end 
                    else
                        coordsbefore = GetEntityCoords(GetPlayerPed(-1))
                        SendNUIMessage({
                            type = 'lobbyscreen',
                            wins = data
                        })
                        StartFreeCam(68)
                        hungergameslobby = true
                        SetNuiFocus(true,true)
                        NetworkStartSoloTutorialSession()
                    end
                end)
            end
        else
            ShowSubtitle('Cant use it here!', 2800)
        end
    else
        if not InGame then
            ESX.TriggerServerCallback('hungergames:getdatawins', function(data)  
                if Config.CheckInventory then 
                    if json.encode(exports.ox_inventory:GetPlayerItems()) ~= '[]' then 
                        ShowSubtitle(Config.Language.ClearInventory, 4800)
                    else
                        coordsbefore = GetEntityCoords(GetPlayerPed(-1))
                        SendNUIMessage({
                            type = 'lobbyscreen',
                            wins = data
                        })
                        StartFreeCam(68)
                        hungergameslobby = true
                        SetNuiFocus(true,true)
                        NetworkStartSoloTutorialSession()
                    end 
                else
                    coordsbefore = GetEntityCoords(GetPlayerPed(-1))
                    SendNUIMessage({
                        type = 'lobbyscreen',
                        wins = data
                    })
                    StartFreeCam(68)
                    hungergameslobby = true
                    SetNuiFocus(true,true)
                    NetworkStartSoloTutorialSession()
                end
            end)
        end
    end
end, false)

RegisterNUICallback('dataleaderboard', function(data,cb)
    local topid = 0
    ESX.TriggerServerCallback('hungergames:getdatatoplist', function(data)  
        for k,v in pairs(data) do 
            topid = topid + 1
            SendNUIMessage({
                type = 'topdata',
                identifier = v.identifier,
                name = v.name,
                wins = v.wins,
                Topid = topid
            })
        end
    end)
end)



RegisterNUICallback("leavelobby", function(data,cb)
    SetNuiFocus(false,false)
    DestroyCam(cam, false)
    ClearFocus()
    RenderScriptCams(false, false, 0, true, false)
    SetTimecycleModifier(0)
    NetworkEndTutorialSession()
    hungergameslobby = false
    SetEntityCoords(GetPlayerPed(-1), coordsbefore)
    TriggerServerEvent('hungergames:deleteid')
    ShowSubtitle(Config.Language.LobbyLeft, 2800)
end)

RegisterNUICallback("joingame", function(data,cb)
    if Config.CheckInventory then 
        if json.encode(exports.ox_inventory:GetPlayerItems()) ~= '[]' then 
            ShowSubtitle(Config.Language.ClearInventory, 4800)
        else
            TriggerServerEvent('hungergames:join')
        end
    else
        TriggerServerEvent('hungergames:join')
    end
end)


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
            if DoesCamExist(cam) then
            SetUseHiDof()
            end
        if hungergameslobby then 
            DisableControlAction(0, 30, true)
            DisableControlAction(0, 31, true)
            DisableControlAction(0, 32, true)
            DisableControlAction(0, 33, true)
        else
            Citizen.Wait(480)
        end
    end
end)

function StartFreeCam(fov)
    SetEntityCoords(GetPlayerPed(-1), 159.6476, -735.3879, 246.1521)
    SetEntityHeading(GetPlayerPed(-1), 166.0)
    SetTimecycleModifier(0)  
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 158.3054, -742.0021, 246.1522 + 0.08, 0, 90, 0, fov * 0.48)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 0, true, true)
    PointCamAtEntity(cam, GetPlayerPed(-1), 0, 0, 0, true)
    SetCamUseShallowDofMode(cam, true)

    -- This sets at what distance your camera should start to focus (Example: 0.7 meters)
    SetCamNearDof(cam, 0.7)

    -- This sets at what distance your camera should stop focusing (Example: 1.3 meters)
    SetCamFarDof(cam, 6.8)

    -- Tell the camera to 100% follow our DOF instructions
    SetCamDofStrength(cam, 0.28)

    SetCamAffectsAiming(cam, false)
    ShakeCam(cam, "FAMILY5_DRUG_TRIP_SHAKE", 0.02)
    ClearFocus()
end

function ShowSubtitle(message, duration)
    BeginTextCommandPrint('STRING')
    AddTextComponentString(message)
    EndTextCommandPrint(duration, true)
end

RegisterNetEvent('joinedHungerGames')
AddEventHandler('joinedHungerGames', function(info, playercount, maxplayers)
    if info == 'joined' then 
        ShowSubtitle(Config.Language.Joined, 4800) 
    elseif info == 'notjoined' then
        ShowSubtitle(Config.Language.LobbyFull, 4800) 
    elseif info == 'already' then
        ShowSubtitle(Config.Language.AlreadyJoined, 4800) 
    elseif info == 'started' then
        ShowSubtitle(Config.Language.InProgress, 4800) 
    end
end)


RegisterNetEvent('startHungerGames')
AddEventHandler('startHungerGames', function(position)
    SetNuiFocus(false,false)
    DestroyCam(cam, false)
    ClearFocus()
    RenderScriptCams(false, false, 0, true, false)
    SetTimecycleModifier(0)
    NetworkEndTutorialSession()
    hungergameslobby = false
    if Config.CheckInventory then 
        if json.encode(exports.ox_inventory:GetPlayerItems()) ~= '[]' then 
            ShowSubtitle(Config.Language.Gamenotinvclear, 4800)
            TriggerServerEvent('hungergames:deleteid')
        else
            NetworkEndTutorialSession()
            SendNUIMessage({
                type = 'text',
                text = Config.Language.Started
            })
            SendNUIMessage({
                type = 'ui'
            })
            InGame = true
            radius = 300.0
            SetEntityCoords(GetPlayerPed(-1), position.x, position.y, position.z)
            
            RequestModel(2433343420)
            while not HasModelLoaded(2433343420) do 
                Citizen.Wait(0)
            end
        
            for k,v in pairs(Config.LootLocations) do 
                objectid = CreateObject(2433343420, v.x, v.y, v.z - 1, false, false, false)
                table.insert(modelids, objectid)
            end
        end
    else
        NetworkEndTutorialSession()
        SendNUIMessage({
            type = 'text',
            text = Config.Language.Started
        })
        SendNUIMessage({
            type = 'ui'
        })
        InGame = true
        radius = 300.0
        SetEntityCoords(GetPlayerPed(-1), position.x, position.y, position.z)
        
        RequestModel(2433343420)
        while not HasModelLoaded(2433343420) do 
            Citizen.Wait(0)
        end
    
        for k,v in pairs(Config.LootLocations) do 
            objectid = CreateObject(2433343420, v.x, v.y, v.z - 1, false, false, false)
            table.insert(modelids, objectid)
        end
    end
end)

RegisterNetEvent('hungergames:notifications')
AddEventHandler('hungergames:notifications', function(message)
    ShowSubtitle(message, 4800) 
end)


RegisterNetEvent('hungergames:gameend')
AddEventHandler('hungergames:gameend', function()
    RequestNamedPtfxAsset("proj_xmas_firework")
    while not HasNamedPtfxAssetLoaded("proj_xmas_firework") do
        Citizen.Wait(8)
    end
    local particleEffects = {}
    local smoke4
    for k,v in pairs(modelids) do
        DeleteObject(v)
    end

    ShowSubtitle(Config.Language.GameEnded, 4800)
    SendNUIMessage({
        type = 'text',
        text = Config.Language.Victory
    })
    InGame = false
    for x= 0, 28 do 
        coords = GetEntityCoords(GetPlayerPed(-1))
        SetPtfxAssetNextCall("proj_xmas_firework")
        local smoke4 = StartParticleFxLoopedAtCoord("scr_firework_xmas_spiral_burst_rgw", coords.x, coords.y, coords.z + 20  , 0.0, 0.0, 0.0, 4.8, false, false, false, false)
        Citizen.Wait(480)
    end
    Citizen.Wait(4000)
    SendNUIMessage({
        type = 'uihide',
    })
    StopParticleFxLooped(smoke4, 0)
    SetEntityCoords(GetPlayerPed(-1), coordsbefore.x, coordsbefore.y, coordsbefore.z)
end)


RegisterNetEvent('hungergames:removed')
AddEventHandler('hungergames:removed', function()
    if InGame then 
        SendNUIMessage({
            type = 'text',
            text = Config.Language.Eliminated
        })
        Citizen.Wait(4800)
        SendNUIMessage({
            type = 'uihide',
        })
        InGame = false
        SetEntityCoords(GetPlayerPed(-1), coordsbefore.x, coordsbefore.y, coordsbefore.z)
        for k,v in pairs(modelids) do
            DeleteObject(v)
        end
        Citizen.Wait(800)
        if Config.RevivePlayerAfterDeath then 
            print(GetPlayerServerId(PlayerId()))
            TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(PlayerId()))  -- YOUR EVENT TO REVIVE A PLAYER
        end
    else
        Citizen.Wait(400)
    end
end)



Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if InGame then 
            DrawMarker(28, ZoneCoords.x, ZoneCoords.y, ZoneCoords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, radius, radius, radius, 204, 204, 0, 100, false, true, 2, false, false, false, false)
            for k,v in pairs(modelids) do 
                coordsobject = GetEntityCoords(v)
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(v)) < 2 then 
                    Draw3DText(coordsobject.x, coordsobject.y, coordsobject.z + 0.88, Config.Language.Open)
                    if IsControlJustPressed(0,38) then 
                        local items = {}
                        for k,v in pairs(randomloots) do 
                            table.insert(items, k)
                        end
                        randomitem = randomloots[items[math.random(#items)]]
                        TriggerServerEvent('hungergames:addloot', randomitem.name, randomitem.amount, randomitem.ammoname, randomitem.ammoamount)
                        DeleteObject(v)
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(80)
        if InGame then 
            if radius >= 0.4 then 
                radius = radius - 0.1     
            end
        end
    end
end)
 


function RespawnPed(ped, coords, heading)
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
    SetPlayerInvincible(ped, false)
    ClearPedBloodDamage(ped)
  
    TriggerServerEvent('esx:onPlayerSpawn')
    TriggerEvent('esx:onPlayerSpawn')
    TriggerEvent('playerSpawned')
  end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000)
        if InGame then 
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), ZoneCoords.x, ZoneCoords.y, ZoneCoords.z) >= radius then 
                SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) - 20)
            end
            if IsEntityDead(GetPlayerPed(-1)) then
                local entity = GetPedSourceOfDeath(PlayerPedId())
                if entity ~= 0 and canAddKill then 
                    local id = GetPlayerServerId(NetworkGetEntityOwner(entity))
                    TriggerServerEvent('hungergames:killerid', id)
                    canAddKill = false
                end
                TriggerServerEvent('hungergames:deleteid')

                if Config.RevivePlayerAfterDeath then 
                    Citizen.Wait(4800)
                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
                
                
                    local formattedCoords = {x = ESX.Math.Round(coords.x, 1), y = ESX.Math.Round(coords.y, 1), z = ESX.Math.Round(coords.z, 1)}
                
                    RespawnPed(playerPed, formattedCoords, 0.0)
                    ClearTimecycleModifier()
                    SetPedMotionBlur(playerPed, false)
                    ClearExtraTimecycleModifier()
                    DoScreenFadeIn(800)
                end
                Citizen.Wait(4800)
            else
                canAddKill = true
            end
        end
    end
end)


RegisterCommand('leavehunger', function()
    if InGame then 
        TriggerServerEvent('hungergames:deleteid')
        InGame = false
        SendNUIMessage({
            type = 'uihide',
        })
        SetEntityCoords(GetPlayerPed(-1), coordsbefore.x, coordsbefore.y, coordsbefore.z)
        for k,v in pairs(modelids) do
            DeleteObject(v)
        end
    end
end, false)

RegisterNetEvent('hungergames:addkillclient')
AddEventHandler('hungergames:addkillclient', function()
    kills = kills + 1
    if InGame then 
        SendNUIMessage({
            type = 'ui',
            Kills = kills
        })
    end
end)

RegisterNetEvent('hungergames:playercount')
AddEventHandler('hungergames:playercount', function(players)
    playersingame = players 
    if InGame then 
        SendNUIMessage({
            type = 'ui',
            Playersingame = playersingame
        })
    end
end)

