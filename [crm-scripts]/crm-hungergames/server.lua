ESX = nil


if Config.OLDESX then 
    TriggerEvent(
        'esx:getSharedObject',
        function(obj)
            ESX = obj
        end
    )
end

if not Config.OLDESX then 
    ESX = exports["crm-core"]:getSharedObject()
end

local PlayerIds = {}
local MinPlayers = Config.MinPlayers
local MaxPlayers = Config.MaxPlayers
local HungerGamesStarted = false
local startingPositions = {} 
local shuffledPositions = {}




RegisterServerEvent('hungergames:resetpositions')
AddEventHandler('hungergames:resetpositions', function()
    startingPositions = Config.Positions
end)

ESX.RegisterServerCallback('hungergames:getdatatoplist', function(source, cb)
    local data = MySQL.query.await('SELECT * FROM hg_wins ORDER BY wins DESC LIMIT 10;' , {})
        cb(data)
end)

ESX.RegisterServerCallback('hungergames:getdatawins', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local data = MySQL.Sync.fetchScalar('SELECT wins FROM hg_wins WHERE identifier = @identifier' , {
        ['@identifier'] = GetPlayerIdentifier(source)
    })
    if data ~= nil then 
        cb(data)
    else
        cb(0)
    end
end)

RegisterServerEvent('hungergames:join')
AddEventHandler('hungergames:join', function()
    local id = source
    if not HungerGamesStarted then
        if #PlayerIds == 0 then 
                        table.insert(PlayerIds, id)
                        local playercount = #PlayerIds
                        TriggerClientEvent('joinedHungerGames', id, 'joined', playercount , MaxPlayers)
                        if #PlayerIds >= Config.MinPlayers then
                            Citizen.Wait(4800)
                            for i, PlayersId in pairs(PlayerIds) do
                                TriggerClientEvent('hungergames:notifications', PlayersId, Config.Language.StartingSoon)
                            end
                            Citizen.Wait(4800)
                            StartHungerGames()
                            HungerGamesStarted = true
                        end
        elseif #PlayerIds > 0 then 
            for i, value in pairs(PlayerIds) do 
                if value == id then 
                    TriggerClientEvent('joinedHungerGames', id, 'already')
                else
                    if #PlayerIds <= Config.MaxPlayers then 
                        table.insert(PlayerIds, id)
                        local playercount = #PlayerIds
                        TriggerClientEvent('joinedHungerGames', id, 'joined', playercount , MaxPlayers)
                    else
                        TriggerClientEvent('joinedHungerGames', id, 'notjoined')
                    end
                    if #PlayerIds >= Config.MinPlayers then
                        Citizen.Wait(4800)
                        for i, PlayersId in pairs(PlayerIds) do
                            TriggerClientEvent('hungergames:notifications', PlayersId, Config.Language.StartingSoon)
                        end
                        Citizen.Wait(4800)
                        StartHungerGames()
                        HungerGamesStarted = true
                    end
                end
            end
        end
    else
        TriggerClientEvent('joinedHungerGames', id, 'started')
    end
end)




RegisterServerEvent('hungergames:deleteid')
AddEventHandler('hungergames:deleteid', function()
    local id = source
    if Config.CheckInventory then 
        exports.ox_inventory:ClearInventory(id)
    end
    TriggerClientEvent('hungergames:removed', id)
    SetPlayerRoutingBucket(id, 0)
    for i, value in ipairs(PlayerIds) do
        if value == id then
            table.remove(PlayerIds, i)
            if #PlayerIds <= 1 then
                for i, PlayersId in pairs(PlayerIds) do
                    TriggerClientEvent('hungergames:gameend', PlayersId)
                    SetPlayerRoutingBucket(PlayersId, 0)
                    if Config.CheckInventory then 
                        exports.ox_inventory:ClearInventory(PlayersId)
                    end
                    if Config.WinPayment then 
                        xPlayer = ESX.GetPlayerFromId(PlayersId)
                        xPlayer.addMoney(Config.Payamount)
                    end
                    local playerIdentifier = GetPlayerIdentifier(PlayersId)
                    local name = GetPlayerName(PlayersId)
                    MySQL.query('SELECT * FROM hg_wins WHERE identifier = ?', {playerIdentifier}, function(result)
                        if json.encode(result) ~= '[]' then
                            MySQL.update('UPDATE hg_wins SET wins = wins + 1 WHERE identifier = ?', {playerIdentifier}, function()
                            end)
                        else
                            MySQL.insert('INSERT INTO hg_wins (identifier, name, wins) VALUES (?, ?, 1)', {playerIdentifier, name}, function()
                            end)
                        end
                    end)
                end
                HungerGamesStarted = false
                PlayerIds = {}
                TriggerEvent('hungergames:resetpositions')
            end
            break
        end
    end
end)


RegisterServerEvent('hungergames:killerid')
AddEventHandler('hungergames:killerid', function(id)
   TriggerClientEvent('hungergames:addkillclient', id)
end)


RegisterServerEvent('hungergames:addloot')
AddEventHandler('hungergames:addloot', function(name, amount, ammoname, ammoamount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(name, amount)
    if ammoname ~= nil then 
        xPlayer.addInventoryItem(ammoname, ammoamount)
    end
end)



function StartHungerGames()

    local shuffledPositions = {}
    local startingPositions = Config.Positions

    for i = 1, #startingPositions do
        table.insert(shuffledPositions, startingPositions[i])
    end

    for i, PlayersId in pairs(PlayerIds) do
        if #shuffledPositions > 0 then
            local randomIndex = math.random(#shuffledPositions)
            local position = table.remove(shuffledPositions, randomIndex)
            TriggerClientEvent('startHungerGames', PlayersId, position)
            SetPlayerRoutingBucket(PlayersId, 8)
        else
            print('ERROR! Not enough Positions!')
        end
    end
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(28000)
        if HungerGamesStarted then 
            if #PlayerIds <= 1 then
                for i, PlayersId in pairs(PlayerIds) do
                    TriggerClientEvent('hungergames:gameend', PlayersId)
                    if Config.CheckInventory then 
                        exports.ox_inventory:ClearInventory(PlayersId)
                    end
                    if Config.WinPayment then 
                        xPlayer = ESX.GetPlayerFromId(PlayersId)
                        xPlayer.addMoney(Config.Payamount)
                    end
                    SetPlayerRoutingBucket(PlayersId, 0)
                    local playerIdentifier = GetPlayerIdentifier(PlayersId)
                    local name = GetPlayerName(PlayersId)
                    MySQL.query('SELECT * FROM hg_wins WHERE identifier = ?', {playerIdentifier}, function(result)
                        if json.encode(result) ~= '[]' then
                            MySQL.update('UPDATE hg_wins SET wins = wins + 1 WHERE identifier = ?', {playerIdentifier}, function()
                            end)
                        else
                            MySQL.insert('INSERT INTO hg_wins (identifier, name, wins) VALUES (?, ?, 1)', {playerIdentifier, name}, function()
                            end)
                        end
                    end)
                end
                HungerGamesStarted = false
                PlayerIds = {}
                TriggerEvent('hungergames:resetpositions')
            end
        end
    end
end)


AddEventHandler('playerDropped', function(reason)
    print(json.encode(PlayerIds))
    for i, value in ipairs(PlayerIds) do
        if value == source then
            if Config.CheckInventory then 
                exports.ox_inventory:ClearInventory(i)
            end
            table.remove(PlayerIds, i)
        end
    end
end)


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(2000)
        for i, PlayersId in pairs(PlayerIds) do
            TriggerClientEvent('hungergames:playercount', PlayersId, #PlayerIds)
        end
    end
end)



