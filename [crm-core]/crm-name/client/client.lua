Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
	while true do
		Wait(100)
		local coords  = GetEntityCoords(GetPlayerPed(-1))
		if(GetDistanceBetweenCoords(coords, Config.X, Config.Y, Config.Z, 331, true) < Config.Distancelol) then
			isInMarker2  = true
		else
			isInMarker2 = false
		end
		if isInMarker2 then                    
            if IsControlPressed(0, 38) then
				TriggerEvent('ms_namechange:show')
				Wait(1000)
            end
		end
	end
end)


function EditFirstName(data)
	local firstName = data.vorname

	if firstName ~= nil then
		firstName = tostring(firstName)
		
		if type(firstName) == 'string' then
			TriggerServerEvent('ms_namechange:SetFirstName', GetPlayerServerId(PlayerId()), firstName)
		end
	end
end


function EditLastName(data)
	local lastName = data.nachname

	if lastName ~= nil then
		lastName = tostring(lastName)
		
		if type(lastName) == 'string' then
			TriggerServerEvent('ms_namechange:SetLastName', GetPlayerServerId(PlayerId()), lastName)
		end
	end
end


RegisterNetEvent('ms_namechange:show')
AddEventHandler('ms_namechange:show', function(title)
    SendNUIMessage({
        title = title,
    })

    SetNuiFocus(true, true)
end)

RegisterNUICallback('exit', function(data)
   SetNuiFocus(false, false)

end)


RegisterNUICallback('join', function(data, cb)
	local firstName = data.vorname
	local lastName = data.nachname
   TriggerServerEvent('ms_namechange:SetFirstName', GetPlayerServerId(PlayerId()), firstName)
	TriggerServerEvent('ms_namechange:SetLastName', GetPlayerServerId(PlayerId()), lastName)
   SetNuiFocus(false, false)

end)




----- FUNKTIONEN nur


Citizen.CreateThread(function()
    RequestModel(GetHashKey("ig_bankman"))
	
    while not HasModelLoaded(GetHashKey("ig_bankman")) do
        Wait(1)
    end
	

		local npc = CreatePed(4, 0x909D9E7F, Config.X, Config.Y, Config.Z, Config.Heading, true, true)
		SetEntityHeading(211.8321)
		FreezeEntityPosition(npc, true)
		SetEntityInvincible(npc, true)
		SetBlockingOfNonTemporaryEvents(npc, true)	

end)

local function CreateTownhallBlips()

		blip = AddBlipForCoord(Config.X , Config.Y, Config.Z)
		SetBlipSprite(blip, Config.BlipSymbol)
		SetBlipScale(blip, Config.BlipScale)
		SetBlipColour(blip, Config.BlipFarbe)
		SetBlipAsShortRange(blip, false)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.BlipName)
		EndTextCommandSetBlipName(blip)
	
end

Citizen.CreateThread(function()
	CreateTownhallBlips()
end)