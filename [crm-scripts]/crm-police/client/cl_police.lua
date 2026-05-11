local ESX = exports[Config.ESX]:getSharedObject()
local escorted = false
local blacklisteditem = false

RegisterCommand(Config.Menu.Command, function()
    if ESX.GetPlayerData().job.name == 'police' then
        lib.showMenu('police:menu')
    end 
end)

lib.registerMenu({
    id = 'police:menu',
    title = 'Police Menu',
    position = 'bottom-right',
    options = {
        {label = 'Citizen Menu', close = true},

    },
    }, function(selected)
    if selected == 1 then 
        lib.showMenu('police:citizen')
    end 
end)

lib.registerMenu({
    id = 'police:citizen',
    title = 'Citizen Menu',
    position = 'bottom-right',
    onClose = function(keyPressed)
        lib.showMenu('police:menu')
    end,
    options = {
        {label = 'Search', close = true},
        {label = 'Handcuff',  close = false},
        {label = 'Uncuff', close = false},
        {label = 'Escort', close = false},
        {label = 'Place In Vehicle', close = true},
        {label = 'Remove From Vehicle', close = true},
    }, 
}, function(selected, args)
    local ClosestPlayer = lib.getClosestPlayer(GetEntityCoords(cache.ped), 5, false)
    local target = GetPlayerServerId(ClosestPlayer)
    if selected and not target or target == nil or ClosestPlayer == nil then return
        ESX.ShowNotification('There is no one nearby')
    else
    if selected == 1 then
        local items = lib.callback.await('police:items',false, target, 1)
        local options = {}
        table.insert(options, {
            icon = 'circle-info',
            label = 'removeable items:',
            close = false
        })
        for i=1, #items.accounts, 1 do
            if items?.accounts[i]?.name == 'black_money' and items.accounts[i]?.money > 0 then
                table.insert(options, {
                    icon = 'money-bill',
                    label = ('Dirty Money: %s'):format(items?.accounts[i]?.money),
                    value = 1,
                    amount   = items?.accounts[i].money,
                    close = false
                })
                break
            end
        end
        for i=1, #items.weapons, 1 do
            table.insert(options, {
                icon = "fas fa-gun",
                label    = 'Weapon: '..ESX.GetWeaponLabel(items.weapons[i].name),
                item    = items.weapons[i].name,
                value = 2,
                close = false
            })
        end
        for i=1, #items.inventory, 1 do
            if items.inventory[i].count > 0 then
                table.insert(options, {
                    icon = "fas fa-box",
                    label    = ('Item: %s x%s'):format(items.inventory[i].label,items.inventory[i].count),
                    item    = items.inventory[i].name,
                    value = 3,
                    amount   = items.inventory[i].count,
                    close = false
                })
            end
        end
        lib.registerMenu({
            id = 'police:search',
            title = 'Search',
            position = 'bottom-right',
            onClose = function()
                lib.showMenu('police:citizen')
            end,
            options = options
        },function(selected)
            for z, v in ipairs(Config.BlackListedItems) do 
                if options[selected].item == v then 
                    blacklisteditem = true
                end
            end
            if not blacklisteditem then 
                TriggerServerEvent('police:remove', target, options[selected].item, options[selected].value, options[selected].amount)
            else 
                ESX.ShowNotification('You cannot remove this item')
                blacklisteditem = false
            end
        end)
        Wait(100)
        lib.showMenu('police:search')
    end
    if selected then 
        TriggerServerEvent('police:actions', target, selected)
    end
end
end)

RegisterNetEvent('police:actions')
AddEventHandler('police:actions', function(selected, source)
    if selected == 1 then
    end
    if selected == 2 then 
        if DoesEntityExist(cache.ped) and not IsEntityDead(cache.ped) then
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Wait(100)
            end
            TaskPlayAnim(cache.ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
            FreezeEntityPosition(cache.ped, true)
            LocalPlayer.state:set('iscuffed', true, true)
        end
    end
    if selected == 3 then 
        if DoesEntityExist(cache.ped) and not IsEntityDead(cache.ped) then
            ClearPedTasks(cache.ped)
            FreezeEntityPosition(cache.ped, false)
            LocalPlayer.state:set('iscuffed', false, true)
        end
    end
    if selected == 4 then 
        if escorted == false then
            local player = GetPlayerPed(GetPlayerFromServerId(source))
            AttachEntityToEntity(cache.ped, player, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            escorted = true
        elseif escorted then 
            DetachEntity(cache.ped, true, false)
            escorted = false
        end
    end
    if selected == 5 then 
        if escorted then 
            local vehicle, distance = ESX.Game.GetClosestVehicle()
            if vehicle and distance < 5 then
                local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)
                for i=maxSeats - 1, 0, -1 do
                    if IsVehicleSeatFree(vehicle, i) then
                        freeSeat = i
                        break
                    end
                end
                if freeSeat then
                    TaskWarpPedIntoVehicle(cache.ped, vehicle, freeSeat)
                end
            end
        end
    end
    if selected == 6 then 
        TaskLeaveVehicle(cache.ped, cache.vehicle, 16)
        Wait(1000)
        RequestAnimDict('mp_arresting')
        while not HasAnimDictLoaded('mp_arresting') do
            Wait(100)
        end
        TaskPlayAnim(cache.ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
        LocalPlayer.state:set('iscuffed', true, true)
        escorted = false 
    end 
end)

CreateThread(function()
	while true do
		Wait(4)
		local playerPed = PlayerPedId()
		if LocalPlayer.state.iscuffed then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
        end
    end
end)

LocalPlayer.state:set('iscuffed', false, true)
LocalPlayer.state:set('isescorted', false, true)

local point = lib.points.new({
    coords = Config.Duty.Position,
    distance = 3,
})
function point:onExit()
    lib.hideTextUI()
end
function point:nearby()
    if ESX.GetPlayerData().job.name == 'police' or ESX.GetPlayerData().job.name == 'offpolice' then
    DrawMarker(2, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 200, 20, 20, 50, false, true, 2, false, nil, nil, false)
    if ESX.GetPlayerData().job.name == 'police' then
        lib.showTextUI('[E] - Go off duty', {
            position = "right-center",
            icon = 'phone',
        })
    else
        lib.showTextUI('[E] - Go on duty', {
            position = "right-center",
            icon = 'phone',
        })
    end
    if self.currentDistance < 1 and IsControlJustReleased(0, 38) then
        TriggerServerEvent('police:duty')
    end
  end
end

local function weapons()
    local options = {}
    for z, v in pairs(Config.Armoury.Weapons) do
        table.insert(options, {
            label = v.Label,
            value = v.Value,
            price = v.Price,
            icon = 'gun'
        })
    end
    lib.registerMenu({
        id = 'police:weapons',
        title = 'Weapons',
        position = 'top-right',
        onClose = function(keyPressed)
            lib.showMenu('police:armoury')
        end,
        options = options
    }, function(selected, scrollIndex, args)
        TriggerServerEvent('police:armoury', options[selected].value, options[selected].price, 1)
    end)
    lib.showMenu('police:weapons')
end

local function item(hash, amount)
    local input = lib.inputDialog('Police Storage', {
        {type = 'number', label = 'Amount you would like to store:', description = 'You have x'..amount..' '..hash, icon = 'arrow-right'},
    })
    TriggerServerEvent('police:armoury', hash, 0 , 2, input[1])
end

local function blackmoney(amount)
    local input = lib.inputDialog('Police Storage', {
        {type = 'number', label = 'Amount you would like to store:', description = 'You have $'..amount..' of dirty money.', icon = 'arrow-right'},
    })
    TriggerServerEvent('police:armoury', nil, 0 , 4, input[1])
end

local function storage()
    local items = lib.callback.await('police:items', false, false, 2)
    local options = {}
    table.insert(options, {
        icon = 'circle-info',
        label = 'Store items:',
        close = false
    })
    for i=1, #items.accounts, 1 do
        if items?.accounts[i]?.name == 'black_money' and items.accounts[i]?.money > 0 then
            table.insert(options, {
                icon = 'money-bill',
                label = ('Dirty Money: %s'):format(items?.accounts[i]?.money),
                value = 1,
                amount   = items?.accounts[i].money,
                close = false
            })
            break
        end
    end
    for i=1, #items.weapons, 1 do
        table.insert(options, {
            icon = "fas fa-gun",
            label    = 'Weapon: '..ESX.GetWeaponLabel(items.weapons[i].name),
            item    = items.weapons[i].name,
            value = 2,
            close = false
        })
    end
    for i=1, #items.inventory, 1 do
        if items.inventory[i].count > 0 then
            table.insert(options, {
                icon = "fas fa-box",
                label    = ('Item: %s x%s'):format(items.inventory[i].label,items.inventory[i].count),
                item    = items.inventory[i].name,
                value = 3,
                amount   = items.inventory[i].count,
                close = false
            })
        end
    end
    lib.registerMenu({
        id = 'police:items',
        title = 'Storage',
        position = 'bottom-right',
        onClose = function()
            lib.showMenu('police:armoury')
        end,
        options = options
    },function(selected)
        local amount = options[selected].amount
        if options[selected].value == 3 then
            local hash = options[selected].item
            lib.hideMenu('police:items')
            Wait(500)
            item(hash, amount)
        end
        if options[selected].value == 2 then
            TriggerServerEvent('police:armoury', options[selected].item, 0 , 3)
        end
        if options[selected].value == 1 then
            lib.hideMenu('police:items')
            Wait(500)
            blackmoney(amount)
        end
    end)
    Wait(100)
    lib.showMenu('police:items')
end

local Armoury = lib.points.new({
    coords = Config.Armoury.Position,
    distance = 3,
})
function Armoury:onExit()
    lib.hideTextUI()
end
function Armoury:nearby()
    if ESX.GetPlayerData().job.name == 'police' then
    DrawMarker(2, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 200, 20, 20, 50, false, true, 2, false, nil, nil, false)
    lib.showTextUI('[E] - Open armoury', {
        position = "right-center",
        icon = 'gun',
    })
    if self.currentDistance < 1 and IsControlJustReleased(0, 38) then
        lib.registerMenu({
            id = 'police:armoury',
            title = 'Armoury',
            position = 'top-right',
            options = {
                {label = 'Weapons'},
                {label = 'Storage'},
            }
        }, function(selected, scrollIndex, args)
            if selected == 1 then
                weapons()
            end
            if selected == 2 then
                storage()
            end
        end)
        lib.showMenu('police:armoury')
    end
  end
end

local function Garage()
    local options = {}
    for z, v in pairs(Config.Garage.Vehicles) do
        table.insert(options, {
            label = v.Label,
            icon = 'car',
            model = v.Model,
            rank = v.Rank
        })
    end
    lib.registerMenu({
        id = 'police:garage',
        title = 'Police Garage',
        position = 'bottom-right',
        options = options
    },function(selected)
        if ESX.GetPlayerData().job.name == 'police' and ESX.GetPlayerData().job.grade >= options[selected].rank then
            if not Config.Garage.Give then
                if ESX.Game.IsSpawnPointClear(Config.Garage.Spawn, 5.0) then 
                    ESX.Game.SpawnVehicle(options[selected].model, Config.Garage.Spawn , 100.0, function(vehicle)
                        TaskWarpPedIntoVehicle(cache.ped, vehicle, -1)
                        ESX.ShowNotification('You have spawned a '..options[selected].label)
                    end)
                else
                    ESX.ShowNotification('Spawn point is blocked.')
                end
            else
                if ESX.Game.IsSpawnPointClear(Config.Garage.Spawn, 5.0) then 
                    ESX.Game.SpawnVehicle(options[selected].model, Config.Garage.Spawn , 100.0, function(vehicle)
                        TaskWarpPedIntoVehicle(cache.ped, vehicle, -1)
                        local newPlate = exports[Config.Garage.GeneratePlate]:GeneratePlate()
                        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                        vehicleProps.plate = newPlate
                        SetVehicleNumberPlateText(vehicle, newPlate)
                        TriggerServerEvent('esx_vehicleshop:setVehicleOwned', vehicleProps, true)
                    end)
                else
                    ESX.ShowNotification('Spawn point is blocked.')
                end
            end
        else 
            ESX.ShowNotification('You are not authorized to buy this vehicle.')
        end
    end)
    lib.showMenu('police:garage')
end

local garage = lib.points.new({
    coords = Config.Garage.Position,
    distance = 3,
})
function garage:onExit()
    lib.hideTextUI()
end
function garage:nearby()
    if ESX.GetPlayerData().job.name == 'police' then
    DrawMarker(2, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 200, 20, 20, 50, false, true, 2, false, nil, nil, false)
    lib.showTextUI('[E] - Open police garage', {
        position = "right-center",
        icon = 'car',
    })
    if self.currentDistance < 1 and IsControlJustReleased(0, 38) then
        Garage()
    end
  end
end


lib.addKeybind({
    name = 'PD',
    description = 'LSPD MENU',
    defaultKey = Config.Menu.Bind,
    onPressed = function(self)
        if ESX.GetPlayerData().job.name == 'police' then
            lib.showMenu('police:menu')
        end 
    end
})