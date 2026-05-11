local ESX = exports[Config.ESX]:getSharedObject()

local function Notify(player, message)
    player.showNotification(message)
end

RegisterNetEvent('police:actions')
AddEventHandler('police:actions', function(target, selected)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local job = xPlayer.job.name
    if job == 'police' then 
        if selected == 2 then
            if Player(target).state.iscuffed == false then 
                TriggerClientEvent('police:actions', target, selected, source)
            else
                Notify(xPlayer, 'This player is already cuffed')
            end
        end
        if selected == 3 then
            TriggerClientEvent('police:actions', target, selected, source)
        end
        if selected == 4 then
            if Player(target).state.iscuffed then
                TriggerClientEvent('police:actions', target, selected, source)
            else
                Notify(xPlayer, 'This player is not cuffed dummy')
            end
        end
        if selected == 5 then 
            if Player(target).state.iscuffed then 
                Player(target).state:set('Escort', not Player(target).state.Escort,true)
                TriggerClientEvent('police:actions',  target, selected, source)
            else
                Notify(xPlayer, 'This player isnt cuffed')
            end
        end
        if selected == 6 then
            TriggerClientEvent('police:actions', target, selected, source)
        end
    else 
        DropPlayer(source, 'Cheating? Suck your mum')
    end
end)

lib.callback.register('police:items', function(source, target, selected)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    if selected == 1 then 
        items = { 
            inventory = xTarget.getInventory(),
            accounts = xTarget.getAccounts(),
            weapons = xTarget.getLoadout()
        }
    end
    if selected == 2 then 
        items = { 
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout()
        }
    end
    return items
end)

RegisterNetEvent('police:remove') 
AddEventHandler('police:remove', function(target, item, value, ammount)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local job = xPlayer.job.name
    if job == 'police' then 
        if value == 1 then 
            local money = xTarget.getAccount('black_money')
            if money.money < ammount then return end 
            xTarget.removeAccountMoney('black_money', ammount)
            xPlayer.addAccountMoney('black_money', ammount)
            xPlayer.showNotification('You have removed $'..ammount..' of black money from ID:')
            xTarget.showNotification('$'..ammount..' black money has been removed from your account')
        end
        if value == 2 then 
            if not xTarget.hasWeapon(item) then return end
            xTarget.removeWeapon(item)
            xPlayer.addWeapon(item, ammount)
            xPlayer.showNotification('You have removed '..item)
            xTarget.showNotification(item..' has been removed from your loadout')
        end
        if value == 3 then 
            local thing = xTarget.getInventoryItem(item)
            if (thing.count > 0 and thing.count <= ammount) then 
                xTarget.removeInventoryItem(item, ammount)
                xPlayer.addInventoryItem(item, ammount)
                xPlayer.showNotification('You have removed x'..ammount..' '..item..' from ID:')
                xTarget.showNotification('x'..ammount..' '..item..' has been removed from your inventory')
            end
        end
    else 
        DropPlayer(source, 'Cheating? Suck your mum')
    end
end)

RegisterNetEvent('police:duty', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name
    if job == 'police' then
        xPlayer.setJob('offpolice', xPlayer.job.grade)
    elseif job == 'offpolice' then
        xPlayer.setJob('police', xPlayer.job.grade)
    end
end)

RegisterNetEvent('police:armoury', function(hash, price, selected, ammount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local money = xPlayer.getAccount('black_money')
    if job == 'police' then
        if selected == 1 then 
            GiveWeaponToPed(source, hash, 200, false, true)
            xPlayer.removeMoney(price)
        end
        if selected == 2 then 
            xPlayer.removeInventoryItem(hash, ammount)
        end
        if selected == 3 then
            xPlayer.removeWeapon(hash)
        end
        if selected == 4 then 
            if money.money >= ammount then 
                xPlayer.removeAccountMoney('black_money', ammount)
            else
                Notify(xPlayer, 'you dont have that much money dickhead')
            end
        end
    else 
        DropPlayer(source, 'Cheating? Suck your mum')
    end
end)






