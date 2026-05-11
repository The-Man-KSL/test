ESX = exports['crm-core']:getSharedObject()
local PlayerData = {}
local curGang = nil
local curRank = nil
local menu_open = false 
local inside_menu = false
local vehicle_spawn_timer = 0
local IsDead = false
local lastvalid = nil
local zones = GangCFG.Zones
local inside_zone = false
local last_zone = nil
local kills = 0
local headshots = 0



RegisterNetEvent('gangkillsevents:Kills')
AddEventHandler('gangkillsevents:Kills', function(_kills)
   kills = _kills
end)

RegisterNetEvent('esx_gangs:UpdateClient')
AddEventHandler('esx_gangs:UpdateClient', function(_gang, _rank)
  curGang = _gang.name
  curRank = _rank.ranking
--[[   SendNUIMessage({
    type    = "update",
    data  = {gang = _gang, rank = _rank},
  }) ]] 
end)
AddEventHandler('gameEventTriggered', function(name, args)
    if name ~= 'CEventNetworkEntityDamage' then return end;
	if inDaZone == true then	
        local killedPedId = tonumber(args[1])
        local killerPedId = tonumber(args[2])
        local bulletHit, boneHit = GetPedLastDamageBone(killedPedId)
        if IsEntityAPed(killerPedId) and IsEntityAPed(killedPedId) and (IsEntityDead(killedPedId)) and (IsPedAPlayer(killerPedId)) and (killerPedId == PlayerPedId()) then
                local killerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(killerPedId))
                if bulletHit then
                if (boneHit == 31086) then
				headshots = headshots + 1
			   end
            end
        end
    end
end)


CreateThread(function()
    local isDead = false
    local hasBeenDead = false
    local diedAt
    while (true) do
        Wait(4)
        if inDaZone then
        local player = PlayerId()
            local ped = PlayerPedId()
            if IsPedFatallyInjured(ped) and not isDead then
                isDead = true
                if not diedAt then
                diedAt = GetGameTimer()
          end
            local killer, killerweapon = NetworkGetEntityKillerOfPlayer(player)
            local killerentitytype = GetEntityType(killer)
            local killertype = -1
            local killerid = GetPlayerByEntityID(killer)
            if killer ~= ped and killerid ~= nil and NetworkIsPlayerActive(killerid) then killerid = GetPlayerServerId(killerid)
            else killerid = -1
            end
                if killer == ped or killer == -1 then
                    TriggerEvent('gangkillsevents:onPlayerDied', killertype, { table.unpack(GetEntityCoords(ped)) })
                    TriggerServerEvent('gangkillsevents:onPlayerDied', killertype, { table.unpack(GetEntityCoords(ped)) })
                    hasBeenDead = true
                else
                    TriggerEvent('gangkillsevents:onPlayerKilled', killerid, {killertype=killertype, weaponhash = killerweapon, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos={table.unpack(GetEntityCoords(ped))}})
                    TriggerServerEvent('gangkillsevents:onPlayerKilled', killerid, {killertype=killertype, weaponhash = killerweapon, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos={table.unpack(GetEntityCoords(ped))}})
                    hasBeenDead = true
                end
            elseif not IsPedFatallyInjured(ped) then
                isDead = false
                diedAt = nil
            end
        else Wait(1000)
        end
    end
 end)

function GetPlayerByEntityID(id)
   for i, player in pairs(GetActivePlayers()) do
       if (GetPlayerPed(player) == id) then
           return player
       end
   end
  return nil
end

RegisterNetEvent('gangkillsevents:onPlayerKilled')
AddEventHandler('gangkillsevents:onPlayerKilled', function(killerId)
    TriggerServerEvent('gangkillsevents:Killed', killerId)
      local ped = PlayerPedId()
      if inDaZone == true and IsEntityDead(ped) then
        kills = 0
        deaths = deaths + 1
        headshots = 0
        local spawn = math.random(#Killstreaks.ReviveZones)
        SetEntityCoords(ped,Killstreaks.ReviveZones[spawn][1],Killstreaks.ReviveZones[spawn][2],Killstreaks.ReviveZones[spawn][3]+0.001,250.02+0.0001,1,0,0,1)
        TriggerEvent(Killstreaks.Settings.ReviveTrigger)
    end
end)

RegisterNetEvent('gangkillsevents:onPlayerDied')
AddEventHandler('gangkillsevents:onPlayerDied', function()
   local ped = PlayerPedId()
   if inDaZone == true and IsEntityDead(ped) then
        kills = 0
        deaths = deaths + 1
        headshots = 0
        local spawn = math.random(#Killstreaks.ReviveZones)
        SetEntityCoords(ped,Killstreaks.ReviveZones[spawn][1],Killstreaks.ReviveZones[spawn][2],Killstreaks.ReviveZones[spawn][3]+0.001,250.02+0.0001,1,0,0,1)
        TriggerEvent(Killstreaks.Settings.ReviveTrigger)
   end
end)


Citizen.CreateThread(function()
  while (true) do 
    TriggerServerEvent("esx_gangs:InitializeClient")
    Wait(10000)

  end
  end)


Citizen.CreateThread(function()
Wait(1000)
  TriggerServerEvent("esx_gangs:InitializeClient")
  ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx_gangs:UpdateClient')
AddEventHandler('esx_gangs:UpdateClient', function(_gang, _rank)
  curGang = _gang.name
  curRank = _rank.ranking

end)

RegisterNetEvent('esx_gangs:UpdateZones')
AddEventHandler('esx_gangs:UpdateZones', function(_zones)
  zones = _zones
end)

local function playerDied()
  if (last_zone ~= nil and zones[last_zone].capturing) then
    TriggerServerEvent("esx_gangs:AddDeadPlayer", last_zone)
  end
end


RegisterCommand('turfcolor', function()
	OpenTurfColorMenu()


end)


OpenTurfColorMenu = function()
	local input = lib.inputDialog('Turf Color', {
		
		{type = 'color', label = 'Colour input', default = '#eb4034'},
	  })
	  
	  print(input[1])
	  
	  -- Getting r, g and b values from colour picker
	  local b = string.match(input[1], "rgb%((%d+), (%d+), (%d+)%)")
	  function hex2rgb(hex)
		hex = hex:gsub("#","")
		return { r = tonumber("0x"..hex:sub(1,2)), g = tonumber("0x"..hex:sub(3,4)), b = tonumber("0x"..hex:sub(5,6))}
	end
LocalPlayer.state:set('color', hex2rgb(input[1]),false)


end

local color = { r = 83, g = 83, b = 83}
LocalPlayer.state:set('color', color,false)

AddEventHandler('baseevents:onPlayerDied', function(killerType, coords)
	kills = 0
	headshots = 0
	playerDied()
end)

AddEventHandler('baseevents:onPlayerKilled', function(killerId, data)
	kills = 0
	headshots = 0
	playerDied()
end)
local function DrawZoneTimer(bool, _zone)
	local zone = zones[_zone]
	SendNUIMessage({
		action = 'ShowGangTurfUI',
		toggle_gang = bool,
		turfLabel = zone.Label,
		turfTimer = zone.timer,
		turfKills = kills,
		turfMoney = money
	})
end

-- local function DrawZoneTimer(_zone)
-- 	local x = 0.88
-- 	local y = 0.505
-- 	local width = 1.0
-- 	local height = 1.0
-- 	local scale = 0.37 --43
-- 	local text = ""
-- 	if (_zone ~= -1) then
-- 		local zone = zones[_zone]
-- 		if (zone.timer ~= nil) then
--       text = "~c~".. zone.Label .." - ~c~Time Until Capture ~c~: " .. zone.timer .. " seconds~c~"
-- 		end
-- 	end
-- 	if AOPLocation == 1 or AOPLocation == 4 then
-- 		SetTextCentre(true)
-- 	end
-- 	SetTextFont(7)
-- 	SetTextProportional(0)
-- 	SetTextScale(scale, scale)
-- 	SetTextColour(83, 83, 83, 255)
-- 	SetTextDropShadow(83, 83, 83, 0,255)
-- 	SetTextEdge(2, 0, 83, 83, 83)
-- 	SetTextDropShadow()
-- 	SetTextOutline()
-- 	SetTextEntry("STRING")
-- 	AddTextComponentString(text)
-- 	DrawText(x - width/2, y - height/2 + 0.005)
-- end
local function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local function OpenMenu(menu, params)
	ESX.TriggerServerCallback('esx_gangs:allowedToManage', function(result)
	  if (not result and menu ~= "vehicle" and menu ~= "vehicle_return") then
		lib.notify({
			title = 'CRM RP',
			description = 'You are not permitted to manage this gang',
			type = 'error'
		})
	else
		menu_open = true
		local gang = curGang
		if (menu == "manage") and notAllowedToManage ~= 1 then
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gangs_manage_main',
		  {
			  title    = "Gang Management (".. gang ..")",
			  align    = 'top-left',
			  elements = {
				{label = "Invite Players", value = "invite"},
				{label = "Manage Members", value = "members"},
				{label = "Inventory", value = "inventory"},
			  }
		  }, function(data, menu)
			  menu.close()
			  local option = data.current.value
			  OpenMenu(option)
		  end, function(data, menu)
			menu.close()
		  end)
		elseif (menu == "inventory") then
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gangs_inventory_method',
		  {
			  title    = "Gang Inventory",
			  align    = 'top-left',
			  elements = {
				{label = "Deposit Money and/or Items", value = "add_items"},
				{label = "Withdraw Money and/or Items", value = "remove_items"},
			  }
		  }, function(data, menu)
			menu.close()
			OpenMenu(data.current.value)
		  end, function(data, menu)
			menu.close()
			OpenMenu("manage")
		  end)
		elseif (menu == "add_items") then
		  ESX.TriggerServerCallback('esx_gangs:getPlayerInventory', function(result) 
			local list = {}
			if (result ~= nil) then
				local cash = result.cash
				local dcash = result.dcash
				table.insert(list, {label = "Cash: $"..result.cash, value = "cash"})
				table.insert(list, {label = "Dirty Money: $"..result.dcash, value = "dcash"})
				for k,v in pairs(result.inventory) do
					local item = v
					table.insert(list, {label = item.label .. "(x".. item.count ..")", value = item})
				end
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gangs_inventory_add',
				{
					title    = "Deposit Money and/or Items",
					align    = 'top-left',
					elements = list
				}, function(data, menu)
					menu.close()
					if (data.current.value ~= "cash" and data.current.value ~= "dcash") then 
					  local item = data.current.value
					  ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'gangs_inventory_item_deposit', {title = "Deposit " .. item.label .. " into inventory"}, 
					  function(data, menu)
						  menu.close()
						  local count = tonumber(data.value)
						  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gangs_inventory_item_deposit_confirm',
						  {
							  title    = "Are you sure you want to deposit " .. item.label .."(x"..count..") into inventory?",
							  align    = 'top-left',
							  elements = {
								  {label = "Yes", value = "yes"},
								  {label = "No", value = "no"},
							  }
						  }, function(data, menu)
							  menu.close()
							  if (data.current.value == "yes") then 
								TriggerServerEvent("esx_gangs:DepositItem", item.name, count)
							  end
							  OpenMenu("add_items")
						  end, function(data, menu)
							  menu.close()
							  OpenMenu("add_items")
						  end)
					  end, function(data, menu)
						  menu.close()
						  OpenMenu("add_items")
					  end)
					else
						local option = data.current.value
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'gangs_inventory_cash_deposit', {title = "Deposit $" .. ( option == "cash" and "Cash" or "Dirty Money") .. " into inventory"}, 
						function(data, menu)
							menu.close()
							local count = tonumber(data.value)
							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gangs_inventory_cash_deposit_confirm',
							{
								title    = "Are you sure you want to deposit $" .. count .. " in ".. ( option == "cash" and "Cash" or "Dirty Money") .."?",
								align    = 'top-left',
								elements = {
									{label = "Yes", value = "yes"},
									{label = "No", value = "no"},
								}
							}, function(data, menu)
								menu.close()
								if (data.current.value == "yes") then 
								  TriggerServerEvent("esx_gangs:DepositItem", option, count)
								end
								OpenMenu("add_items")
							end, function(data, menu)
								menu.close()
								OpenMenu("add_items")
							end)
						end, function(data, menu)
							menu.close()
							OpenMenu("add_items")
						end)
					end
				end, function(data, menu)
					menu.close()
					OpenMenu("inventory")
				end)
			end
		  end, gang)
		elseif (menu == "remove_items") then
		  ESX.TriggerServerCallback('esx_gangs:getInventory', function(result) 
			local list = {}
			if (result ~= nil) then
				local cash = result.cash
				local dcash = result.dcash
				table.insert(list, {label = "Cash: $"..result.cash, value = "cash"})
				table.insert(list, {label = "Dirty Money: $"..result.dcash, value = "dcash"})
				for k,v in pairs(result.items) do
					local item = v
					table.insert(list, {label = item.label .. "(x".. item.count ..")", value = item})
				end				
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gangs_inventory_remove',
				{
					title    = "Withdraw Money and/or Items",
					align    = 'top-left',
					elements = list
				}, function(data, menu)
					menu.close()
					if (data.current.value ~= "cash" and data.current.value ~= "dcash") then 
					  local item = data.current.value
					  ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'gangs_inventory_item_remove', {title = "Withdraw " .. item.label .. " from inventory"}, 
					  function(data, menu)
						  menu.close()
						  local count = tonumber(data.value)
						  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gangs_inventory_item_remove_confirm',
						  {
							  title    = "Are you sure you want to remove " .. item.label .."(x"..count..") from the inventory?",
							  align    = 'top-left',
							  elements = {
								  {label = "Yes", value = "yes"},
								  {label = "No", value = "no"},
							  }
						  }, function(data, menu)
							  menu.close()
							  if (data.current.value == "yes") then 
								TriggerServerEvent("esx_gangs:RemoveItem", item.name, count)
							  end
							  OpenMenu("remove_items")
						  end, function(data, menu)
							  menu.close()
							  OpenMenu("remove_items")
						  end)
					  end, function(data, menu)
						  menu.close()
						  OpenMenu("remove_items")
					  end)
					else
						local option = data.current.value
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'gangs_inventory_cash_remove', {title = "Withdraw " .. ( option == "cash" and "Cash" or "Dirty Money") .. " into inventory"}, 
						function(data, menu)
							menu.close()
							local count = tonumber(data.value)
							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gangs_inventory_cash_remove_confirm',
							{
								title    = "Are you sure you want to remove $" .. count .. " in ".. ( option == "cash" and "Cash" or "Dirty Money") .."?",
								align    = 'top-left',
								elements = {
									{label = "Yes", value = "yes"},
									{label = "No", value = "no"},
								}
							}, function(data, menu)
								menu.close()
								if (data.current.value == "yes") then 
								  TriggerServerEvent("esx_gangs:RemoveItem", option, count)
								end
								OpenMenu("remove_items")
							end, function(data, menu)
								menu.close()
								OpenMenu("remove_items")
							end)
						end, function(data, menu)
							menu.close()
							OpenMenu("remove_items")
						end)
					end
				end, function(data, menu)
					menu.close()
					OpenMenu("inventory")
				end)
			end
		  end, gang)
		elseif (menu == "invite") then
		  ESX.TriggerServerCallback('esx_gangs:getInvitablePlayers', function(result)
			local list = {}
			if (result ~= nil) then
			  for i=1, #result do
				table.insert(list, {label = result[i].name .. " (id: ".. result[i].sid ..")", value = result[i].id})
			  end
			  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gangs_invite_players',
			  {
				  title    = "Members (".. gang ..")",
				  align    = 'top-left',
				  elements = list
			  }, function(data, menu)
				menu.close()
				local i_id = data.current.value
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gangs_invite_players_confirm',
				{
					title    = "Are you sure you want to invite " .. data.current.label .. "?",
					align    = 'top-left',
					elements = {
					  {label = "Yes", value = "yes"},
					  {label = "No", value = "no"},
					}
				}, function(data, menu)
				  menu.close()
				  if (data.current.value == "yes") then 
					TriggerServerEvent("esx_gangs:InvitePlayer", i_id)
					Wait(200)
					OpenMenu("invite")
				  elseif (data.current.value == "no") then 
					OpenMenu("invite")
				  end
				end, function(data, menu)
				  menu.close()
				  OpenMenu("invite")
				end)
			  end, function(data, menu)
				menu.close()
				OpenMenu("manage")
			  end)
			end
		  end, gang)
		elseif (menu == "members") then
		  ESX.TriggerServerCallback('esx_gangs:getMembers', function(result)
			local list = {}
			if (result ~= nil) then
			  for i=1, #result do
				table.insert(list, {label = result[i].name .. " (Rank: ".. result[i].rank.label ..")", value = result[i].id})
			  end
			  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gangs_manage_players',
			  {
				  title    = "Members: (".. #result ..") Gang: (".. gang ..")",
				  align    = 'top-left',
				  elements = list
			  }, function(data, menu)
				menu.close()
				OpenMenu("player_options", {id = data.current.value})
			  end, function(data, menu)
				menu.close()
				OpenMenu("manage")
			  end)
			end
		  end, gang)
		elseif (menu == "player_options") then
		  ESX.TriggerServerCallback('esx_gangs:getMember', function(result)
			if (result ~= nil) then
			  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gangs_manage_player',
			  {
				  title    = "Manage Player: " .. result.firstname,
				  align    = 'top-left',
				  elements = {
					{label = "Promote Player", value = "promote"},
					{label = "Demote Player", value = "demote"},
					{label = "Fire Player", value = "fire"},
				  }
			  }, function(data, menu)
				menu.close()
				OpenMenu(data.current.value, {data = result})
			  end, function(data, menu)
				menu.close()
				OpenMenu("members")
			  end)
			end
		  end, gang, params.id)
		elseif (menu == "promote") then
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gangs_manage_players_promote',
		  {
			  title    = "Are you sure you want to promote " .. params.data.firstname .. "?",
			  align    = 'top-left',
			  elements = {
				{label = "Yes", value = "yes"},
				{label = "No", value = "no"},
			  }
		  }, function(data, menu)
			menu.close()
			if (data.current.value == "yes") then 
			  TriggerServerEvent("esx_gangs:PromotePlayer", params.data.identifier)
			  Wait(200)
			  OpenMenu("members")
			elseif (data.current.value == "no") then 
			  OpenMenu("player_options", params.data.identifier)
			end
		  end, function(data, menu)
			menu.close()
			OpenMenu("player_options", params.data.identifier)
		  end)
		elseif (menu == "demote") then
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gangs_manage_players_demote',
		  {
			  title    = "Are you sure you want to demote " .. params.data.firstname .. "?",
			  align    = 'top-left',
			  elements = {
				{label = "Yes", value = "yes"},
				{label = "No", value = "no"},
			  }
		  }, function(data, menu)
			menu.close()
			if (data.current.value == "yes") then 
			  TriggerServerEvent("esx_gangs:DemotePlayer", params.data.identifier)
			  Wait(200)
			  OpenMenu("members")
			elseif (data.current.value == "no") then 
			  OpenMenu("player_options")
			end
		  end, function(data, menu)
			menu.close()
			OpenMenu("player_options")
		  end)
		elseif (menu == "fire") then
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gangs_manage_players_fire',
		  {
			  title    = "Are you sure you want to fire " .. params.data.firstname .. "?",
			  align    = 'top-left',
			  elements = {
				{label = "Yes", value = "yes"},
				{label = "No", value = "no"},
			  }
		  }, function(data, menu)
			menu.close()
			if (data.current.value == "yes") then 
			  TriggerServerEvent("esx_gangs:FirePlayer", params.data.identifier)
			  Wait(200)
			  OpenMenu("members")
			elseif (data.current.value == "no") then 
			  OpenMenu("player_options")
			end
		  end, function(data, menu)
			menu.close()
			OpenMenu("player_options")
		  end)
		end
	  end
	end)
end

local function ZoneInteracted(_zone)
	if (not zones[_zone].capturing and curGang ~= nil) then
	  TriggerServerEvent("esx_gangs:zoneInteracted", _zone)
	elseif (curGang == nil) then
	  TriggerEvent('esx:showNotification', "You are not in a gang.")
	else
	  TriggerEvent('esx:showNotification', "This zone is already in a Turf War. Capture it for your gang!")
	end
  end
Citizen.CreateThread(function()
  local dontSkip = true
  while true do
    Citizen.Wait(0)
    local player = {}
    player.x, player.y, player.z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    if (curGang ~= nil and GangCFG.Gangs[curGang] ~= nil) then 
      local gang_table = GangCFG.Gangs[curGang].Markers
      local marker_list = {gang_table.Management, gang_table.VehicleSpawn, gang_table.VehicleReturn}
      local action_list = {"manage", "vehicle", "vehicle_return"}  
      local label_list = {"manage the gang.", "retrieve a gang vehicle.", "return a gang vehicle"}
      local set_zone = false
      for i=1, #marker_list do
        local marker = marker_list[i]
        if (Vdist(marker.Location.x, marker.Location.y, marker.Location.z, player.x, player.y, player.z) <= 10.0) then
          dontSkip = true
          DrawMarker(1, marker.Location.x, marker.Location.y, marker.Location.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 1.0, 83, 83, 83, 255, false, false, false, false, false, false)
          if (Vdist(marker.Location.x, marker.Location.y, marker.Location.z, player.x, player.y, player.z) <= 1.75) then
            inside_menu = true
            set_zone = true
            if (not menu_open) then
              DisplayHelpText("Press ~INPUT_CONTEXT~ to ".. label_list[i])
              if (IsControlJustReleased(1,  51)) then
                  OpenMenu(action_list[i])
              end
            end
          elseif (not set_zone) then
            inside_menu = false
            if (menu_open) then
              ESX.UI.Menu.CloseAll()
              menu_open = false
            end
          end
        end
      end
    end
    if (not dontSkip) then 
      Citizen.Wait(300)
    end
    dontSkip = false
  end
end)

Citizen.CreateThread(function()
    local dontSkip = true

    while true do 
      Citizen.Wait(0)
      if (curGang ~= nil) then
        local player = {}
        player.x, player.y, player.z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
        for k,v in pairs(zones) do 
          local marker = v
          if (Vdist(marker.Location.x, marker.Location.y, marker.Location.z, player.x, player.y, player.z) <= 25.0) then
            dontSkip = true
            DrawMarker(31, marker.Location.x, marker.Location.y, marker.Location.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, LocalPlayer.state.color.r, LocalPlayer.state.color.g, LocalPlayer.state.color.b, 100, false, false, false, true, false, false)
            if (Vdist(marker.Location.x, marker.Location.y, marker.Location.z, player.x, player.y, player.z) <= 1.75) then
              DisplayHelpText("Press ~INPUT_CONTEXT~ to capture~o~ ".. marker.Label .. ".")
              if (IsControlJustReleased(1,  51)) then
                ZoneInteracted(k)
              end
            end
          end
        end
      end
      if (not dontSkip) then 
        Citizen.Wait(300)
      end
      dontSkip = false
    end
  end)


  CreateThread(function()
        local dontSkip = true
        while (true) do
            Wait(4)
            local player = {}
            player.x, player.y, player.z = table.unpack(GetEntityCoords(PlayerPedId(), true))
            for k, v in pairs(zones) do
                local marker = v
                if (Vdist(marker.Location.x, marker.Location.y, marker.Location.z, player.x, player.y, player.z) <= 80.0) then
                    dontSkip = true
                    if (marker.capturing) then
                        DrawMarker(28, marker.Location.x, marker.Location.y, marker.Location.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 40.0, 40.0, 35.0, LocalPlayer.state.color.r, LocalPlayer.state.color.g, LocalPlayer.state.color.b, 100, false, false, false, false, false, false)
                        if (Vdist(marker.Location.x, marker.Location.y, marker.Location.z, player.x, player.y, player.z) <= 40.0) then
                            --if curGang ~= nil then
                                if  IsPedFatallyInjured(PlayerPedId()) or IsEntityDead(PlayerPedId()) then 
                                    TriggerServerEvent("esx_gangs:PlayerEnteredZone", k)

									SetEntityCoords(PlayerPedId(), marker.Location.x, marker.Location.y-55, marker.Location.z)
                                end
                            DrawZoneTimer(true, k)

                            if (inside_zone == false) then
                                inside_zone = true
                                last_zone = k

                                TriggerServerEvent("esx_gangs:PlayerEnteredZone", k)
                            end
                        --else
                            --SetEntityCoords(PlayerPedId(), marker.Location.x, marker.Location.y-55, marker.Location.z)
                            --ESX.ShowNotification('You must be in a gang to do turfs.')
                        --end
                        elseif (inside_zone == true and last_zone == k) then
                            inside_zone = false                                                                                                                                                                                                                                              
                            DrawZoneTimer(false, k)
                            TriggerServerEvent("esx_gangs:PlayerExitedZone", last_zone)

                        end
                    elseif (last_zone == k) then
                        inside_zone = false
                        last_zone = nil
						DrawZoneTimer(false, k)
                    end
                end
            end
            if (not dontSkip) then
                Wait(1500)
            end
        dontSkip = false
    end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
  IsDead = true
end)

AddEventHandler('playerSpawned', function()
	IsDead = false
end)

local blips = { 
  -- {title="Turf War (Coke Farm)", colour=3, scale = 0.8, id=84, x = 971.05, y = -1505.14, z = 31.30}, 
  -- {title="Turf War (Legion Square)", colour=3, scale = 0.8, id=84, x = 195.35, y = -933.89, z = 30.69},
  -- {title="Turf War (HighSchool)", colour=3, scale = 0.8, id=84, x = -1612.68, y = 185.93, z = 59.78},
  -- {title="Turf War (Money Wash)", colour=3, scale = 0.8, id=84, x = 909.6206, y = -176.0834, z = 74.2188},
  -- {title="Turf War (Mega Mall)", colour=3, scale = 0.8, id=84, x =  26.0335, y = -1738.2416, z = 29.3030},    
}

CreateThread(function()
  while (true) do
    Wait(1000)
    local found = false;
    for k, v in pairs(zones) do
      if (v.timer ~= nil and v.timer > 0) then
        found = true;
        zones[k].timer = zones[k].timer - 1
        if (zones[k].timer <= 0) then
          zones[k].timer = nil
        end
      end
    end
  if found == false then Wait(1000) end
end
end)

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 437)
      SetBlipScale(info.blip, 0.5)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

exports('GetGang', function()
  if (curGang ~= nil) and (curRLabel ~= nil) then
    return({name = curGang, rank = curRLabel})
  else
    return({name = 'NO GANG', rank = 'NO GANG'})
  end
end)

local function formatSecondsToClock(seconds)
	local seconds = tonumber(seconds)
	
	if seconds <= 0 then
		return '00:00'
	else
		hours = string.format('%02.f', math.floor(seconds/3600))
		mins = string.format('%02.f', math.floor(seconds/60 - (hours*60)))
		secs = string.format('%02.f', math.floor(seconds - hours*3600 - mins *60))
		return mins..':'..secs
	end
end

local function openActiveTurfsMenu()
	local options = {}
	local hasActiveTurf = false
	
	for k, v in pairs(zones) do
		if zones[k].capturing then
			options[#options + 1] = {
				icon = 'clock',
				label = 'Active Turf : '..tostring(k) .. ' - ' .. tostring(zones[k].timer) .. 's',
				description = 'Press [ENTER] to teleport to turf!',
				args = { 
					zone = k,
					zoneCoords = zones[k].Location
				}
			}
			hasActiveTurf = true
		end
	end
	
	if not hasActiveTurf then
		options[#options + 1] = {
			label = 'No Active Turfs',
		}
	end
	
	lib.setMenuOptions('active_turfs', options)
	lib.showMenu('active_turfs')
end



lib.registerMenu({ 
	id = 'active_turfs', 
	title = 'Active Turfs', 
	position = 'top-right', 
    options = {}
}, function(selected, scrollIndex, args)
	if (selected ~= nil) then
		if (args ~= nil) then
			if (args.zoneCoords ~= nil) then
                    if not wait then
					    SetEntityCoords(PlayerPedId(), args.zoneCoords.x, args.zoneCoords.y-55, args.zoneCoords.z)
                        wait = true
                        if wait then
                            Wait(300000)
                            wait = false
                        end
                    else
                        ESX.ShowNotification('Please Wait 5 Mins Before Using Again.')
                    end
			end
		end
	end
end)

RegisterCommand('turfs', function()
	openActiveTurfsMenu()
end, false)