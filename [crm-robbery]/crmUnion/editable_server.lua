RegisterServerEvent('unionheist:server:policeAlert')
AddEventHandler('unionheist:server:policeAlert', function(coords)
    if Config['UnionHeist']['framework']['name'] == 'ESX' then
        local players = ESX.GetPlayers()
        for i = 1, #players do
            local player = ESX.GetPlayerFromId(players[i])
            if player['job']['name'] == Config['UnionHeist']['setjobForPolice'] then
                TriggerClientEvent('unionheist:client:policeAlert', players[i], coords)
            end
        end
    elseif Config['UnionHeist']['framework']['name'] == 'QB' then
        local players = QBCore.Functions.GetPlayers()
        for i = 1, #players do
            local player = QBCore.Functions.GetPlayer(players[i])
            if player.PlayerData.job.name == Config['UnionHeist']['setjobForPolice'] then
                TriggerClientEvent('unionheist:client:policeAlert', players[i], coords)
            end
        end
    end
end)

discord = {
    ['webhook'] = 'https://discord.com/api/webhooks/1126120858214223932/QeRKLmxL6YyzRnuOezHt5CvQ98ZKZaQ6viEMA-i03Zk_lHzFJ7NJXb8Bxq5hE1aQVY2I',
    ['name'] = 'CRM Union',
    ['image'] = 'https://cdn.discordapp.com/avatars/869260464775921675/dff6a13a5361bc520ef126991405caae.png?size=1024'
}

function discordLog(name, message)
    local data = {
        {
            ["color"] = '3553600',
            ["title"] = "**".. name .."**",
            ["description"] = message,
        }
    }
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end