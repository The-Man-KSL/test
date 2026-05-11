ESX = nil
local jobGrade = ''
local job = ''
local playerName = nil
local playerLoaded = false
local firstSpawn = true
-- ESX Stuff----
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	playerLoaded = true
end)

AddEventHandler('playerSpawned', function()
 if firstSpawn then
    for _, v in pairs(Config.Buttons) do
          SetDiscordRichPresenceAction(v.index, v.name, v.url)
    end
    firstSpawn = false
 end	
end)

RegisterNetEvent('crm-Discord:SetPresence')
AddEventHandler('crm-Discord:SetPresence', function(data)
	local data = data
	local player = PlayerId()
	if Config.UseJobs then
		SetDiscordRichPresenceAssetSmall(data['Job'].jobName)
		SetDiscordRichPresenceAssetSmallText(data['Job'].jobLabel .. " - " .. data['Job'].jobGrade)	
	end	
	--This is the Application ID (Replace this with you own)
	SetDiscordAppId(Config.ClientID)
	--Here you will have to put the image name for the "large" icon.
	SetDiscordRichPresenceAsset('image')
	if Config.UseESXIdentity then
		SetRichPresence((Config.RichPresence):format(GetPlayerServerId(player), data['IdentityName'], Config.PlayerText, data['ActivePlayers'], tostring(Config.PlayerCount)))
	else
		SetRichPresence((Config.RichPresence):format(GetPlayerServerId(player), data['PlayerName'], Config.PlayerText, data['ActivePlayers'], tostring(Config.PlayerCount)))
	end
	SetDiscordRichPresenceAssetText('Joshuin#7996')
end)

Citizen.CreateThread(function()
	while not playerLoaded do
		Citizen.Wait(10)
	end
	while true do
		TriggerServerEvent('crm-Discord:UpdatePresence')
		Citizen.Wait(Config.ResourceTimer*1000)
	end
end)

