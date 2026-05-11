SERVERCONFIG = {
    DISCORDTOKEN = ""
}

function CreateUseableItem(racing)
    if Config.Framework == "new-qb" then
        local QBCore = exports["qb-core"]:GetCoreObject()
        QBCore.Functions.CreateUseableItem(racing, function(source, item)
            OpenMenu(source)
        end)
    elseif Config.Framework == "old-qb" then
        local QBCore = nil
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        QBCore.Functions.CreateUseableItem(racing, function(source, item)
            OpenMenu(source)
        end)
    elseif Config.Framework == "esx" then
        local ESX = nil
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        
        ESX.RegisterUsableItem(racing, function(source)
            OpenMenu(source)
        end)
    end
end
        
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    if Config.Texts["openui"].item then
        CreateUseableItem(Config.Texts["openui"].item)
    end
end)