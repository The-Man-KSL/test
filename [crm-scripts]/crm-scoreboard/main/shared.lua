Config = {}

Config.OpenKey = 57 -- https://docs.fivem.net/docs/game-references/controls/

Config.FormattedToken = "MTE0NjExNzUxNDAzMjU4Njg3NQ.GXWAj3.o8lKchSlpai5lLqd0nNfBPD8ntJGqT-mEiAW0Q" -- https://discord.com/developers/applications -- DO THIS FOR PROFILE PICTURES TO LOAD

Config.Framework = "NewESX" -- QBCore or ESX or OLDQBCore -- NewESX


Config.MySQL = "oxmysql" -- mysql-async or oxmysql or ghmattimysql

----------------------------------------------------------------------------
function GetFramework()
    local Get = nil
    if Config.Framework == "ESX" then
        while Get == nil do
            TriggerEvent('esx:getSharedObject', function(Set) Get = Set end)
            Citizen.Wait(0)
        end
    end
    if Config.Framework == "NewESX" then
        Get = exports['crm-core']:getSharedObject()
    end
    if Config.Framework == "QBCore" then
        Get = exports["qb-core"]:GetCoreObject()
    end
    if Config.Framework == "OldQBCore" then
        while Get == nil do
            TriggerEvent('QBCore:GetObject', function(Set) Get = Set end)
            Citizen.Wait(200)
        end
    end
    return Get
 end

----------------------------------------------------------------------------
 
function GetRandomBackground(keyword)
    local backgrounds = {
        police = {
            "https://media.tenor.com/cnyjrVmyX5AAAAAC/police.gif"
        },
        none = {
            "https://cdn.discordapp.com/attachments/1135750947650408468/1155592733373759558/GIF_Animated_Discord_Server_Banner_-_CRM.gif"
        }
    }

    local keywordBackgrounds = backgrounds[keyword]

    if not keywordBackgrounds then
        return nil
    end

    local randomIndex = math.random(1, #keywordBackgrounds)
    return keywordBackgrounds[randomIndex]
end
----------------------------------------------------------------------------
function DiscordRequest(method, endpoint, jsondata)
    local data = nil

    PerformHttpRequest("https://discord.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
        data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = "Bot " .. Config.FormattedToken})
      
    while data == nil do
        Citizen.Wait(0)
    end
    
    return data
end
----------------------------------------------------------------------------
function GetDiscordAvatar(userID)
    local response = DiscordRequest("GET", "users/"..userID, {})
    if response.code == 200 then
        local userData = json.decode(response.data)
        local avatarID = userData.avatar
        local avatarURL = string.format("https://cdn.discordapp.com/avatars/%s/%s.png", userID, avatarID)
        return avatarURL
    else
        return nil
    end
end
----------------------------------------------------------------------------
function HttpGet(url)
    local data = nil
    local error = nil

    PerformHttpRequest(url, function(err, result, headers)
        if err == 200 then
            data = json.decode(result)
        else
            error = err
        end
    end, 'GET')

    while data == nil and error == nil do
        Citizen.Wait(0)
    end

    return data, error
end

