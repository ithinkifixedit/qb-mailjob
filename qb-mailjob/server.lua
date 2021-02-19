QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('mailjob:Payment')
AddEventHandler('mailjob:Payment', function()
	local _source = source
	local Player = QBCore.Functions.GetPlayer(_source)
    rand1 = math.random(1,50)
    tip = math.random(100,150)
    if rand1 == 44 then
        Player.Functions.AddMoney("cash", 265, "sold-pizza")
        TriggerClientEvent("QBCore:Notify", _source, "You recieved $265", "success")
    else
        Player.Functions.AddMoney("cash", 175, "sold-pizza")
        TriggerClientEvent("QBCore:Notify", _source, "You recieved $175", "success")
    end
end)

RegisterServerEvent('mailjob:ReturnDeposit')
AddEventHandler('mailjob:ReturnDeposit', function(info)
	local _source = source
    local Player = QBCore.Functions.GetPlayer(_source)
    
    if info == 'cancel' then
        Player.Functions.AddMoney("cash", 50, "pizza-return-vehicle")
        TriggerClientEvent("QBCore:Notify", _source, "You Completed your mail run", "success")
    elseif info == 'end' then
        Player.Functions.AddMoney("cash", 150, "pizza-return-vehicle")
        TriggerClientEvent("QBCore:Notify", _source, "You Completed your mail run", "success")
    end
end)
