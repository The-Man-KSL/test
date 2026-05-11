ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent('esx_moneywash:washMoney')
AddEventHandler('esx_moneywash:washMoney', function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
    if #(GetEntityCoords(GetPlayerPed(xPlayer.source)) - vector3(Config.Zones.laundryMat.Pos[1].x, Config.Zones.laundryMat.Pos[1].y, Config.Zones.laundryMat.Pos[1].z)) >= 10 then
    return CancelEvent(), sourceXPlayer.kick("Later nerd");
end
	local tax = Config.taxRate
	amount = ESX.Math.Round(tonumber(amount))
	washedCash = amount * tax
	washedTotal = ESX.Math.Round(tonumber(washedCash))
	
	if amount > 0 and xPlayer.getAccount('black_money').money >= amount then
		xPlayer.removeAccountMoney('black_money', amount)
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have_washed') .. ESX.Math.GroupDigits(amount) .. _U('dirty_money') .. _U('you_have_received') .. ESX.Math.GroupDigits(washedTotal) .. _U('clean_money'))
		xPlayer.addMoney(washedTotal)
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
	end
end)