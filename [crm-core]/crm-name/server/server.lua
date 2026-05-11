ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('ms_namechange:SetFirstName')
AddEventHandler('ms_namechange:SetFirstName', function(ID, firstName)
    local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.Money then
		local newfirstname = xPlayer.getName()
        xPlayer.removeMoney(Config.Money)
		SetFirstName(identifier, firstName)
		--TriggerClientEvent('notifications', source, "#09f", "MS_SCRIPTS", "Dein neuer Vorname ist: " .. firstName)
		xPlayer.showNotification('Your new name is '.. newfirstname ..'.')
	else
		xPlayer.showNotification('You do not have enough money!')
		--TriggerClientEvent('notificationss', source, "#09f", "MS_SCRIPTS", "Du hast nicht genug Bargeld um deinen Vornamen zu ändern.")
	end
end)


RegisterServerEvent('ms_namechange:SetLastName')
AddEventHandler('ms_namechange:SetLastName', function(ID, lastName)
    local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.Money then
		local newlastname = xPlayer.getName()
      xPlayer.removeMoney(Config.Money)
		SetLastName(identifier, lastName)
		--TriggerClientEvent('notifications', source, "#09f", "MS_SCRIPTS", "Dein neuer Nachname ist: " .. lastName)
	else
		xPlayer.showNotification('You do not have enough money!')
		--TriggerClientEvent('notificationss', source, "#09f", "MS_SCRIPTS", "Du hast nicht genug Bargeld um deinen Nachnamen zu ändern.")
	end
end)







-- Vorname
function SetFirstName(identifier, firstName)
	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@firstname']		= firstName
	})
end

-- Nachname
function SetLastName(identifier, lastName)
	MySQL.Async.execute('UPDATE `users` SET `lastname` = @lastname WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@lastname']		= lastName
	})
end



-- NUI Close
RegisterNetEvent("ms_namechange:deny")
AddEventHandler("ms_namechange:deny", function(data)
    xPlayer.showNotification('You cancelled the process!')
end)