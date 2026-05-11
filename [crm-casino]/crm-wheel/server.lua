math.randomseed(os.time())
ESX = nil
isRoll = false
local car = Config.Cars[math.random(#Config.Cars)]

TriggerEvent(Config.ESX, function(obj) ESX = obj end)

if Config.DailySpin then
	Citizen.CreateThread(function()
		while true do
		Citizen.Wait(1000*60)
			if os.date('%H:%M') == Config.ResetSpin then
				MySQL.Sync.execute('UPDATE users SET wheel = 0')
			end
		end
	end)
end

ESX.RegisterServerCallback('vns_cs_wheel:getcar', function(source, cb)
	cb(car)
end)

RegisterServerEvent('vns_cs_wheel:getwheel')
AddEventHandler('vns_cs_wheel:getwheel', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not isRoll then
		if Config.DailySpin == true then
			MySQL.Async.fetchScalar('SELECT wheel FROM users WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier
			}, function(dwheel)
				if dwheel == '0' then
					TriggerEvent("vns_cs_wheel:startwheel", xPlayer, _source)
				else
					TriggerClientEvent('esx:showNotification', _source, _U('already_spin'))
				end
			end)
		elseif Config.DailySpin == false then
			if xPlayer.getMoney() >= Config.SpinMoney then
				TriggerEvent("vns_cs_wheel:startwheel", xPlayer, _source)
				xPlayer.removeMoney(Config.SpinMoney)
			else
				TriggerClientEvent('esx:showNotification', _source, _U('not_money'))
			end
		end
	end
end)	
	
	

RegisterServerEvent('vns_cs_wheel:startwheel')
AddEventHandler('vns_cs_wheel:startwheel', function(xPlayer, source)
    local _source = source
    if not isRoll then
        if xPlayer ~= nil then
			MySQL.Sync.execute('UPDATE users SET wheel = @wheel WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier,
				['@wheel'] = '1'
			})
			isRoll = true
			local rnd = math.random(1, 1000)
			local price = 0
			local priceIndex = 0
			for k,v in pairs(Config.Prices) do
				if (rnd > v.probability.a) and (rnd <= v.probability.b) then
					price = v
					priceIndex = k
					break
				end
			end
			TriggerClientEvent("vns_cs_wheel:syncanim", _source, priceIndex)
			TriggerClientEvent("vns_cs_wheel:startroll", -1, _source, priceIndex, price)
		end
	end
end)

RegisterServerEvent('vns_cs_wheel:give')
AddEventHandler('vns_cs_wheel:give', function(s, price)
    local _s = s
	local xPlayer = ESX.GetPlayerFromId(_s)
	isRoll = false
	if price.type == 'car' then
		TriggerClientEvent("vns_cs_wheel:winCar", _s, car)
		TriggerClientEvent('esx:showNotification', _s, _U('you_won_car'))
	elseif price.type == 'item' then
		xPlayer.addInventoryItem(price.name, price.count)
		TriggerClientEvent('esx:showNotification', _s, _U('you_won_item', price.count, ESX.GetItemLabel(price.name)))
	elseif price.type == 'money' then
		xPlayer.addAccountMoney('bank', price.count)
		TriggerClientEvent('esx:showNotification', _s, _U('you_won_money', price.count))
	elseif price.type == 'weapon' then
		xPlayer.addWeapon(price.name, 0)
		TriggerClientEvent('esx:showNotification', _s, _U('you_won_weapon', ESX.GetWeaponLabel(price.name)))
	end
	TriggerClientEvent("vns_cs_wheel:rollFinished", -1)
end)

RegisterServerEvent('vns_cs_wheel:stoproll')
AddEventHandler('vns_cs_wheel:stoproll', function()
	isRoll = false
end)