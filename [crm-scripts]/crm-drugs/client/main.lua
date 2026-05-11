ESX = exports[Config.DrugSystem.Configure.ESX.Export]:getSharedObject()

local SleepTime = 500
local SeenMarker = false
local CollectingGoing = false
local ProcessingGoing = false
local SellingGoing = false

Citizen.CreateThread(function()
    for k,v in pairs(Config.DrugSystem.Drugs) do
        BlipC = v.Collecting.Blip
        BlipP = v.Processing.Blip
        BlipS = v.Selling.Blip
        if BlipC.show then
            BlipsC = AddBlipForCoord(BlipC.location)
            SetBlipSprite(BlipsC, BlipC.id)
            SetBlipDisplay(BlipsC, 4)
            SetBlipScale(BlipsC, BlipC.scale)
            SetBlipColour(BlipsC, BlipC.color)
            SetBlipAsShortRange(BlipsC, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(BlipC.label)
            EndTextCommandSetBlipName(BlipsC)
        end
        if BlipP.show then
            BlipsP = AddBlipForCoord(BlipP.location)
            SetBlipSprite(BlipsP, BlipP.id)
            SetBlipDisplay(BlipsP, 4)
            SetBlipScale(BlipsP, BlipP.scale)
            SetBlipColour(BlipsP, BlipP.color)
            SetBlipAsShortRange(BlipsP, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(BlipP.label)
            EndTextCommandSetBlipName(BlipsP)
        end
        if BlipS.show then
            BlipsS = AddBlipForCoord(BlipS.location)
            SetBlipSprite(BlipsS, BlipS.id)
            SetBlipDisplay(BlipsS, 4)
            SetBlipScale(BlipsS, BlipS.scale)
            SetBlipColour(BlipsS, BlipS.color)
            SetBlipAsShortRange(BlipsS, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(BlipS.label)
            EndTextCommandSetBlipName(BlipsS)
        end
    end
end)

function CheckOutOfAreaCollect(drugLocation, interactDistance)
    local Ped = PlayerPedId()
    local PedCoords = GetEntityCoords(Ped)
    if GetDistanceBetweenCoords(drugLocation, PedCoords, true) > interactDistance and CollectingGoing then
        return true
    else
        return false
    end
end

function CheckOutOfAreaProcess(drugLocation, interactDistance)
    local Ped = PlayerPedId()
    local PedCoords = GetEntityCoords(Ped)
    if GetDistanceBetweenCoords(drugLocation, PedCoords, true) > interactDistance and ProcessingGoing then
        return true
    else
        return false
    end
end

function CheckOutOfAreaSell(drugLocation, interactDistance)
    local Ped = PlayerPedId()
    local PedCoords = GetEntityCoords(Ped)
    if GetDistanceBetweenCoords(drugLocation, PedCoords, true) > interactDistance and SellingGoing then
        return true
    else
        return false
    end
end

function AttemptCollect(drug, drugAmount, drugTimeout, attemptType, drugLocation, interactDistance, drugType)
    if attemptType == 'Collect' and CollectingGoing then
        if not CheckOutOfAreaCollect(drugLocation, interactDistance) then
            CollectingGoing = true
            TriggerEvent(Config.DrugSystem.Configure.ESX.Notifications, drugType.Notify.progress)
            Citizen.Wait(drugTimeout * 1000)
            if not CheckOutOfAreaCollect(drugLocation, interactDistance) then
                ESX.TriggerServerCallback('LegacyDrugs:AttemptCollect', function(allowed)
                    if allowed then
                        if drug == 'acid' then
                            TriggerEvent('QuestSystem:TriggerQuest', 3, drugAmount)
                        end
                        AttemptCollect(drug, drugAmount, drugTimeout, attemptType, drugLocation, interactDistance, drugType)
                    else
                        CollectingGoing = false
                    end
                end, drug, drugAmount, drugType)
            else
                CollectingGoing = false
                TriggerEvent(Config.DrugSystem.Configure.ESX.Notifications, drugType.Notify.tooFar)	
            end
        else
            CollectingGoing = false
            TriggerEvent(Config.DrugSystem.Configure.ESX.Notifications, drugType.Notify.tooFar)	
        end
    end
end

function AttemptProcess(drug, drugAmount, drugProcessed, drugProcessedAmount, drugTimeout, attemptType, drugLocation, interactDistance, drugType)
    if attemptType == 'Process' and ProcessingGoing then
        if not CheckOutOfAreaProcess(drugLocation, interactDistance) then
            ProcessingGoing = true
            TriggerEvent(Config.DrugSystem.Configure.ESX.Notifications, drugType.Notify.progress)
            Citizen.Wait(drugTimeout * 1000)
            if not CheckOutOfAreaProcess(drugLocation, interactDistance) then
                ESX.TriggerServerCallback('LegacyDrugs:AttemptProcess', function(allowed)
                    if allowed then
                        AttemptProcess(drug, drugAmount, drugProcessed, drugProcessedAmount, drugTimeout, attemptType, drugLocation, interactDistance, drugType)
                    else
                        ProcessingGoing = false
                    end
                end, drug, drugAmount, drugProcessed, drugProcessedAmount, drugType)
            else
                ProcessingGoing = false
                TriggerEvent(Config.DrugSystem.Configure.ESX.Notifications, drugType.Notify.tooFar)	
            end
        else
            ProcessingGoing = false
            TriggerEvent(Config.DrugSystem.Configure.ESX.Notifications, drugType.Notify.tooFar)	
        end
    end
end

function AttemptSell(drug, drugAmount, drugTimeout, attemptType, drugLocation, interactDistance, drugType)
    if attemptType == 'Sell' and SellingGoing then
        if not CheckOutOfAreaSell(drugLocation, interactDistance) then
            SellingGoing = true
            TriggerEvent(Config.DrugSystem.Configure.ESX.Notifications, drugType.Notify.progress)
            Citizen.Wait(drugTimeout * 1000)
            if not CheckOutOfAreaSell(drugLocation, interactDistance) then
                ESX.TriggerServerCallback('LegacyDrugs:AttemptSell', function(allowed)
                    if allowed then
                        if drug == 'perc_pooch' then
                            TriggerEvent('QuestSystem:TriggerQuest', 12, drugAmount)
                        end
                        AttemptSell(drug, drugAmount, drugTimeout, attemptType, drugLocation, interactDistance, drugType)
                    else
                        SellingGoing = false
                    end
                end, drug, drugAmount, drugType)
            else
                SellingGoing = false
                TriggerEvent(Config.DrugSystem.Configure.ESX.Notifications, drugType.Notify.tooFar)	
            end
        else
            SellingGoing = false
            TriggerEvent(Config.DrugSystem.Configure.ESX.Notifications, drugType.Notify.tooFar)	
        end
    end
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(SleepTime)
        local Ped = PlayerPedId()
        local PedCoords = GetEntityCoords(Ped)
        for k,v in pairs(Config.DrugSystem.Drugs) do
            if GetDistanceBetweenCoords(v.Collecting.Location, PedCoords, true) <= v.Collecting.Marker.seeDistance and not CollectingGoing and not ProcessingGoing and not SellingGoing then
                SeenMarker = true
                SleepTime = 0
                DrawMarker(v.Collecting.Marker.id, v.Collecting.Location, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Collecting.Marker.size.x, v.Collecting.Marker.size.y, v.Collecting.Marker.size.z, v.Collecting.Marker.color.r, v.Collecting.Marker.color.g, v.Collecting.Marker.color.b, v.Collecting.Marker.color.a, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(v.Collecting.Location, PedCoords, true) <= v.Collecting.Marker.interactDistance then
                    ESX.ShowHelpNotification(v.Collecting.Notify.interact)
                    if IsControlJustPressed(0, v.Collecting.Marker.interactButton) then
                        CollectingGoing = true
                        AttemptCollect(v.Collecting.Give.item, v.Collecting.Give.amount, v.Collecting.Give.time, 'Collect', v.Collecting.Location, v.Collecting.Marker.interactDistance, v.Collecting)
                    end
                end
            end
            if GetDistanceBetweenCoords(v.Processing.Location, PedCoords, true) <= v.Processing.Marker.seeDistance and not CollectingGoing and not ProcessingGoing and not SellingGoing then
                SeenMarker = true
                SleepTime = 0
                DrawMarker(v.Processing.Marker.id, v.Processing.Location, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Processing.Marker.size.x, v.Processing.Marker.size.y, v.Processing.Marker.size.z, v.Processing.Marker.color.r, v.Processing.Marker.color.g, v.Processing.Marker.color.b, v.Processing.Marker.color.a, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(v.Processing.Location, PedCoords, true) <= v.Processing.Marker.interactDistance then
                    ESX.ShowHelpNotification(v.Processing.Notify.interact)
                    if IsControlJustPressed(0, v.Processing.Marker.interactButton) then
                        ProcessingGoing = true
                        AttemptProcess(v.Processing.Require.item, v.Processing.Require.amount, v.Processing.Give.item, v.Processing.Give.amount, v.Processing.Give.time, 'Process', v.Processing.Location, v.Processing.Marker.interactDistance, v.Processing)
                    end
                end
            end
            if GetDistanceBetweenCoords(v.Selling.Location, PedCoords, true) <= v.Selling.Marker.seeDistance and not CollectingGoing and not SellingGoing and not SellingGoing then
                SeenMarker = true
                SleepTime = 0
                DrawMarker(v.Selling.Marker.id, v.Selling.Location, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Selling.Marker.size.x, v.Selling.Marker.size.y, v.Selling.Marker.size.z, v.Selling.Marker.color.r, v.Selling.Marker.color.g, v.Selling.Marker.color.b, v.Selling.Marker.color.a, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(v.Selling.Location, PedCoords, true) <= v.Selling.Marker.interactDistance then
                    ESX.ShowHelpNotification(v.Selling.Notify.interact)
                    if IsControlJustPressed(0, v.Selling.Marker.interactButton) then
                        SellingGoing = true
                        AttemptSell(v.Selling.Require.item, v.Selling.Require.amount, v.Selling.Give.time, 'Sell', v.Selling.Location, v.Selling.Marker.interactDistance, v.Selling)
                    end
                end
            end
            if not SeenMarker then
                SleepTime = 500
            end
        end
    end
end)