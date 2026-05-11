FIRST OF ALL, THANK YOU FOR PURCHASING MY SCRIPT
INSTALLATION STEP BY STEP 
1. MAKE SURE YOU'RE USING ESX
2. INSERT THE SQL, RESTART THE SERVER START THE SCRIPT
3. EDIT EVERYTHING HOWEVER YOU WANT, IN CONFIG OR THE OTHER FILES
FOR ANY OTHER QUESTIONS MAKE SURE TO JOIN MY DISCORD SERVER https://discord.gg/TE9RAZGTuz
                                       TY <3

NOTE : 
IF YOU ARE USING OX INVENTORY YOU DONT NEED TO INSERT THE SQL FILE 

JUST ADD THESE LINES TO>

**ox_inventory/data/items.lua**

	['container'] = {
		label = 'Container',
		weight = 100,
		stack = true,
		close = true
	},

**ox_inventory/modules/items/client.lua**

Item('container', function(data, slot)
	TriggerServerEvent('a_container_opening')
	exports.ox_inventory:closeInventory()
end)