Framework = {}

function Framework.ESX()
    return GetResourceState("crm-core") ~= "missing"
end

function Framework.QBCore()
    return GetResourceState("qb-core") ~= "missing"
end
