local QBCore = exports['qb-core']:GetCoreObject()

local Following = false
local TargetVehicle = nil

local DRIVE_STYLE = 316
local FOLLOW_DISTANCE = 25.0
local MAX_DISTANCE = 500.0

local function GetClosestNPCVehicle(radius)
    local ped = PlayerPedId()
    local playerPos = GetEntityCoords(ped)

    local closestVeh = nil
    local closestDist = radius

    for _, veh in ipairs(GetGamePool('CVehicle')) do
        if veh ~= GetVehiclePedIsIn(ped, false) then

            local driver = GetPedInVehicleSeat(veh, -1)

            if driver ~= 0
            and DoesEntityExist(driver)
            and not IsPedAPlayer(driver)
            then
                local dist = #(GetEntityCoords(veh) - playerPos)

                if dist < closestDist then
                    closestDist = dist
                    closestVeh = veh
                end
            end
        end
    end

    return closestVeh
end

local function GetPointBehindVehicle(vehicle, distance)
    local coords = GetEntityCoords(vehicle)
    local heading = math.rad(GetEntityHeading(vehicle))

    return vector3(
        coords.x - math.sin(heading) * distance,
        coords.y + math.cos(heading) * distance,
        coords.z
    )
end

local function StopFollowing()
    Following = false

    local ped = PlayerPedId()

    ClearPedTasks(ped)

    TargetVehicle = nil

    QBCore.Functions.Notify("Seguimento encerrado", "primary")
end

local function StartFollowing()
    CreateThread(function()

        local ped = PlayerPedId()
        local myVehicle = GetVehiclePedIsIn(ped, false)

        while Following do
            Wait(1000)

            if not DoesEntityExist(TargetVehicle) then
                StopFollowing()
                break
            end

            if not DoesEntityExist(myVehicle) then
                StopFollowing()
                break
            end

            if GetPedInVehicleSeat(myVehicle, -1) ~= ped then
                StopFollowing()
                break
            end

            local myPos = GetEntityCoords(myVehicle)
            local targetPos = GetEntityCoords(TargetVehicle)

            local distance = #(targetPos - myPos)

            if distance > MAX_DISTANCE then
                QBCore.Functions.Notify("Alvo perdido", "error")
                StopFollowing()
                break
            end

            local followPoint = GetPointBehindVehicle(
                TargetVehicle,
                FOLLOW_DISTANCE
            )

            local targetSpeed = math.max(
                GetEntitySpeed(TargetVehicle) * 3.6 + 10.0,
                40.0
            )

            TaskVehicleDriveToCoordLongrange(
                ped,
                myVehicle,
                followPoint.x,
                followPoint.y,
                followPoint.z,
                targetSpeed / 3.6,
                DRIVE_STYLE,
                5.0
            )
        end
    end)
end

RegisterCommand("seguirnpc", function()

    local ped = PlayerPedId()

    if Following then
        StopFollowing()
        return
    end

    if not IsPedInAnyVehicle(ped, false) then
        QBCore.Functions.Notify(
            "Entre em um veículo primeiro",
            "error"
        )
        return
    end

    local myVehicle = GetVehiclePedIsIn(ped, false)

    if GetPedInVehicleSeat(myVehicle, -1) ~= ped then
        QBCore.Functions.Notify(
            "Você precisa estar dirigindo",
            "error"
        )
        return
    end

    local target = GetClosestNPCVehicle(250.0)

    if not target then
        QBCore.Functions.Notify(
            "Nenhum veículo de NPC encontrado",
            "error"
        )
        return
    end

    TargetVehicle = target
    Following = true

    local model = GetDisplayNameFromVehicleModel(
        GetEntityModel(target)
    )

    QBCore.Functions.Notify(
        ("Seguindo alvo: %s"):format(model),
        "success"
    )

    StartFollowing()

end, false)