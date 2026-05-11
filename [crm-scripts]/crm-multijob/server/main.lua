ESX = nil
local JobInfo = {}

TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
  
    end
)

MySQL.ready(function ()


MySQL.Async.fetchAll(
            "SELECT * FROM jobs WHERE 1",
            {},
            function(name)

            	

            	for _,v in ipairs(name) do

            		JobInfo[v.name] = {}
            		JobInfo[v.name].job_label = v.label
            		JobInfo[v.name].grades = {}

            		MySQL.Async.fetchAll(
            "SELECT * FROM job_grades WHERE job_name = @job",
            {['@job'] = v.name},
            function(gradeInfo)

            	for __,g in ipairs(gradeInfo) do

            		JobInfo[v.name].grades[g.grade]	= g

            	end
            
            end)

            	end

            end)






end)

function AddJob(identifier, job, grade, rem)
    MySQL.Sync.execute(
        "INSERT INTO `user_jobs`(`identifier`, `job`, `grade`, `removeable`) VALUES (@identifier, @job, @grade, @removeable)",
        {["@identifier"] = identifier, ["@job"] = job, ["@grade"] = grade, ["@removeable"] = rem}
    )
end

function RemoveJob(identifier, job, grade)
    MySQL.Sync.execute(
        "DELETE FROM `user_jobs` WHERE identifier = @identifier AND job = @job AND grade = @grade",
        {["@identifier"] = identifier, ["@job"] = job, ["@grade"] = grade}
    )
end

RegisterCommand(
    "removejob",
    function(source, args, rawCommand)
        if source ~= 0 then
            local xPlayer = ESX.GetPlayerFromId(source)

            if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
                if args[1] ~= nil then
                    local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
                    if xTarget ~= nil then
                        if args[2] ~= nil and args[3] ~= nil then
                            RemoveJob(xTarget.identifier, args[2], args[3], true)
                        else
                            TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
                        end
                    else
                        TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
                    end
                else
                    TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
                end
            else
                TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
            end
        end
    end,
    false
)

RegisterCommand(
    "addjob",
    function(source, args, rawCommand)
        if source ~= 0 then
            local xPlayer = ESX.GetPlayerFromId(source)

            if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
                if args[1] ~= nil then
                    local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
                    if xTarget ~= nil then
                        if args[2] ~= nil and args[3] ~= nil then
                            AddJob(xTarget.identifier, args[2], args[3], true)
                        else
                            TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
                        end
                    else
                        TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
                    end
                else
                    TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
                end
            else
                TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
            end
        end
    end,
    false
)



ESX.RegisterServerCallback(
    "core_multijob:getJobs",
    function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)

        MySQL.Async.fetchAll(
            "SELECT * FROM user_jobs WHERE identifier = @identifier",
            {
                ["@identifier"] = xPlayer.identifier
            },
            function(jobs)
                local user_jobs = {}
                local online = {}

                local xPlayers = ESX.GetPlayers()

                for i = 1, #xPlayers, 1 do
                    local targetPlayer = ESX.GetPlayerFromId(xPlayers[i])
                    local targetJob = targetPlayer.getJob()
                    if online[targetJob.name] ~= nil then
                        online[targetJob.name] = online[targetJob.name] + 1
                    else
                        online[targetJob.name] = 1
                    end
                end

                for _, v in ipairs(jobs) do

                    local on = online[v.job]
                    if on == nil then
                        on = 0
                    end

                    table.insert(
                        user_jobs,
                        {
                            name = v.job,
                            grade = v.grade,
                            label = JobInfo[v.job].job_label,
                            grade_label = JobInfo[v.job].grades[v.grade].label,
                            salary = JobInfo[v.job].grades[v.grade].salary,
                            online = on,
                            removable = v.removeable
                        }
                    )
                end

                for _, v in ipairs(Config.DefaultJobs) do
                    local on = online[v.job]
                    if on == nil then
                        on = 0
                    end

                    table.insert(
                        user_jobs,
                        {
                            name = v.job,
                            grade = v.grade,
                            label = JobInfo[v.job].job_label,
                            grade_label = JobInfo[v.job].grades[v.grade].label,
                            salary = JobInfo[v.job].grades[v.grade].salary,
                            online = on,
                            removable = false
                        }
                    )
                end

                cb(user_jobs)
            end
        )
    end
)

RegisterServerEvent("core_multijob:changeJob")
AddEventHandler(
    "core_multijob:changeJob",
    function(job, grade)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        xPlayer.setJob(job, grade)
    end
)

RegisterServerEvent("core_multijob:checkForJob")
AddEventHandler(
    "core_multijob:checkForJob",
    function()
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        MySQL.Async.fetchAll(
            "SELECT * FROM user_jobs WHERE identifier = @identifier",
            {
                ["@identifier"] = xPlayer.identifier
            },
            function(jobs)
                local add = true
                local amount = 0

                local job = xPlayer.getJob()

                for _, v in ipairs(jobs) do
                    if job.name == v.job then
                        add = false
                    end
                    amount = amount + 1
                end

                for _, v in ipairs(Config.DefaultJobs) do
                    if job.name == v.job then
                        add = false
                    end
                end

                if add and amount < Config.MaxJobs and job.name ~= "offduty" then
                    AddJob(xPlayer.identifier, job.name, job.grade, true)
                end
            end
        )
    end
)

RegisterServerEvent("core_multijob:removeJob")
AddEventHandler(
    "core_multijob:removeJob",
    function(job, grade)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        RemoveJob(xPlayer.identifier, job, grade)
    end
)
