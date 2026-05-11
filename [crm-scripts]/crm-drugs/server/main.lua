ESX = exports[Config.DrugSystem.Configure.ESX.Export]:getSharedObject()

ESX.RegisterServerCallback('LegacyDrugs:AttemptCollect', function(source, cb, drug, drugAmount, drugType, interactType)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(drug)
    if item ~= nil then
        if item.count + drugAmount > item.weight then
            xPlayer.addInventoryItem(drug, drugAmount)
            cb(false)
        else
            xPlayer.addInventoryItem(drug, drugAmount)
            cb(true)
        end
    else
        if Config.DrugSystem.Configure.InvalidDrugs.ConsoleLog then
            print(Config.DrugSystem.Configure.InvalidDrugs.ConsoleMessage:format(GetPlayerName(xPlayer.source), GetPlayerIdentifiers(xPlayer.source), tostring(drug)))
        end
        if Config.DrugSystem.Configure.InvalidDrugs.Punishment == 'kick' then
            DropPlayer(xPlayer.source, '\n[Legacy\'s Drug System]:\nYou\'ve been kicked for Invalid Drug Collecting!\n')
        elseif Config.DrugSystem.Configure.InvalidDrugs.Punishment == 'notifyPlayer' then
            TriggerClientEvent('esx:showNotification', xPlayer.source, Config.DrugSystem.Configure.InvalidDrugs.NotifyMessage:format(tostring(drug)))
        end
        cb(false)
    end
end)

ESX.RegisterServerCallback('LegacyDrugs:AttemptProcess', function(source, cb, drug, drugAmount, drugProcessed, drugProcessedAmount, drugType)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(drug)
    local item2 = xPlayer.getInventoryItem(drugProcessed)
    if item ~= nil then
        if item2 ~= nil then
            if item2.count + drugProcessedAmount > item2.weight then
                xPlayer.removeInventoryItem(drug, drugAmount)
                xPlayer.addInventoryItem(drugProcessed, drugProcessedAmount)
                cb(false)
            else
                if item.count >= drugAmount then
                    xPlayer.removeInventoryItem(drug, drugAmount)
                    xPlayer.addInventoryItem(drugProcessed, drugProcessedAmount)
                    cb(true)
                else
                    TriggerClientEvent('esx:showNotification', xPlayer.source, drugType.Notify.notEnough)	
                    cb(false)
                end
            end
        else
            if Config.DrugSystem.Configure.InvalidDrugs.ConsoleLog then
                if Config.DrugSystem.Configure.InvalidDrugs.Punishment == 'kick' then
                    print('The Drug ^2' .. drugProcessed.. '^7 was attempted to be Processed by ^1' .. GetPlayerName(xPlayer.source) .. ' [' .. xPlayer.source .. ']^7, but the Drug isn\'t in the Database / invalid Drug! ^3(Kicking Player)^7')
                elseif Config.DrugSystem.Configure.InvalidDrugs.Punishment == 'notifyPlayer' then
                    print('The Drug ^2' .. drugProcessed.. '^7 was attempted to be Processed by ^1' .. GetPlayerName(xPlayer.source) .. ' [' .. xPlayer.source .. ']^7, but the Drug isn\'t in the Database / invalid Drug! ^3(Notifying Player)^7')
                else
                    print('The Drug ^2' .. drugProcessed.. '^7 was attempted to be Processed by ^1' .. GetPlayerName(xPlayer.source) .. ' [' .. xPlayer.source .. ']^7, but the Drug isn\'t in the Database / invalid Drug!')
                end
            end
            if Config.DrugSystem.Configure.InvalidDrugs.Punishment == 'kick' then
                DropPlayer(xPlayer.source, '\n[Legacy\'s Drug System]:\nYou\'ve been kicked for Invalid Drug Processing!\n')
            elseif Config.DrugSystem.Configure.InvalidDrugs.Punishment == 'notifyPlayer' then
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'This Drug is not in the Database!<br>\nPlease contact the Owner/Developer!')
            end
            cb(false)
        end
    else
        if Config.DrugSystem.Configure.InvalidDrugs.ConsoleLog then
            if Config.DrugSystem.Configure.InvalidDrugs.Punishment == 'kick' then
                print('The Drug ^2' .. drug.. '^7 was attempted to be Processed by ^1' .. GetPlayerName(xPlayer.source) .. ' [' .. xPlayer.source .. ']^7, but the Drug isn\'t in the Database / invalid Drug! ^3(Kicking Player)^7')
            elseif Config.DrugSystem.Configure.InvalidDrugs.Punishment == 'notifyPlayer' then
                print('The Drug ^2' .. drug.. '^7 was attempted to be Processed by ^1' .. GetPlayerName(xPlayer.source) .. ' [' .. xPlayer.source .. ']^7, but the Drug isn\'t in the Database / invalid Drug! ^3(Notifying Player)^7')
            else
                print('The Drug ^2' .. drug.. '^7 was attempted to be Processed by ^1' .. GetPlayerName(xPlayer.source) .. ' [' .. xPlayer.source .. ']^7, but the Drug isn\'t in the Database / invalid Drug!')
            end
        end
        if Config.DrugSystem.Configure.InvalidDrugs.Punishment == 'kick' then
            DropPlayer(xPlayer.source, '\n[Legacy\'s Drug System]:\nYou\'ve been kicked for Invalid Drug Processing!\n')
        elseif Config.DrugSystem.Configure.InvalidDrugs.Punishment == 'notifyPlayer' then
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'This Drug is not in the Database!<br>\nPlease contact the Owner/Developer!')
        end
        cb(false)
    end
end)

ESX.RegisterServerCallback('LegacyDrugs:AttemptSell', function(source, cb, drug, drugAmount, drugType)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(drug)
    if item ~= nil then
        if item.count - drugAmount > item.weight then
            xPlayer.removeInventoryItem(drug, drugAmount)
            xPlayer.addAccountMoney(drugType.Give.money, drugType.Give.amount)
            cb(false)
        else
            if item.count >= drugAmount then
                xPlayer.removeInventoryItem(drug, drugAmount)
                xPlayer.addAccountMoney(drugType.Give.money, drugType.Give.amount)
                cb(true)
            else
                TriggerClientEvent('esx:showNotification', xPlayer.source, drugType.Notify.notEnough)	
                cb(false)
            end
        end
    else
        if Config.DrugSystem.Configure.InvalidDrugs.ConsoleLog then
            if Config.DrugSystem.Configure.InvalidDrugs.Punishment == 'kick' then
                print('The Drug ^2' .. drug.. '^7 was attempted to be Sold by ^1' .. GetPlayerName(xPlayer.source) .. ' [' .. xPlayer.source .. ']^7, but the Drug isn\'t in the Database / invalid Drug! ^3(Kicking Player)^7')
            elseif Config.DrugSystem.Configure.InvalidDrugs.Punishment == 'notifyPlayer' then
                print('The Drug ^2' .. drug.. '^7 was attempted to be Sold by ^1' .. GetPlayerName(xPlayer.source) .. ' [' .. xPlayer.source .. ']^7, but the Drug isn\'t in the Database / invalid Drug! ^3(Notifying Player)^7')
            else
                print('The Drug ^2' .. drug.. '^7 was attempted to be Sold by ^1' .. GetPlayerName(xPlayer.source) .. ' [' .. xPlayer.source .. ']^7, but the Drug isn\'t in the Database / invalid Drug!')
            end
        end
        if Config.DrugSystem.Configure.InvalidDrugs.Punishment == 'kick' then
            DropPlayer(xPlayer.source, '\n[Legacy\'s Drug System]:\nYou\'ve been kicked for Invalid Drug Selling!\n')
        elseif Config.DrugSystem.Configure.InvalidDrugs.Punishment == 'notifyPlayer' then
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'This Drug is not in the Database!<br>\nPlease contact the Owner/Developer!')
        end
        cb(false)
    end
end)