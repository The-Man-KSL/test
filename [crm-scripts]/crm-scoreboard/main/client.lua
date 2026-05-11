Framework = nil
Framework = GetFramework()
Citizen.Await(Framework)
if Config.Framework == "NewESX" or Config.Framework == "ESX" then 
    Callback = Framework.TriggerServerCallback
  else
    Callback = Framework.Functions.TriggerCallback
end
  

local display = false

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
end

RegisterNetEvent('es-time')
AddEventHandler('es-time', function(time)
    SendNUIMessage({type = 'TIMER', clock = time})
end)
    

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) 
        if IsControlJustReleased(0, Config.OpenKey) then
            Callback('GetScoreboardData', function(Player, Players, Jobs, Time)
                SendNUIMessage({type = 'MENU', data = Player, users = Players, jobs = Jobs})
            end, GetPlayerServerId(PlayerId()))
            SetDisplay(true)
        end
    end
end)



RegisterNUICallback('exit', function(data, cb)
    SetDisplay(false)
    cb('ok')
end)

