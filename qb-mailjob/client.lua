------------
-- CONFIG --
------------

Config              = {}

Config.Zones = {

	Vehicle = {
		Pos   = {x = 133.1, y = 96.48, z = 83.51}
	},

	Spawn = {
        Pos   = {x = 116.02, y = 94.28, z = 80.96, h = 65.18},
        Heading = 70.0
	},

}

---------
-- QBUS --
---------

QBCore = nil
PlayerData = {}
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerData = QBCore.Functions.GetPlayerData()
end)
-------------
-- Variables --
-------------

local InService = false
local Hired = true
local BlipSell = nil
local BlipEnd = nil
local BlipCancel = nil
local TargetPos = nil
local Hasmail = false
local NearVan = false
local LastGoal = 0
local DeliveriesCount = 0
local Delivered = false
local xxx = nil
local yyy = nil
local zzz = nil
local Blipy = {}
local JuzBlip = false
local mailDelivered = false
local ownsVan = false

---------------
-- Functions --
---------------

-- Create Job Blip
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not JuzBlip then
            Blipy['Mail Job'] = AddBlipForCoord(133.1, 96.48, 83.51)
            SetBlipSprite(Blipy['Mail Job'], 479)
            SetBlipDisplay(Blipy['Mail Job'], 4)
            SetBlipScale(Blipy['Mail Job'], 0.8)
            SetBlipAsShortRange(Blipy['Mail Job'], true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Mail Job')
            EndTextCommandSetBlipName(Blipy['Mail Job'])
						JuzBlip = true
        end
    end
end)

--Spawn Van
function PullOutVehicle()
    if ownsVan == true then
        QBCore.Functions.Notify("You already have a Mail Van! Go and collect it or end your job.", "error")
    elseif ownsVan == false then
        coords = Config.Zones.Spawn.Pos
        QBCore.Functions.SpawnVehicle('burrito3', function(veh)
            SetVehicleNumberPlateText(veh, "MAIL"..tostring(math.random(1000, 9999)))
            SetEntityHeading(veh, coords.h)
            exports['LegacyFuel']:SetFuel(veh, 100.0)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
            SetVehicleEngineOn(veh, true, true)
            plaquevehicule = GetVehicleNumberPlateText(veh)
        end, coords, true)
        InService = true
        DrawTarget()
        AddCancelBlip()
        ownsVan = true
        TriggerServerEvent("mailjob:TakeDeposit")
    end
end

-- Garaz
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Hired then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local dist = GetDistanceBetweenCoords(pos, Config.Zones.Vehicle.Pos.x, Config.Zones.Vehicle.Pos.y, Config.Zones.Vehicle.Pos.z, true)
            if dist <= 2.5 then
                local GaragePos = {
                    ["x"] = Config.Zones.Vehicle.Pos.x,
                    ["y"] = Config.Zones.Vehicle.Pos.y,
                    ["z"] = Config.Zones.Vehicle.Pos.z + 1
                }
                DrawText3Ds(GaragePos["x"],GaragePos["y"],GaragePos["z"], "Press [~g~G~s~] to start work as a Mail Man")
                if dist <= 3.0 then
                    if IsControlJustReleased(0, 47) then
                        PullOutVehicle()
                    end
                end
            end
        end
    end
end)

-------------------
-- Target Search --
-------------------

function DrawTarget()
    local RandomPoint = math.random(1, 21)
    if DeliveriesCount == 25 then
        QBCore.Functions.Notify("All Mail has been delivered","success")
        RemoveCancelBlip()
        SetBlipRoute(BlipSell, false)
        AddFinnishBlip()
        Delivered = true
				xxx = nil
				yyy = nil
				zzz = nil
    else
      local mail = 4 - DeliveriesCount
      if mail == 1 then
        QBCore.Functions.Notify("You have one Mail","success")
      else
        if mail == 4 then
          mail = 'Four'
        elseif mail == 3 then
          mail = 'Three'
        elseif mail == 2 then
          mail = 'Two'
        end
      end
        if LastGoal == RandomPoint then
            DrawTarget()
        else
            if RandomPoint == 1 then
								xxx =-60.88
								yyy =360.44
								zzz =113.06
                LastGoal = 1
            elseif RandomPoint == 2 then
								xxx =-371.81
								yyy =343.33
								zzz =109.94
                LastGoal = 2
            elseif RandomPoint == 3 then
								xxx =-409
								yyy =341.58
								zzz =108.91
                LastGoal = 3
            elseif RandomPoint == 4 then
								xxx =-444.25
								yyy =342.72
								zzz =105.62
                LastGoal = 4
            elseif RandomPoint == 5 then
								xxx =-842.77
								yyy =466.75
								zzz =87.6
                LastGoal = 5
            elseif RandomPoint == 6 then
								xxx =-968.79
								yyy =436.96
								zzz =80.77
                LastGoal = 6
            elseif RandomPoint == 7 then
								xxx =-1007.16
								yyy =513.55
								zzz =79.77
                LastGoal = 7
            elseif RandomPoint == 8 then
								xxx =-1804.89
								yyy =436.39
								zzz =128.83
                LastGoal = 8
            elseif RandomPoint == 9 then
								xxx =-1942.67
								yyy =449.52
								zzz =102.93
                LastGoal = 9
            elseif RandomPoint == 10 then
								xxx =-2009.15
								yyy =367.52
								zzz =94.81
                LastGoal = 10
            elseif RandomPoint == 11 then
								xxx =-1366.13
								yyy =56.66
								zzz =54.1
                LastGoal = 11
            elseif RandomPoint == 12 then
								xxx =-1117.78
								yyy =761.42
								zzz =164.29
                LastGoal = 12
            elseif RandomPoint == 13 then
								xxx =-1056.3
								yyy =761.31
								zzz =167.32
                LastGoal = 13
            elseif RandomPoint == 14 then
								xxx =-912.34
								yyy =777.15
								zzz =187.01
                LastGoal = 14
            elseif RandomPoint == 15 then
								xxx =-747.33
								yyy =808.28
								zzz =215.15
                LastGoal = 15
            elseif RandomPoint == 16 then
								xxx =-167.72
								yyy =915.92
								zzz =235.66
                LastGoal = 16
            elseif RandomPoint == 17 then
								xxx =-1942.68
								yyy =449.6
								zzz =102.93
                LastGoal = 17
            elseif RandomPoint == 18 then
								xxx =-1741.79
								yyy =365.25
								zzz =88.73
                LastGoal = 18
            elseif RandomPoint == 19 then
								xxx =-1673.21
								yyy =385.57
								zzz =89.35
                LastGoal = 19
            elseif RandomPoint == 20 then
								xxx =224.17
								yyy =513.58
								zzz =140.77
                LastGoal = 20
            elseif RandomPoint == 21 then
								xxx =57.61
								yyy =449.62
								zzz =147.03
                LastGoal = 21
            end
		    AddObjBlip(TargetPos)
        end
    end
end

--------------------
-- Creating Blips --
--------------------

-- Blip celu podrózy
function AddObjBlip(TargetPos)
    Blipy['obj'] = AddBlipForCoord(xxx, yyy, zzz)
    SetBlipRoute(Blipy['obj'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Customer')
	EndTextCommandSetBlipName(Blipy['obj'])
end

-- Blip anulowania pracy
function AddCancelBlip()
    Blipy['Return'] = AddBlipForCoord(66.03, 122.53, 79.14)
		SetBlipColour(Blipy['Return'], 59)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Return Packages')
	EndTextCommandSetBlipName(Blipy['Return'])
end

-- Blip zakonczenia pracy
function AddFinnishBlip()
    Blipy['end'] = AddBlipForCoord(66.03, 122.53, 79.14)
		SetBlipColour(Blipy['end'], 2)
    SetBlipRoute(Blipy['end'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('finish job')
	EndTextCommandSetBlipName(Blipy['end'])
end

------------------
-- Delete Blips --
------------------

function RemoveBlipObj()
    RemoveBlip(Blipy['obj'])
end

function RemoveCancelBlip()
    RemoveBlip(Blipy['cancel'])
end

function RemoveAllBlips()
    RemoveBlip(Blipy['obj'])
    RemoveBlip(Blipy['cancel'])
    RemoveBlip(Blipy['end'])
end

-------------------
-- DELIVERY AREA --
-------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local dist = GetDistanceBetweenCoords(pos, xxx, yyy, zzz, true)
        if dist <= 20.0 and Hired and (not Hasmail) then
            local DeliveryPoint = {
                ["x"] = xxx,
                ["y"] = yyy,
                ["z"] = zzz
            }
            DrawText3Ds(DeliveryPoint["x"],DeliveryPoint["y"],DeliveryPoint["z"], "Take ~y~Mail~s~ from ~b~Van~s~!")
            local Vehicle = GetClosestVehicle(pos, 6.0, 0, 70)
            if IsVehicleModel(Vehicle, GetHashKey('burrito3')) then
                local VehPos = GetEntityCoords(Vehicle)
								local distance = GetDistanceBetweenCoords(pos, VehPos, true)
                DrawText3Ds(VehPos.x,VehPos.y,VehPos.z, "Press [~g~G~s~] to pull out ~y~Mail")
								if dist >= 4 and distance <= 5 then
                	                NearVan = true
								end
            end
        elseif dist <= 25 and Hasmail and Hired then
            local DeliveryPoint = {
                ["x"] = xxx,
                ["y"] = yyy,
                ["z"] = zzz
            }
            DrawText3Ds(DeliveryPoint["x"],DeliveryPoint["y"],DeliveryPoint["z"], "Press [~g~G~s~] to deliver ~y~Mail")
            if dist <= 3 then
                if IsControlJustReleased(0, 47) then
                    Takemail()
                    Delivermail()
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if (not Hasmail) and NearVan then
			if IsControlJustReleased(0, 47) then
                Takemail()
                NearVan = false
			end
		end
	end
end)

-------------------
-- DELIVER mail --
-------------------

function loadAnimDict(dict)
	while ( not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end

function Takemail()
    local player = GetPlayerPed(-1)
    if not IsPedInAnyVehicle(player, false) then
        local ad = "anim@heists@box_carry@"
        local prop_name = 'v_ind_cf_chckbox2'
        if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
            loadAnimDict( ad )
            if Hasmail then
                TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
                DetachEntity(prop, 1, 1)
                DeleteObject(prop)
                Wait(1000)
                ClearPedSecondaryTask(PlayerPedId())
                Hasmail = false
            else
                local x,y,z = table.unpack(GetEntityCoords(player))
                prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
                AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.2, 0.08, 0.2, -45.0, 290.0, 0.0, true, true, false, true, 1, true)
                TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
                Hasmail = true
            end
        end
    end
end

function Delivermail()
    if not mailDelivered then
        mailDelivered = true
        DeliveriesCount = DeliveriesCount + 1
        RemoveBlipObj()
        SetBlipRoute(BlipSell, false)
        Hasmail = false    
        NextDelivery()
        Citizen.Wait(2500)
        mailDelivered = false
    end
end

function NextDelivery()
    TriggerServerEvent('mailjob:Payment')
    Citizen.Wait(300)
    DrawTarget()
end
-----------------
-- END OF WORK --
-----------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local DistanceFromEndZone = GetDistanceBetweenCoords(pos, 66.03, 122.53, 79.14, true)
        local DistanceFromCancelZone = GetDistanceBetweenCoords(pos, 66.03, 122.53, 79.14, true)
        if InService then
            if Delivered then
                if DistanceFromEndZone <= 2.5 then
                    local endPoint = { --x = 571.25, y = 116.78, z = 97.36
                    ["x"] = 66.03,
                    ["y"] = 122.53,
                    ["z"] = 79.14
                    }
                    DrawText3Ds(endPoint["x"],endPoint["y"],endPoint["z"], "Press [~g~G~s~] to ~r~complete~s~ work")
                    if DistanceFromEndZone <= 7 then
                        if IsControlJustReleased(0, 47) then
                            QBCore.Functions.Notify("The work is finished! Rest a while, the next Packages are already waiting!", "success")
                            EndOfWork()
                        end
                    end
                end
            else
                if DistanceFromCancelZone <= 2.5 then
                    local cancel = { --x = 558.52, y = 121.27, z = 97.37
                        ["x"] = 66.03,
                        ["y"] = 122.53,
                        ["z"] = 79.14
                    }
                    DrawText3Ds(cancel["x"],cancel["y"],cancel["z"], "Press [~g~G~s~] to ~r~End~s~ Shift")
                    if DistanceFromCancelZone <= 7 then
                        if IsControlJustReleased(0, 47) then
                            QBCore.Functions.Notify("Packages Returned!", "error")
							EndOfWork()
                        end
                    end
                end
            end
        end
    end
end)

function EndOfWork()
    RemoveAllBlips()
    local ped = GetPlayerPed(-1)
    if IsPedInAnyVehicle(ped, false) then
        local Van = GetVehiclePedIsIn(ped, false)
        if IsVehicleModel(Van, GetHashKey('burrito3')) then
            QBCore.Functions.DeleteVehicle(Van)
            if Delivered == true then
                TriggerServerEvent("mailjob:ReturnDeposit", 'end')
            end
            InService = false
            BlipSell = nil
            BlipEnd = nil
            BlipCancel = nil
            TargetPos = nil
            Hasmail = false
            LastGoal = nil
            DeliveriesCount = 0
            xxx = nil
            yyy = nil
            zzz = nil
            ownsVan = false
            Delivered = false
        else
            QBCore.Functions.Notify("You must return to Mail Van!", "error")
            QBCore.Functions.Notify("If you lost the Mail Van cancel the job on foot", "error")
        end
    else
        InService = false
        BlipSell = nil
        BlipEnd = nil
        BlipCancel = nil
        TargetPos = nil
        Hasmail = false
        LastGoal = nil
        DeliveriesCount = 0
        xxx = nil
        yyy = nil
        zzz = nil
        ownsVan = false
        Delivered = false
    end
end

----------------------
-- 3D text function --
----------------------
DrawText3Ds = function(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 370
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 120)
end