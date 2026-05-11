RegisterNUICallback("getConfig", function(data, cb)
    cb(Config)
end)

RegisterNUICallback("getPlayers", function(data, cb)
    local players = TriggerCallback("gfx-loading:getPlayers")
    cb(players)
end)

RegisterNUICallback("getInfo", function(data, cb)
    local player = TriggerCallback("gfx-loading:getInfo")
    cb(player)
end)

Citizen.CreateThread(function()
    SetNuiFocus(true, true)
end)

function TriggerCallback(name, ...)
    local id = GetRandomIntInRange(0, 999999)
    local eventName = "gfx-loading:triggerCallback:" .. id
    local eventHandler
    local promise = promise:new()
    RegisterNetEvent(eventName)
    local eventHandler = AddEventHandler(eventName, function(...)
        promise:resolve(...)
    end)   
    SetTimeout(15000, function()
        promise:resolve("timeout")
        RemoveEventHandler(eventHandler)
    end)
    local args = {...}
    TriggerServerEvent(name, id, args)   
    local result = Citizen.Await(promise)
    RemoveEventHandler(eventHandler)
    return result
  end