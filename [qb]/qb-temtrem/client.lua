local Train = nil
local Speed = 0.0

local TrainModels = {
    `freight`,
    `freightcar`,
    `freightgrain`,
    `freightcont1`,
    `freightcont2`,
    `freighttrailer`
}

local function LoadTrainModels()
    for _, model in ipairs(TrainModels) do
        RequestModel(model)

        while not HasModelLoaded(model) do
            Wait(0)
        end
    end
end

RegisterCommand('train', function()

    if DoesEntityExist(Train) then
        DeleteMissionTrain(Train)
        Train = nil
        return
    end

    local ped = PlayerPedId()

    
    local spawn = vector3(-537.0, 5326.0, 74.0)
    LoadTrainModels()

    Train = CreateMissionTrain(
        15,
        spawn.x,
        spawn.y,
        spawn.z,
        true,
        true,
        true
    )

    if not DoesEntityExist(Train) then
        print("^1Falha ao criar trem.^7")
        return
    end

    Wait(2000)

    local loco = GetTrainCarriage(Train, 0)

    if loco and loco ~= 0 then
        SetPedIntoVehicle(ped, loco, -1)
    end

    Speed = 0.0

    CreateThread(function()

        while DoesEntityExist(Train) do

            DisableControlAction(0, 71, true)
            DisableControlAction(0, 72, true)

            if IsControlPressed(0, 32) then -- W
                Speed = math.min(Speed + 0.05, 40.0)
            end

            if IsControlPressed(0, 33) then -- S
                Speed = math.max(Speed - 0.10, 0.0)
            end

            if IsControlPressed(0, 22) then -- Espaço
                Speed = 0.0
            end

            SetTrainSpeed(Train, Speed)
            SetTrainCruiseSpeed(Train, Speed)

            Wait(0)
        end

    end)

end)