ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('crm-Discord:UpdatePresence')
AddEventHandler('crm-Discord:UpdatePresence', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local data = {
		['PlayerName'] = GetPlayerName(_source),
		['IdentityName'] = xPlayer.getName(),
		['Job'] = {jobName = xPlayer.getJob().name, jobGrade = xPlayer.getJob().grade_label, jobLabel = xPlayer.getJob().label},
		['ActivePlayers'] = GetNumPlayerIndices()
	}

    TriggerClientEvent('crm-Discord:SetPresence',_source,data)
end)
