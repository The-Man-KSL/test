
-- PLEASE DONT FORGET TO CHANGE THE SERVERIP IN THE SCRIPT.JS FILE
-- SCRIPT WILL NOT BE WORKING OTHERWISE

Config = {
    SteamAPIKey = GetConvar("steam_webApiKey", ""),
    RPName = {
        enabled = true,
        framework = "newesx", -- esx or qb or newesx or newqb
    },
    Tracks = {
        {
            image = "https://cdn.discordapp.com/attachments/1115058396618563644/1156257344360034395/gameofthrone.png?ex=65145011&is=6512fe91&hm=b681d0806e3f399709fcc465140b118222fcb75e004bd3aa6dcf13880803ae9f&", 
            name = "Game of Thrones", 
            singer = "HBO", 
            file = "assets/tracks/game.mp3"
        },
        {
            image = "https://cdn.discordapp.com/attachments/707081725637034004/1153889067667300372/pitbull.png", 
            name = "Hey Baby", 
            singer = "Pitbull", 
            file = "assets/tracks/pitbull.mp3"
        },
        {
            image = "https://cdn.discordapp.com/attachments/707081725637034004/1153890752162693200/Mark_Morrison_Return_Of_the_Mack_Album_Cover.jpeg", 
            name = "Return of the Mack", 
            singer = "Mack Morrision", 
            file = "assets/tracks/mack.mp3"
        },

    },
    ServerInfo = {
        ServerName = "CRM Loading Screen",
        ServerImage = "assets/logo.png",
        smallTitle = "LS Semi ESX",
        serverDescription = "Change your IP in crm-loading > nui > script.js",
    },
    Updates = {
        [1] = {
            title = "New Update",
            message = "LS Semi Serious ESX Release",
            date = "01.01.2024",
            publishedBy = "Josh",
            publishedByImage = "assets/logo.png",
            image = "assets/logo.png",
        },
        [2] = {
            title = "Soon",
            message = "LS Semi Serious will be updated when needed",
            date = "01.01.2024",
            publishedBy = "Josh",
            publishedByImage = "assets/logo.png",
            image = "assets/logo.png",
        },
        [3] = {
            title = "Purchase",
            message = "Purchase more servers from discord.gg/devcrm we have the cheapest and the best prices available, with a wide range of products to buy from such as NYC, Miami and LS.",
            date = "01.01.2024",
            publishedBy = "Josh",
            publishedByImage = "assets/logo.png",
            image = "assets/logo.png",
        },
        [4] = {
            title = "Cayo Perico",
            message = "Cayo Perico is at the bottom right of your map!",
            date = "01.01.2024",
            publishedBy = "Josh",
            publishedByImage = "assets/logo.png",
            image = "assets/logo.png",
        },
        [5] = {
            title = "Support",
            message = "If you need support open a ticket in discord.gg/devcrm. Do not DM Staff",
            date = "01.01.2024",
            publishedBy = "Josh",
            publishedByImage = "assets/logo.png",
            image = "assets/logo.png",
        }
    },
    Keys = {
        ["F1"] = {
            title = "PHONE",
            description = "Press F1 to open the Phone",
        },
        ["F2"] = {
            title = "INVENTORY",
            description = "Press F2 to open the Inventory", 
        },
        ["F3"] = {
            title = "EMOTES",
            description = "Press F3 to open the Emotes", 
        },
        ["F6"] = {
            title = "JOB MENU",
            description = "Press F6 to open Job Menu", 
        },
        ["F10"] = {
            title = "SCOREBOARD",
            description = "Press F10 to open Scoreboard", 
        },
        ["F12"] = {
            title = "MULTIJOB",
            description = "Press F12 to open Multijob", 
        },
        ["T"] = {
            title = "CHAT",
            description = "Press T to open Chat", 
        },
        ["I"] = {
            title = "HUD",
            description = "Press I to open Hud Settings", 
        },
        ["J"] = {
            title = "RACING",
            description = "Press J to open Racing Menu", 
        },
        ["X"] = {
            title = "HANDS UP",
            description = "Press X to put Hands Up", 
        },
        ["TAB"] = {
            title = "HOTBAR",
            description = "Press TAB to open Hotbar", 
        },
        ["/TV"] = {
            title = "TV",
            description = "Type /TV to open TV Menu", 
        },
        ["/Broadcast"] = {
            title = "Broadcast",
            description = "Type /broadcast to open Broadcast Menu", 
                    },
        ["/hg"] = {
            title = "Hunger Games",
            description = "Type /hg to join Hunger Games", 
        },
        ["/jail"] = {
            title = "Police Jail",
            description = "Type /jail id time (minutes) to Jail someone", 
        },
        ["/jailstatus"] = {
            title = "Jail Status",
            description = "Type /jailstatus id to check someones jail time", 
        },
        ["/keys"] = {
            title = "House Keys",
            description = "Type /keys to unlock your house or transfer keys", 
        },
        ["/skin"] = {
            title = "Skin Menu",
            description = "Type /skin to give yourself or others the skin menu (admin only)", 
        },
    
    },
    SocialMedia = {
        [1] = {
            image = "assets/inst-icon.png",
            link = "instagram.com/crm",
        },
        [2] = {
            image = "assets/x-icon.png",
            link = "x.com/crm",
        },
        [3] = {
            image = "assets/site-icon.png",
            link = "store.crm.com",
        },
        [4] = {
            image = "assets/discord-icon.png",
            link = "discord.gg/devcrm",
        },
    }
}

if Config.RPName.enabled then
    if Config.RPName.framework == "esx" then
        ESX = nil
        Citizen.CreateThread(function()
            while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                Citizen.Wait(0)
            end
        end)
    elseif Config.RPName.framework == "qb" then
        QBCore = nil
        Citizen.CreateThread(function()
            while QBCore == nil do
                TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
                Citizen.Wait(0)
            end
        end)
    elseif Config.RPName.framework == "newesx" then
        ESX = exports['crm-core']:getSharedObject()
    elseif Config.RPName.framework == "newqb" then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end

function GetName(source)
    if Config.RPName.enabled then
        if Config.RPName.framework == "esx" then
            local xPlayer = ESX.GetPlayerFromId(source)
            if not xPlayer then return GetPlayerName(source) end
            return xPlayer.getName()
        elseif Config.RPName.framework == "qb" then
            local xPlayer = QBCore.Functions.GetPlayer(source)
            if not xPlayer then return GetPlayerName(source) end
            return xPlayer.charinfo.firstname.. " " ..xPlayer.charinfo.lastname
        elseif Config.RPName.framework == "newesx" then
            local xPlayer = ESX.GetPlayerFromId(source)
            if not xPlayer then return GetPlayerName(source) end
            return xPlayer.getName()
        elseif Config.RPName.framework == "newqb" then
            local xPlayer = QBCore.Functions.GetPlayer(source)
            if not xPlayer then return GetPlayerName(source) end
            return xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname
        end
    else
        return GetPlayerName(source)
    end
end