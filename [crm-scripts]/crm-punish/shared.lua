Config = {
	Locale = GetConvar("esx:locale", "en")
}
if not Translate then Translate = _ end

COMSERV = {
	outCoords = {
		Enable = true,
		Coords = vector3(-541.1122, -210.6382, 37.6498),
	},
	coords = vector3(3086.7490, -4783.5786, 15.2546),
	radius = 50,

	marker = { --task marker
		typ = 1,
		size = 1.5,
		upDown = true,
		color = { 200, 150, 0, 150 },
	},

	blip = {
		icon = 1,
		name = "Current Job",
	},

	model = GetHashKey("prop_tool_broom"),
}

JAIL = {
	cells = {
		vector3(486.8878, -1014.2692, 26.2731),
		vector3(484.0532, -1013.6973, 26.2731),
		vector3(481.1907, -1013.8248, 26.2684),
	},
	outCoords = vector3(-541.1122, -210.6382, 37.6498),
	distance = 3,
}

ADMIN_RANKS = {
	["admin"] = true,
}

-- WEBHOOK = false --discord log is disabled
WEBHOOK = "" --your webhook here

function output(text, target)
	if IsDuplicityVersion() then --Server Side
		TriggerClientEvent("chat:addMessage", target or -1, {
			color = { 255, 0, 0 },
			multiline = true,
			args = { "Server", text },
		})
	else
		TriggerEvent("chat:addMessage", {
			color = { 255, 0, 0 },
			multiline = true,
			args = { "Server", text },
		})
	end
end

if not IsDuplicityVersion() then --Server side
	return
end

function isAdmin(xPlayer)
	if type(xPlayer) ~= "table" then
		xPlayer = ESX.GetPlayerFromId(xPlayer)
	end

	if not xPlayer then
		return false
	end

	local permissions = ADMIN_RANKS[xPlayer.getGroup()]

	if not permissions then
		output(Translate("not_admin"), xPlayer.source)
	end

	return permissions
end
