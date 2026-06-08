local shooterNpc = nil
local boomCam = nil -- câmera do atirador

RegisterCommand("boom", function()
    TriggerServerEvent("boom:getNearbyTargets")
end)

RegisterNetEvent("boom:spawnShooterInVehicle", function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if not DoesEntityExist(vehicle) or vehicle == 0 then
        print('Veículo não encontrado para spawnar o atirador.')
        return
    end
    local model = GetHashKey("spidermanclassic")
    local weapon = GetHashKey("weapon_raypistol")

    RequestModel(model)
    while not HasModelLoaded(model) do Wait(10) end

    -- encontra um assento livre (0 = passageiro da frente, 1 = trás esquerda, 2 = trás direita)
    local seatIndex = nil
    local seatsToCheck = {0, 1, 2}
    for _, s in ipairs(seatsToCheck) do
        local occ = GetPedInVehicleSeat(vehicle, s)
        if occ == 0 then
            seatIndex = s
            break
        end
    end

    if seatIndex == nil then
        print('Nenhum assento livre no veículo para o atirador.')
        return
    end

    local spawnPos = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -2.0, 0.0)
    shooterNpc = CreatePed(4, model, spawnPos.x, spawnPos.y, spawnPos.z, 0.0, true, true)
    GiveWeaponToPed(shooterNpc, weapon, 999, false, true)
    SetPedCombatAttributes(shooterNpc, 46, true)
    SetPedAsEnemy(shooterNpc, true)
    SetPedAccuracy(shooterNpc, 100)
    SetPedDropsWeaponsWhenDead(shooterNpc, false)
    SetPedFleeAttributes(shooterNpc, 0, 0)
    SetEntityInvincible(shooterNpc, true)
    SetPedCanRagdoll(shooterNpc, false)

    -- Permite tiro mais rápido e munição estável
    SetPedShootRate(shooterNpc, 750)
    SetPedInfiniteAmmoClip(shooterNpc, true)

    -- Coloca o ped no assento escolhido
    TaskWarpPedIntoVehicle(shooterNpc, vehicle, seatIndex)

    -- Evita que o ped saia do veículo ou realize tarefas indesejadas
    SetBlockingOfNonTemporaryEvents(shooterNpc, true)
    SetPedKeepTask(shooterNpc, true)

    -- Permite tiro mais rápido mesmo dentro do veículo
    SetPedShootRate(shooterNpc, 750)
    SetPedInfiniteAmmoClip(shooterNpc, true)

    startHuntLoop()
    print('Atirador spawnado como passageiro no veículo (assento '..seatIndex..').')
end)

-- Comando para ativar a câmera espectador no atirador
RegisterCommand('boomcam', function()
    if shooterNpc and DoesEntityExist(shooterNpc) then
        if boomCam and DoesCamExist(boomCam) then
            print('Câmera já está ativa no atirador!')
            return
        end
        local sx, sy, sz = table.unpack(GetEntityCoords(shooterNpc, true))
        boomCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamCoord(boomCam, sx, sy, sz + 2.0)
        PointCamAtEntity(boomCam, shooterNpc, 0.0, 0.0, 1.0, true)
        AttachCamToEntity(boomCam, shooterNpc, 0.0, -3.0, 2.0, true)
        SetCamActive(boomCam, true)
        RenderScriptCams(true, false, 0, true, true)
        print('Modo espectador ativado no atirador!')
    else
        print('Nenhum atirador ativo para focar!')
    end
end, false)

-- Comando para desativar a câmera espectador
RegisterCommand('boomcamoff', function()
    if boomCam and DoesCamExist(boomCam) then
        RenderScriptCams(false, false, 0, true, true)
        DestroyCam(boomCam, false)
        boomCam = nil
        print('Modo espectador desativado!')
    else
        print('Câmera do atirador não está ativa!')
    end
end, false)

-- Comando para spawnar o atirador como passageiro do veículo do jogador
RegisterCommand('boomcar', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if not DoesEntityExist(vehicle) or vehicle == 0 then
        print('Você precisa estar em um veículo para usar esse modo!')
        return
    end
    TriggerServerEvent('boom:getNearbyTargetsInVehicle')
end, false)

RegisterNetEvent("boom:spawnShooter", function(targetNetIds)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local model = GetHashKey("spidermanclassic")
    local weapon = GetHashKey("weapon_raypistol")

    RequestModel(model)
    while not HasModelLoaded(model) do Wait(10) end

    local spawnPos = GetOffsetFromEntityInWorldCoords(playerPed, 2.0, 0.0, 0.0)
    shooterNpc = CreatePed(4, model, spawnPos.x, spawnPos.y, spawnPos.z, 0.0, true, true)
    GiveWeaponToPed(shooterNpc, weapon, 999, false, true)
    SetPedCombatAttributes(shooterNpc, 46, true)
    SetPedAsEnemy(shooterNpc, true)
    SetPedAccuracy(shooterNpc, 100)
    SetPedDropsWeaponsWhenDead(shooterNpc, false)
    SetPedFleeAttributes(shooterNpc, 0, 0)
    SetEntityInvincible(shooterNpc, true)
    SetPedCanRagdoll(shooterNpc, false)

    startHuntLoop()
end)

function startHuntLoop()
    Citizen.CreateThread(function()
        while DoesEntityExist(shooterNpc) and not IsPedDeadOrDying(shooterNpc, true) do
            -- Pede novos alvos ao servidor
            TriggerServerEvent("boom:getNearbyTargetsLoop")
            Wait(1500) -- A cada 5s, pega novos alvos
        end
    end)
end

RegisterNetEvent("boom:updateTargets", function(targetNetIds)
    if not DoesEntityExist(shooterNpc) then return end

    local shooterCoords = GetEntityCoords(shooterNpc)
    local closestTarget = nil
    local closestDist = math.huge

    for _, netId in ipairs(targetNetIds) do
        local target = NetToPed(netId)
        if DoesEntityExist(target) and not IsPedDeadOrDying(target, true) then
            local targetCoords = GetEntityCoords(target)
            local dist = #(shooterCoords - targetCoords)
            if dist < closestDist then
                closestDist = dist
                closestTarget = target
            end
        end
    end

    if closestTarget then
        if IsPedInAnyVehicle(shooterNpc, false) then
            -- Se o atirador estiver dentro do veículo, alguns natives de tiro não funcionam corretamente.
            -- Usamos um bullet spawn para simular drive-by e deixamos o ped mirando visualmente.
            local sCoords = GetEntityCoords(shooterNpc)
            local tCoords = GetEntityCoords(closestTarget)
            local weaponHash = GetHashKey("weapon_raypistol")
            -- Origem ligeiramente acima para evitar colisões com o veículo
            ShootSingleBulletBetweenCoords(sCoords.x, sCoords.y, sCoords.z + 0.5, tCoords.x, tCoords.y, tCoords.z + 0.5, 10, true, weaponHash, shooterNpc, true, false, 100.0)
            -- Mantém o visual de mira
            TaskAimGunAtEntity(shooterNpc, closestTarget, 1000, true)
        else
            -- Só troca de alvo se não estiver atirando nesse (modo a pé)
            if not IsPedShooting(shooterNpc) or GetPedTargetFromAim(shooterNpc) ~= closestTarget then
                TaskShootAtEntity(shooterNpc, closestTarget, 1000, GetHashKey("FIRING_PATTERN_FULL_AUTO"))
            end
        end
    else
        ClearPedTasks(shooterNpc)
    end
end)
