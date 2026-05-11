ESX 						     = nil
local CopsConnected       	     = 0
local PlayersHarvestingCoke      = {}
local PlayersTransformingCoke    = {}
local PlayersSellingCoke         = {}

local PlayersHarvestingSalvia    = {}
local PlayersTransformingSalvia  = {}
local PlayersSellingSalvia       = {}

local PlayersHarvestingEcstasy   = {}
local PlayersTransformingEcstasy = {}
local PlayersSellingEcstasy      = {}

local PlayersHarvestingMeth      = {}
local PlayersTransformingMeth    = {}
local PlayersSellingMeth         = {}
local PlayersHarvestingWeed      = {}
local PlayersTransformingWeed    = {}
local PlayersSellingWeed         = {}
local PlayersHarvestingOpium     = {}
local PlayersTransformingOpium   = {}
local PlayersSellingOpium        = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

function ensureLegitness(xPlayer, dCoord)
	local xPlayer, dCoord = xPlayer, dCoord;
	local legit = {["legit"] = true, ["reason"] = "No flags found."}
	if xPlayer ~= nil then
		local pCoord = xPlayer.getCoords(true);
		if pCoord ~= nil then
			local distance = #(vector3(pCoord.x, pCoord.y, pCoord.z) - vector3(dCoord.x, dCoord.y, dCoord.z));
			local radius = tonumber(Config.ZoneSize.x * Config.ZoneSize.y * Config.ZoneSize.z)
			if distance < radius * 2.5 then
				return legit
			else
				legit = {["legit"] = false, ["reason"] = "Player was out of the radius."}
				return legit
			end
		else
			legit = {["legit"] = false, ["reason"] = "Player coords were nil."}
			return legit
		end
	else
		legit = {["legit"] = false, ["reason"] = "xPlayer was nil."}
		return legit
	end
end

-------------------------------------------------------
-----------------------WEED----------------------------
-------------------------------------------------------
local function HarvestWeed(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToFarmWeed, function()
		if PlayersHarvestingWeed[source] == true then
			local weed = xPlayer.getInventoryItem('weed')

			local legit = ensureLegitness(xPlayer, Config.Zones.WeedField);
			if legit["legit"] == true then
				if weed.limit ~= -1 and weed.count >= weed.limit then
					TriggerClientEvent('esx:showNotification', _source, _U('inv_full_weed'))
				else
					xPlayer.addInventoryItem('weed', 1)
					HarvestWeed(_source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Harvest Weed", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to collect ^2weed^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startHarvestWeed')
AddEventHandler('esx-drugs:startHarvestWeed', function()
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)

	PlayersHarvestingWeed[_source] = true
	xPlayer.showNotification(_U('pickup_in_prog'))
	HarvestWeed(_source)
end)

RegisterServerEvent('esx-drugs:stopHarvestWeed')
AddEventHandler('esx-drugs:stopHarvestWeed', function()
	local _source = source

	PlayersHarvestingWeed[_source] = false
end)

local function TransformWeed(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToProcessWeed, function()
		if PlayersTransformingWeed[source] == true then
			local weedQuantity = xPlayer.getInventoryItem('weed').count
			local poochQuantity = xPlayer.getInventoryItem('weed_pooch').count

			local legit = ensureLegitness(xPlayer, Config.Zones.WeedProcessing);
			if legit["legit"] == true then

				if poochQuantity > 25 then
					xPlayer.showNotification(_U('too_many_pouches'))
				elseif weedQuantity < 10 then
					xPlayer.showNotification(_U('not_enough_weed'))
				else
					xPlayer.removeInventoryItem('weed', 10)
					xPlayer.addInventoryItem('weed_pooch', 1)
				
					TransformWeed(source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Process Weed", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to process ^2weed^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startTransformWeed')
AddEventHandler('esx-drugs:startTransformWeed', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	PlayersTransformingWeed[_source] = true
	xPlayer.showNotification(_U('packing_in_prog'))
	TransformWeed(_source)
end)

RegisterServerEvent('esx-drugs:stopTransformWeed')
AddEventHandler('esx-drugs:stopTransformWeed', function()
	local _source = source

	PlayersTransformingWeed[_source] = false
end)

local function SellWeed(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToSellWeed, function()
		if PlayersSellingWeed[source] == true then
			local poochQuantity = xPlayer.getInventoryItem('weed_pooch').count

			local legit = ensureLegitness(xPlayer, Config.Zones.WeedDealer);
			if legit["legit"] == true then
				if poochQuantity == 0 then
					xPlayer.showNotification(_U('no_pouches_weed_sale'))
				else
					xPlayer.removeInventoryItem('weed_pooch', 1)
					xPlayer.addAccountMoney('black_money', 35000)
					xPlayer.showNotification(_U('sold_one_weed'))		
					SellWeed(source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Sell Weed", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to sell ^2weed^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startSellWeed')
AddEventHandler('esx-drugs:startSellWeed', function()
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)

	PlayersSellingWeed[_source] = true
	xPlayer.showNotification(_U('sale_in_prog'))
	SellWeed(_source)
end)

RegisterServerEvent('esx-drugs:stopSellWeed')
AddEventHandler('esx-drugs:stopSellWeed', function()
	local _source = source

	PlayersSellingWeed[_source] = false
end)
-------------------------------------------------------
-----------------------WEED----------------------------
-------------------------------------------------------


-------------------------------------------------------
-----------------------OPIUM---------------------------
-------------------------------------------------------
local function HarvestOpium(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToFarmOpium, function()
		if PlayersHarvestingOpium[source] == true then
			local opium = xPlayer.getInventoryItem('opium')

			local legit = ensureLegitness(xPlayer, Config.Zones.OpiumField);
			if legit["legit"] == true then
				if opium.limit ~= -1 and opium.count >= opium.limit then
					TriggerClientEvent('esx:showNotification', _source, _U('inv_full_opium'))
				else
					xPlayer.addInventoryItem('opium', 1)
					HarvestOpium(_source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Harvest Opium", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to collect ^2opium^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startHarvestOpium')
AddEventHandler('esx-drugs:startHarvestOpium', function()
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)

	PlayersHarvestingOpium[_source] = true
	xPlayer.showNotification(_U('pickup_in_prog'))
	HarvestOpium(_source)
end)

RegisterServerEvent('esx-drugs:stopHarvestOpium')
AddEventHandler('esx-drugs:stopHarvestOpium', function()
	local _source = source

	PlayersHarvestingOpium[_source] = false
end)

local function TransformOpium(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToProcessOpium, function()
		if PlayersTransformingOpium[source] == true then
			local opiumQuantity = xPlayer.getInventoryItem('opium').count
			local poochQuantity = xPlayer.getInventoryItem('opium_pooch').count

			local legit = ensureLegitness(xPlayer, Config.Zones.OpiumProcessing);
			if legit["legit"] == true then

				if poochQuantity > 20 then
					xPlayer.showNotification(_U('too_many_pouches'))
				elseif opiumQuantity < 20 then
					xPlayer.showNotification(_U('not_enough_opium'))
				else
					xPlayer.removeInventoryItem('opium', 20)
					xPlayer.addInventoryItem('opium_pooch', 2)
				
					TransformOpium(source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Process Opium", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to process ^2opium^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startTransformOpium')
AddEventHandler('esx-drugs:startTransformOpium', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	PlayersTransformingOpium[_source] = true
	xPlayer.showNotification(_U('packing_in_prog'))
	TransformOpium(_source)
end)

RegisterServerEvent('esx-drugs:stopTransformOpium')
AddEventHandler('esx-drugs:stopTransformOpium', function()
	local _source = source

	PlayersTransformingOpium[_source] = false
end)

local function SellOpium(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToSellOpium, function()
		if PlayersSellingOpium[source] == true then
			local poochQuantity = xPlayer.getInventoryItem('opium_pooch').count

			local legit = ensureLegitness(xPlayer, Config.Zones.OpiumDealer);
			if legit["legit"] == true then
				if poochQuantity == 0 then
					xPlayer.showNotification(_U('no_pouches_opium_sale'))
				else
					xPlayer.removeInventoryItem('opium_pooch', 1)
					xPlayer.addAccountMoney('black_money', 70000)
					xPlayer.showNotification(_U('sold_one_opium'))		
					SellOpium(source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Sell Opium", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to sell ^2opium^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startSellOpium')
AddEventHandler('esx-drugs:startSellOpium', function()
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)

	PlayersSellingOpium[_source] = true
	xPlayer.showNotification(_U('sale_in_prog'))
	SellOpium(_source)
end)

RegisterServerEvent('esx-drugs:stopSellOpium')
AddEventHandler('esx-drugs:stopSellOpium', function()
	local _source = source

	PlayersSellingOpium[_source] = false
end)
-------------------------------------------------------
-----------------------OPIUM---------------------------
-------------------------------------------------------


-------------------------------------------------------
-----------------------COKE----------------------------
-------------------------------------------------------
local function HarvestCoke(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToFarmCoke, function()
		if PlayersHarvestingCoke[source] == true then
			local coke = xPlayer.getInventoryItem('coke')

			local legit = ensureLegitness(xPlayer, Config.Zones.CokeField);
			if legit["legit"] == true then
				if coke.limit ~= -1 and coke.count >= coke.limit then
					TriggerClientEvent('esx:showNotification', _source, _U('inv_full_coke'))
				else
					xPlayer.addInventoryItem('coke', 1)
					HarvestCoke(_source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Harvest Coke", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to collect ^2coke^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startHarvestCoke')
AddEventHandler('esx-drugs:startHarvestCoke', function()
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)

	PlayersHarvestingCoke[_source] = true
	xPlayer.showNotification(_U('pickup_in_prog'))
	HarvestCoke(_source)
end)

RegisterServerEvent('esx-drugs:stopHarvestCoke')
AddEventHandler('esx-drugs:stopHarvestCoke', function()
	local _source = source

	PlayersHarvestingCoke[_source] = false
end)

local function TransformCoke(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToProcessCoke, function()
		if PlayersTransformingCoke[source] == true then
			local cokeQuantity = xPlayer.getInventoryItem('coke').count
			local poochQuantity = xPlayer.getInventoryItem('coke_pooch').count

			local legit = ensureLegitness(xPlayer, Config.Zones.CokeProcessing);
			if legit["legit"] == true then

				if poochQuantity > 20 then
					xPlayer.showNotification(_U('too_many_pouches'))
				elseif cokeQuantity < 20 then
					xPlayer.showNotification(_U('not_enough_coke'))
				else
					xPlayer.removeInventoryItem('coke', 20)
					xPlayer.addInventoryItem('coke_pooch', 2)
				
					TransformCoke(source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Process Coke", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to process ^2coke^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startTransformCoke')
AddEventHandler('esx-drugs:startTransformCoke', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	PlayersTransformingCoke[_source] = true
	xPlayer.showNotification(_U('packing_in_prog'))
	TransformCoke(_source)
end)

RegisterServerEvent('esx-drugs:stopTransformCoke')
AddEventHandler('esx-drugs:stopTransformCoke', function()
	local _source = source

	PlayersTransformingCoke[_source] = false
end)

local function SellCoke(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToSellCoke, function()
		if PlayersSellingCoke[source] == true then
			local poochQuantity = xPlayer.getInventoryItem('coke_pooch').count

			local legit = ensureLegitness(xPlayer, Config.Zones.CokeDealer);
			if legit["legit"] == true then
				if poochQuantity == 0 then
					xPlayer.showNotification(_U('no_pouches_coke_sale'))
				else
					xPlayer.removeInventoryItem('coke_pooch', 1)
					xPlayer.addAccountMoney('black_money', 85000)
					xPlayer.showNotification(_U('sold_one_coke'))		
					SellCoke(source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Sell Coke", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to sell ^2coke^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startSellCoke')
AddEventHandler('esx-drugs:startSellCoke', function()
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)

	PlayersSellingCoke[_source] = true
	xPlayer.showNotification(_U('sale_in_prog'))
	SellCoke(_source)
end)

RegisterServerEvent('esx-drugs:stopSellCoke')
AddEventHandler('esx-drugs:stopSellCoke', function()
	local _source = source

	PlayersSellingCoke[_source] = false
end)
-------------------------------------------------------
-----------------------COKE----------------------------
-------------------------------------------------------


-------------------------------------------------------
-----------------------Salvia--------------------------
-------------------------------------------------------
local function HarvestSalvia(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToFarmSalvia, function()
		if PlayersHarvestingSalvia[source] == true then
			local salvia = xPlayer.getInventoryItem('salvia')

			local legit = ensureLegitness(xPlayer, Config.Zones.SalviaField);
			if legit["legit"] == true then
				if salvia.limit ~= -1 and salvia.count >= salvia.limit then
					TriggerClientEvent('esx:showNotification', _source, _U('inv_full_salvia'))
				else
					xPlayer.addInventoryItem('salvia', 1)
					HarvestSalvia(_source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Harvest Salvia", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to collect ^2salvia^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startHarvestSalvia')
AddEventHandler('esx-drugs:startHarvestSalvia', function()
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)

	PlayersHarvestingSalvia[_source] = true
	xPlayer.showNotification(_U('pickup_in_prog'))
	HarvestSalvia(_source)
end)

RegisterServerEvent('esx-drugs:stopHarvestSalvia')
AddEventHandler('esx-drugs:stopHarvestSalvia', function()
	local _source = source

	PlayersHarvestingSalvia[_source] = false
end)

local function TransformSalvia(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToProcessSalvia, function()
		if PlayersTransformingSalvia[source] == true then
			local salviaQuantity = xPlayer.getInventoryItem('salvia').count
			local poochQuantity = xPlayer.getInventoryItem('salvia_pooch').count

			local legit = ensureLegitness(xPlayer, Config.Zones.SalviaProcessing);
			if legit["legit"] == true then

				if poochQuantity > 20 then
					xPlayer.showNotification(_U('too_many_pouches'))
				elseif salviaQuantity < 20 then
					xPlayer.showNotification(_U('not_enough_salvia'))
				else
					xPlayer.removeInventoryItem('salvia', 20)
					xPlayer.addInventoryItem('salvia_pooch', 2)
				
					TransformSalvia(source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Process Salvia", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to process ^2salvia^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startTransformSalvia')
AddEventHandler('esx-drugs:startTransformSalvia', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	PlayersTransformingSalvia[_source] = true
	xPlayer.showNotification(_U('packing_in_prog'))
	TransformSalvia(_source)
end)

RegisterServerEvent('esx-drugs:stopTransformSalvia')
AddEventHandler('esx-drugs:stopTransformSalvia', function()
	local _source = source

	PlayersTransformingSalvia[_source] = false
end)

local function SellSalvia(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToSellSalvia, function()
		if PlayersSellingSalvia[source] == true then
			local poochQuantity = xPlayer.getInventoryItem('salvia_pooch').count

			local legit = ensureLegitness(xPlayer, Config.Zones.SalviaDealer);
			if legit["legit"] == true then
				if poochQuantity == 0 then
					xPlayer.showNotification(_U('no_pouches_salvia_sale'))
				else
					xPlayer.removeInventoryItem('salvia_pooch', 1)
					xPlayer.addAccountMoney('black_money', 60000)
					xPlayer.showNotification(_U('sold_one_salvia'))		
					SellSalvia(source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Sell Salvia", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to sell ^2salvia^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startSellSalvia')
AddEventHandler('esx-drugs:startSellSalvia', function()
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)

	PlayersSellingSalvia[_source] = true
	xPlayer.showNotification(_U('sale_in_prog'))
	SellSalvia(_source)
end)

RegisterServerEvent('esx-drugs:stopSellSalvia')
AddEventHandler('esx-drugs:stopSellSalvia', function()
	local _source = source

	PlayersSellingSalvia[_source] = false
end)
-------------------------------------------------------
-----------------------Salvia--------------------------
-------------------------------------------------------


-------------------------------------------------------
-----------------------Ecstasy--------------------------
-------------------------------------------------------
local function HarvestEcstasy(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToFarmEcstasy, function()
		if PlayersHarvestingEcstasy[source] == true then
			local ecstasy = xPlayer.getInventoryItem('ecstasy')

			local legit = ensureLegitness(xPlayer, Config.Zones.EcstasyField);
			if legit["legit"] == true then
				if ecstasy.limit ~= -1 and ecstasy.count >= ecstasy.limit then
					TriggerClientEvent('esx:showNotification', _source, _U('inv_full_ecstasy'))
				else
					xPlayer.addInventoryItem('ecstasy', 1)
					HarvestEcstasy(_source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Harvest Ecstasy", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to collect ^2ecstasy^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startHarvestEcstasy')
AddEventHandler('esx-drugs:startHarvestEcstasy', function()
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)

	PlayersHarvestingEcstasy[_source] = true
	xPlayer.showNotification(_U('pickup_in_prog'))
	HarvestEcstasy(_source)
end)

RegisterServerEvent('esx-drugs:stopHarvestEcstasy')
AddEventHandler('esx-drugs:stopHarvestEcstasy', function()
	local _source = source

	PlayersHarvestingEcstasy[_source] = false
end)

local function TransformEcstasy(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToProcessEcstasy, function()
		if PlayersTransformingEcstasy[source] == true then
			local ecstasyQuantity = xPlayer.getInventoryItem('ecstasy').count
			local poochQuantity = xPlayer.getInventoryItem('ecstasy_pooch').count

			local legit = ensureLegitness(xPlayer, Config.Zones.EcstasyProcessing);
			if legit["legit"] == true then

				if poochQuantity > 20 then
					xPlayer.showNotification(_U('too_many_pouches'))
				elseif ecstasyQuantity < 20 then
					xPlayer.showNotification(_U('not_enough_ecstasy'))
				else
					xPlayer.removeInventoryItem('ecstasy', 20)
					xPlayer.addInventoryItem('ecstasy_pooch', 2)
				
					TransformEcstasy(source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Process Ecstasy", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to process ^2ecstasy^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startTransformEcstasy')
AddEventHandler('esx-drugs:startTransformEcstasy', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	PlayersTransformingEcstasy[_source] = true
	xPlayer.showNotification(_U('packing_in_prog'))
	TransformEcstasy(_source)
end)

RegisterServerEvent('esx-drugs:stopTransformEcstasy')
AddEventHandler('esx-drugs:stopTransformEcstasy', function()
	local _source = source

	PlayersTransformingEcstasy[_source] = false
end)

local function SellEcstasy(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToSellEcstasy, function()
		if PlayersSellingEcstasy[source] == true then
			local poochQuantity = xPlayer.getInventoryItem('ecstasy_pooch').count

			local legit = ensureLegitness(xPlayer, Config.Zones.EcstasyDealer);
			if legit["legit"] == true then
				if poochQuantity == 0 then
					xPlayer.showNotification(_U('no_pouches_ecstasy_sale'))
				else
					xPlayer.removeInventoryItem('ecstasy_pooch', 1)
					xPlayer.addAccountMoney('black_money', 45000)
					xPlayer.showNotification(_U('sold_one_ecstasy'))		
					SellEcstasy(source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Sell Ecstasy", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to sell ^2ecstasy^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startSellEcstasy')
AddEventHandler('esx-drugs:startSellEcstasy', function()
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)

	PlayersSellingEcstasy[_source] = true
	xPlayer.showNotification(_U('sale_in_prog'))
	SellEcstasy(_source)
end)

RegisterServerEvent('esx-drugs:stopSellEcstasy')
AddEventHandler('esx-drugs:stopSellEcstasy', function()
	local _source = source

	PlayersSellingEcstasy[_source] = false
end)
-------------------------------------------------------
-----------------------Ecstasy-------------------------
-------------------------------------------------------


-------------------------------------------------------
----------------------METH-----------------------------
-------------------------------------------------------
local function HarvestMeth(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToFarmMeth, function()
		if PlayersHarvestingMeth[source] == true then
			local meth = xPlayer.getInventoryItem('meth')

			local legit = ensureLegitness(xPlayer, Config.Zones.MethField);
			if legit["legit"] == true then
				if meth.limit ~= -1 and meth.count >= meth.limit then
					TriggerClientEvent('esx:showNotification', _source, _U('inv_full_meth'))
				else
					xPlayer.addInventoryItem('meth', 1)
					HarvestMeth(_source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Harvest Meth", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to collect ^2meth^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startHarvestMeth')
AddEventHandler('esx-drugs:startHarvestMeth', function()
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)

	PlayersHarvestingMeth[_source] = true
	xPlayer.showNotification(_U('pickup_in_prog'))
	HarvestMeth(_source)
end)

RegisterServerEvent('esx-drugs:stopHarvestMeth')
AddEventHandler('esx-drugs:stopHarvestMeth', function()
	local _source = source

	PlayersHarvestingMeth[_source] = false
end)

local function TransformMeth(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToProcessMeth, function()
		if PlayersTransformingMeth[source] == true then
			local methQuantity = xPlayer.getInventoryItem('meth').count
			local poochQuantity = xPlayer.getInventoryItem('meth_pooch').count

			local legit = ensureLegitness(xPlayer, Config.Zones.MethProcessing);
			if legit["legit"] == true then

				if poochQuantity > 20 then
					xPlayer.showNotification(_U('too_many_pouches'))
				elseif methQuantity < 20 then
					xPlayer.showNotification(_U('not_enough_meth'))
				else
					xPlayer.removeInventoryItem('meth', 20)
					xPlayer.addInventoryItem('meth_pooch', 2)
				
					TransformMeth(source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Process Meth", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to process ^2meth^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startTransformMeth')
AddEventHandler('esx-drugs:startTransformMeth', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	PlayersTransformingMeth[_source] = true
	xPlayer.showNotification(_U('packing_in_prog'))
	TransformMeth(_source)
end)

RegisterServerEvent('esx-drugs:stopTransformMeth')
AddEventHandler('esx-drugs:stopTransformMeth', function()
	local _source = source

	PlayersTransformingMeth[_source] = false
end)

local function SellMeth(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = ""

	for _, idents in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(idents, 1, string.len("steam:")) == "steam:" then
			steamid = idents
		end
	end
	SetTimeout(Config.TimeToSellMeth, function()
		if PlayersSellingMeth[source] == true then
			local poochQuantity = xPlayer.getInventoryItem('meth_pooch').count

			local legit = ensureLegitness(xPlayer, Config.Zones.MethDealer);
			if legit["legit"] == true then
				if poochQuantity == 0 then
					xPlayer.showNotification(_U('no_pouches_meth_sale'))
				else
					xPlayer.removeInventoryItem('meth_pooch', 1)
					xPlayer.addAccountMoney('black_money', 50000)
					xPlayer.showNotification(_U('sold_one_meth'))		
					SellMeth(source)
				end
			else
				TriggerEvent("menacerp:discordlog", "Tried to Sell Meth", "**Name: **"..GetPlayerName(xPlayer.source).." (ID: "..tonumber(source)..") ("..steamid..")\n**Details: **"..legit["reason"].."\n**Resource: **"..GetCurrentResourceName(), "https://discord.com/api/webhooks/813206532006346782/Z4IC3A-DBurQsOFIGUqk4NQm48hzy3eda-PJiEp-YmHtjFdGt4FNi3dC5caf0YkwegWk", 'Exploit')
				print(
					string.format(
						"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to sell ^2meth^7 but the legitness check returned false because ^1%s^7.",
						GetCurrentResourceName(), _source, GetPlayerName(_source), legit["reason"]
					)
				)
			end
		end
	end)
end

RegisterServerEvent('esx-drugs:startSellMeth')
AddEventHandler('esx-drugs:startSellMeth', function()
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)

	PlayersSellingMeth[_source] = true
	xPlayer.showNotification(_U('sale_in_prog'))
	SellMeth(_source)
end)

RegisterServerEvent('esx-drugs:stopSellMeth')
AddEventHandler('esx-drugs:stopSellMeth', function()
	local _source = source

	PlayersSellingMeth[_source] = false
end)
-------------------------------------------------------
----------------------METH-----------------------------
-------------------------------------------------------






RegisterServerEvent('esx-drugs:GetUserInventory')
AddEventHandler('esx-drugs:GetUserInventory', function(currentZone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx-drugs:ReturnInventory', 
		_source, 
		xPlayer.getInventoryItem('coke').count, 
		xPlayer.getInventoryItem('coke_pooch').count,
		xPlayer.getInventoryItem('salvia').count, 
		xPlayer.getInventoryItem('salvia_pooch').count,
		xPlayer.getInventoryItem('ecstasy').count, 
		xPlayer.getInventoryItem('ecstasy_pooch').count,
		xPlayer.getInventoryItem('meth').count, 
		xPlayer.getInventoryItem('meth_pooch').count, 
		xPlayer.getInventoryItem('weed').count, 
		xPlayer.getInventoryItem('weed_pooch').count, 
		xPlayer.getInventoryItem('opium').count, 
		xPlayer.getInventoryItem('opium_pooch').count,
		xPlayer.job.name, 
		currentZone
	)
end)

ESX.RegisterUsableItem('weed', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('weed', 1)

	TriggerClientEvent('esx-drugs:onPot', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_weed'))
end)

ESX.RegisterUsableItem('meth', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('meth', 1)

	TriggerClientEvent('esx-drugs:onMeth', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_meth'))
end)

ESX.RegisterUsableItem('opium', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('opium', 1)

	TriggerClientEvent('esx-drugs:onOpium', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_opium'))
end)

ESX.RegisterUsableItem('coke', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('coke', 1)

	TriggerClientEvent('esx-drugs:onCoke', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_coke'))
end)

ESX.RegisterUsableItem('ecstasy', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('ecstasy', 1)

	TriggerClientEvent('esx-drugs:onEcstasy', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_ecstasy'))
end)

ESX.RegisterUsableItem('salvia', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('salvia', 1)

	TriggerClientEvent('esx-drugs:onSalvia', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_salvia'))
end)