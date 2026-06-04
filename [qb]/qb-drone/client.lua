local Drone = nil
local cam = nil
local blip = nil

local velX = 0.0
local velY = 0.0
local velZ = 0.0
local yawVel = 0.0

Config = {}

Config.DroneModel = `ch_prop_arcade_drone_01a`

Config.Acceleration = 8.0
Config.VerticalAcceleration = 5.0

Config.Drag = 0.985
Config.WindStrength = 0.005

Config.CameraDistance = -0.05
Config.CameraHeight = 0.1

RegisterCommand('drone', function()
    local ped = PlayerPedId()
    local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 1.0)

    RequestModel(Config.DroneModel)
    while not HasModelLoaded(Config.DroneModel) do
        Wait(0)
    end

    if Drone and DoesEntityExist(Drone) then
        DeleteEntity(Drone)
    end

    Drone = CreateObject(Config.DroneModel, pos.x, pos.y, pos.z, true, true, false)

    SetEntityCollision(Drone, true, true)
    SetEntityDynamic(Drone, true)
    ActivatePhysics(Drone)

    velX = 0.0
    velY = 0.0
    velZ = 0.0
    yawVel = 0.0

    if cam then
        RenderScriptCams(false, false, 0, true, true)
        DestroyCam(cam)
    end

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    RenderScriptCams(true, false, 0, true, true)

    if DoesBlipExist(blip) then
        RemoveBlip(blip)
    end

    blip = AddBlipForEntity(Drone)
    SetBlipSprite(blip, 162)
    SetBlipColour(blip, 2)
    SetBlipScale(blip, 0.8)
    SetBlipAsFriendly(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Drone")
    EndTextCommandSetBlipName(blip)
end)

CreateThread(function()
    while true do
        Wait(0)

        if Drone and DoesEntityExist(Drone) then
            local dt = GetFrameTime()

            -- Left stick: yaw (X) and altitude (Y)
            local leftX = GetControlNormal(0, 218)
            local leftY = GetControlNormal(0, 219)

            -- Right stick: forward/backward (Y) and strafe (X)
            local rightX = GetControlNormal(0, 220)
            local rightY = GetControlNormal(0, 221)

            -- altitude
            velZ = velZ - (leftY * Config.VerticalAcceleration * dt)

            -- yaw
            yawVel = yawVel - (leftX * 60.0 * dt)
            yawVel = yawVel * 0.34

            local heading = GetEntityHeading(Drone) + yawVel
            SetEntityHeading(Drone, heading)

            local forwardX = math.sin(math.rad(-heading))
            local forwardY = math.cos(math.rad(-heading))
            local rightVX = math.sin(math.rad(-(heading + 90)))
            local rightVY = math.cos(math.rad(-(heading + 90)))

            velX = velX - ((forwardX * -rightY + rightVX * rightX) * Config.Acceleration * dt)
            velY = velY - ((forwardY * -rightY + rightVY * rightX) * Config.Acceleration * dt)

            -- wind
            local windX = math.sin(GetGameTimer() * 0.0001) * Config.WindStrength
            local windY = math.cos(GetGameTimer() * 0.00012) * Config.WindStrength
            velX = velX + windX
            velY = velY + windY

            -- drag
            velX = velX * Config.Drag
            velY = velY * Config.Drag
            velZ = velZ * Config.Drag

            SetEntityVelocity(Drone, velX, velY, velZ)

            local pitch = math.max(-20.0, math.min(20.0, rightY * -20.0))
            local roll = math.max(-25.0, math.min(25.0, rightX * 25.0))

            SetEntityRotation(Drone, pitch, roll, heading, 2, true)

            -- Camera: above and behind the drone, relative to heading
            local coords = GetEntityCoords(Drone)
            SetCamCoord(cam,
                coords.x + math.sin(math.rad(-heading)) * -Config.CameraDistance,
                coords.y + math.cos(math.rad(-heading)) * -Config.CameraDistance,
                coords.z + Config.CameraHeight
            )
            PointCamAtEntity(cam, Drone, 0.0, 0.0, 0.0, true)

            DisableControlAction(0, 30, true)
            DisableControlAction(0, 31, true)
            DisableControlAction(0, 32, true)
            DisableControlAction(0, 33, true)
        end
    end
end)
