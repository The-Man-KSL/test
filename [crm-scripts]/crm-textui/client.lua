function Open(message, color, position)
	SendNUIMessage({
		action = 'open',
		message = message,
		color = color,
		position = position,
	})
end

function Close()
	SendNUIMessage({
		action = 'close'
	})
end

RegisterNetEvent('crm-textui:Open')
AddEventHandler('crm-textui:Open', function(message, color, position)
	Open(message, color, position)
end)

RegisterNetEvent('crm-textui:Close')
AddEventHandler('crm-textui:Close', function()
	Close()
end)