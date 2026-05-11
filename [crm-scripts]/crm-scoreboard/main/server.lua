Framework = nil
Framework = GetFramework()
Citizen.Await(Framework)
Callback = Config.Framework == "ESX" or Config.Framework == "NewESX" and Framework.RegisterServerCallback or Framework.Functions.CreateCallback



local playerTimers = {}
local updateInterval = 1000 
function updatePlayerTime(playerId)
    local license = getIdentifierByType(playerId, "license")
    if license and playerTimers[playerId] then
        local currentTime = os.time()
        local timeDiff = currentTime - playerTimers[playerId].startTime 
        local played = timeDiff + (playerTimers[playerId].previousTime or 0)        
        local hours = math.floor(played / 3600)
        local minutes = math.floor((played % 3600) / 60)
        local seconds = played % 60

        local data = json.decode(LoadResourceFile(GetCurrentResourceName(), "players.json"))
        data[license] = {
            hours = hours,
            minutes = minutes,
            seconds = seconds
        }
        SaveResourceFile(GetCurrentResourceName(), "players.json", json.encode(data, null, 2), -1)
        TriggerClientEvent('es-time', playerId, data[license])
    end
end
function getIdentifierByType(source, type)
    local identifiers = GetPlayerIdentifiers(source)
    for i = 1, #identifiers do
        if string.find(identifiers[i], type .. ":") then
            return identifiers[i]
        end
    end
    return nil
end

function initiatePlayer(playerId)
    if playerTimers[playerId] then
        playerTimers[playerId] = nil 
    end
    local license = getIdentifierByType(playerId, "license")
    local data = json.decode(LoadResourceFile(GetCurrentResourceName(), "players.json"))
    if license and data[license] then
        local previousTime = (data[license].hours * 3600) + (data[license].minutes * 60) + data[license].seconds
        playerTimers[playerId] = {
            startTime = os.time(),
            previousTime = previousTime
        }
    else
        playerTimers[playerId] = {
            startTime = os.time()
        }
    end
    Citizen.CreateThread(function()
        while playerTimers[playerId] do
            Citizen.Wait(updateInterval)
            updatePlayerTime(playerId)
        end
    end)
end

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local playerId = source
    initiatePlayer(playerId)
end)

Citizen.CreateThread(function()
    while true do
        for _, playerId in ipairs(GetPlayers()) do
            if not playerTimers[tonumber(playerId)] then
                initiatePlayer(tonumber(playerId))
            end
            updatePlayerTime(tonumber(playerId))
        end
        Citizen.Wait(updateInterval)
    end
end)



function ExecuteSql(query)
    local IsBusy = true
    local result = nil
    if Config.MySQL == "oxmysql" then
        if MySQL == nil then
            exports.oxmysql:execute(query, function(data)
                result = data
                IsBusy = false
            end)
        else
            exports.oxmysql:execute(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
    elseif Config.MySQL == "ghmattimysql" then
        exports.ghmattimysql:execute(query, {}, function(data)
            result = data
            IsBusy = false
        end)
    elseif Config.MySQL == "mysql-async" then   
        MySQL.Async.fetchAll(query, {}, function(data)
            result = data
            IsBusy = false
        end)
    end
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end

function formatMoney(amount)
    local formatted = amount
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end

---------------------------------------------------------------------------
local EYES = {}
local AvatarCache = {}
Callback('GetScoreboardData', function(_, cb, src)
    playersrc = src
    search = nil
    local Jobs = {
        police = 0,
        ambulance = 0,
        mechanic = 0,
        all = 0
    }
    for _, Player in ipairs(GetPlayers()) do
        if  Config.Framework == "ESX" or Config.Framework == "NewESX" then 
            v = Framework.GetPlayerFromId(tonumber(Player))
            search = v.identifier
        else
            v = Framework.Functions.GetPlayer(tonumber(Player))
            search = v.PlayerData.license
    end    
        if v then
            Jobs['all'] = Jobs['all'] + 1
            
            if Config.Framework == "ESX" or Config.Framework == "NewESX" then 
                local bank, cash

                for i, account in ipairs(v.accounts) do
                    if account.name == "bank" then
                        bank = account.money
                    elseif account.name == "money" then
                        cash = account.money
                    end
                end
                local x = nil
                if v.job.grade == 0 then 
                    x = "Novice"
                else
                    x = v.job.grade
                end
                local result = ExecuteSql("SELECT * FROM users WHERE identifier = '"..v.identifier.."'")
                    if result ~= nil and #result > 0 then
                         EYES[v.identifier] = {
                             id = Player,
                             ping = GetPlayerPing(Player),
                             onDuty = false or 'none duty',
                             job = v.job.name or 'none job',
                             grade = x or 'none grade',
                             name = result[1].firstname or 'none name',
                             lastname = result[1].lastname or 'none lastname',
                             avatar = GetAvatar(Player) or 'none avatar',
                             group = result[1].group or 'none group',
                             bank = bank or 'none bank',
                             cash = cash or 'none cash',
                             salary = v.job.grade_salary or 'none salary',
                             background = GetRandomBackground(v.job.name) or GetRandomBackground('none')
                         }
                    end
                 else
                    EYES[search] = {
                        id = Player,
                        ping = GetPlayerPing(Player),
                        onDuty = v.PlayerData.job and v.PlayerData.job.onduty or false,
                        job = v.PlayerData.job and v.PlayerData.job.name or '',
                        grade = v.PlayerData.job and v.PlayerData.job.grade.name or '',
                        name = v.PlayerData.charinfo and v.PlayerData.charinfo.firstname or '',
                        lastname = v.PlayerData.charinfo and v.PlayerData.charinfo.lastname or '',
                        avatar = GetAvatar(Player) or GetRandomAvatar(),
                        group = Framework.Functions.GetPermission(Player),
                        bank = formatMoney(v.PlayerData.money and v.PlayerData.money.bank or 0),
                        cash = formatMoney(v.PlayerData.money and v.PlayerData.money.cash or 0),
                        salary = formatMoney(v.PlayerData.job and v.PlayerData.job.payment or 0),
                        background = GetRandomBackground(v.PlayerData.job.name) or GetRandomBackground('none'),
                    }
            end
            if Config.Framework == "ESX" or Config.Framework == "NewESX" then
                if v.job.name and v.job.name == "police" then
                    Jobs['police'] = Jobs['police'] + 1
                elseif v.job.name and v.job.name == "ambulance" then
                    Jobs['ambulance'] = Jobs['ambulance'] + 1
                elseif v.job.name and v.job.name == "mechanic" then
                    Jobs['mechanic'] = Jobs['mechanic'] + 1
                end
            else
                if v.PlayerData.job and v.PlayerData.job.name == "police" then
                    Jobs['police'] = Jobs['police'] + 1
                elseif v.PlayerData.job and v.PlayerData.job.name == "ambulance" then
                    Jobs['ambulance'] = Jobs['ambulance'] + 1
                elseif v.PlayerData.job and v.PlayerData.job.name == "mechanic" then
                    Jobs['mechanic'] = Jobs['mechanic'] + 1
                end
            end
        end
    end
    cb(EYES[search], EYES, Jobs, v)
end)


AddEventHandler("playerDropped", function(reason)
    local identifier = GetPlayerIdentifier(source, 1)
    if identifier then
        if EYES[identifier] then
            EYES[identifier] = nil
        end
    end
    local playerId = source
    if playerTimers[playerId] then
        updatePlayerTime(playerId)
        playerTimers[playerId] = nil
    end
end)

function GetAvatar(source)
    local avatar = AvatarCache[source]

    if avatar then
        return avatar
    end

    local steamhex = GetPlayerIdentifier(source, 'steam')
    local discordId = nil

    for _, id in ipairs(GetPlayerIdentifiers(source)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end

    if steamhex then
        local steamid = tonumber(steamhex:sub(7), 16)
        local data, error = HttpGet(('http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=%s&steamids=%s'):format(GetConvar('steam_webApiKey'), steamid))
        
        if not error then
            avatar = data.response.players[1].avatarfull
            AvatarCache[source] = avatar
            return avatar
        end
    elseif discordId then
        avatar = GetDiscordAvatar(discordId)
        AvatarCache[source] = avatar
        return avatar
    end

    avatar = GetRandomAvatar()
    AvatarCache[source] = avatar
    return avatar
end

function GetRandomAvatar()
    local baseUrl = "https://avatars.dicebear.com/api/human"
    local randomString = tostring(math.random(1000, 9999))
    local options = {
        mood = {"happy", "sad"}, 
        background = {"%23" .. tostring(math.random(100, 999))}, 
        hairColor = {"black", "brown", "blond", "red", "blue"}, 
    }
    local function getRandomOption(optionList)
        return optionList[math.random(1, #optionList)]
    end
    local avatarUrl = string.format("%s/%s.svg?mood=%s&background=%s&hairColor=%s", 
    baseUrl, 
    randomString, 
    getRandomOption(options.mood),
    getRandomOption(options.background),
    getRandomOption(options.hairColor))
    return avatarUrl
end