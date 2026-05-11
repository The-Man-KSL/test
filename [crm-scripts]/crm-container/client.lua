local ESX = nil
ESX = exports["crm-core"]:getSharedObject()

local prop 
local parachute 
local TestObject


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.ESXT, function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


function Draw3DText(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z) 
	local p = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	local scale = (1 / distance) * 1.88
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov 
	if onScreen then
	SetTextScale(0.0, scale)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)  	DrawText(_x, _y)
	end
end

function ShowSubtitle(message, duration)
    BeginTextCommandPrint('STRING')
    AddTextComponentString(message)
    EndTextCommandPrint(duration, true)
end


AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    DeleteObject(Bombobject)
    DeleteVehicle(Car)
    DeleteObject(ElectricBoxObject)
    DeleteObject(TestObject)
    DeleteObject(parachute)
    DeleteObject(prop)
end)

function LoadAnimationDictionary(animationD)
	RequestAnimDict(animationD)
	while not HasAnimDictLoaded(animationD) do
		Citizen.Wait(1)
	end
end

function RequestTextureDictionary (dict)
	RequestStreamedTextureDict(dict)

	while not HasStreamedTextureDictLoaded(dict) do Citizen.Wait(0) end

	return dict
end

function LoadModel (model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(1)
	end
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(50)
    end
end
local random_elem

local opening = false

RegisterNetEvent('a_container_opening:open')
AddEventHandler('a_container_opening:open', function()
    opening = true
    DisplayRadar(false)
    if Config.GiveWeaponToPed then 
        GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_CARBINERIFLE'), 288, true, true)
    end
    coords = GetEntityCoords(GetPlayerPed(-1))
    NetworkStartSoloTutorialSession()
    local items = {}
    for k,v in pairs(Config.Items) do 
        table.insert(items, k)
    end
    random_elem = Config.Items[items[math.random(#items)]]
    SetEntityCoords(GetPlayerPed(-1), -1646.152, -2747.662, 12.97399)
    SetEntityHeading(GetPlayerPed(-1), 330.0)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    RequestModel(2202902697)
    while not HasModelLoaded(2202902697) do
        Wait(15)
    end

    RequestModel(GetHashKey(random_elem.prop))
    while not HasModelLoaded(GetHashKey(random_elem.prop)) do
        Wait(15)
    end


    RequestModel(2568473661)
    while not HasModelLoaded(2568473661) do
        Wait(15)
    end



    TestObject = CreateObject(2202902697, -1638.115, -2733.516, 12.94471 + 8, false, false, false)



    SetEntityHeading(TestObject, -32.0)
    ApplyForceToEntity(TestObject, 0, -1638.115, -2733.516, 12.94471 + 4, 0,0,0, 0, false, false, false, false, false)
    if not Config.AutoOpen then 
        ShowSubtitle('~b~Shoot ~w~the ~w~container', 8000)
    end
    Citizen.Wait(1280)
    ShakeGameplayCam('JOLT_SHAKE', 0.88)

    RequestNamedPtfxAsset("core")
    while not HasNamedPtfxAssetLoaded("core") do
        Citizen.Wait(0)
    end


    if not Config.AutoOpen then 
        SetPtfxAssetNextCall("core")
        Citizen.Wait(200)
        local smoke2 = StartParticleFxLoopedAtCoord("exp_grd_flare", -1636.622, -2737.162, 12.9447 -1 , 0.0, 0.0, 0.0, 2.8, false, false, false, false)
        Citizen.Wait(200)
        SetPtfxAssetNextCall("core")
        local smoke = StartParticleFxLoopedAtCoord("exp_grd_flare", -1638.115 - 4, -2733.516, 12.94471 - 1 , 0.0, 0.0, 0.0, 2.8, false, false, false, false)
    else
        SetPtfxAssetNextCall("core")
        Citizen.Wait(200)
        local smoke2 = StartParticleFxLoopedAtCoord("ent_sht_flame", -1636.622, -2737.162, 12.9447 -1 , 0.0, 0.0, 0.0, 4.8, false, false, false, false)
        Citizen.Wait(200)
        SetPtfxAssetNextCall("core")
        local smoke = StartParticleFxLoopedAtCoord("ent_sht_flame", -1638.115 - 4, -2733.516, 12.94471 - 1 , 0.0, 0.0, 0.0, 4.8, false, false, false, false)

    end

   
    Citizen.Wait(10000)
    StopParticleFxLooped(smoke, 0)
    StopParticleFxLooped(smoke2, 0)
    StopParticleFxLooped(smoke4, 0)
end)



Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if TestObject then 
            SetEntityHeading(TestObject, -32.0)
            if GetEntityHealth(TestObject) <= 680 then 
                local particleDictionary = "core"
                local particleName = "exp_grd_plane"
                local particleName2 = "fire_petroltank_car"
                local particleEffects = {}
                local loopAmount = 1
                ShakeGameplayCam('JOLT_SHAKE', 0.88)
                RequestNamedPtfxAsset(particleDictionary)
                while not HasNamedPtfxAssetLoaded(particleDictionary) do
                    Citizen.Wait(0)
                end
                RequestNamedPtfxAsset("proj_xmas_firework")
                while not HasNamedPtfxAssetLoaded("proj_xmas_firework") do
                    Citizen.Wait(0)
                end
                if Config.EnableParticleFX then 
                    for x=0,loopAmount do
                        UseParticleFxAssetNextCall(particleDictionary)
                        local particle = StartParticleFxLoopedOnEntity(particleName, TestObject, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, false, false, false)
                        table.insert(particleEffects, 1, particle)
                        Citizen.Wait(0)
                    end
                end
                coordsobject = GetEntityCoords(TestObject)
                DeleteEntity(TestObject)
                ShowSubtitle('', 0)
                TestObject = CreateObject(2568473661, coordsobject.x, coordsobject.y, coordsobject.z , false, false, false)
                SetEntityHeading(TestObject, -32.0)
                Citizen.Wait(1000)
                if Config.EnableParticleFX then 
                    for _,particle in pairs(particleEffects) do
                        StopParticleFxLooped(particle, true)
                    end
                end
                coordsobject = GetEntityCoords(TestObject)
                prop = CreateObject(GetHashKey(random_elem.prop), coordsobject.x, coordsobject.y, coordsobject.z + 1 , false, false, false)
                TriggerServerEvent('a_container_opening:giveitem', random_elem.itemname, random_elem.amount)
                Citizen.Wait(1000)
                for x= 0, 8 do 
                    SetPtfxAssetNextCall("proj_xmas_firework")
                    local smoke4 = StartParticleFxLoopedAtCoord("scr_firework_xmas_spiral_burst_rgw", -1635.739, -2729.319, 13.98119 + 8  , 0.0, 0.0, 0.0, 4.8, false, false, false, false)
                end
                Citizen.Wait(4000)
                StopParticleFxLooped(smoke4, 0)
                DeleteEntity(TestObject)
                DeleteEntity(parachute)
                DeleteObject(prop)
                ClearPedTasks(GetPlayerPed(-1))
                FreezeEntityPosition(GetPlayerPed(-1), false)
                TestObject = nil
                prop = nil
                SetEntityCoords(GetPlayerPed(-1), coords.x, coords.y, coords.z - 0.8)
                if Config.GiveWeaponToPed then 
                    RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_CARBINERIFLE'))
                end
                NetworkEndTutorialSession()
                opening = false
                DisplayRadar(true)
            end
        else
            Citizen.Wait(400)
        end
    end
end)


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if opening then 
            DisableControlAction(0, 289)
        end
        if prop then 
            coordsprop = GetEntityCoords(prop)
            Draw3DText(coordsprop.x, coordsprop.y, coordsprop.z + 0.88, 'You have ~y~WON!')
            Draw3DText(coordsprop.x, coordsprop.y, coordsprop.z + 0.48, '~b~' ..  random_elem.amount ..  'x ~w~' .. random_elem.name)
        else
            Citizen.Wait(400)
        end
    end
end)








