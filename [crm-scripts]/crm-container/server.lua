local ESX = nil

ESX = exports["crm-core"]:getSharedObject()

Citizen.CreateThread(function()
    TriggerEvent(Config.ESXT,function(obj)ESX = obj end)
end)






RegisterServerEvent('a_container_opening')
AddEventHandler('a_container_opening', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem(Config.ItemName).count >= 1 then 
        xPlayer.removeInventoryItem(Config.ItemName, 1)
        TriggerClientEvent('a_container_opening:open', source)
    end
end)

RegisterServerEvent('a_container_opening:giveitem')
AddEventHandler('a_container_opening:giveitem', function(itemname, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(itemname, amount)
end)



ESX.RegisterUsableItem(Config.ItemName, function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(Config.ItemName, 1)
    TriggerClientEvent('a_container_opening:open', source)
end)