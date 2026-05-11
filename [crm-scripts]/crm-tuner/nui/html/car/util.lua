Citizen.CreateThread(
    function()
        Citizen.Wait(550)
      --  print("testutil")
        EnableGui(true)
    end
)

function EnableGui(enable)
    SendNUIMessage({
        type = "enableui",
        enable = enable
    })
end