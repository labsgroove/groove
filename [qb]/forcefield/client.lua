local QBCore = exports['qb-core']:GetCoreObject()
local active = false
local hitCooldown = {}

-- CONFIG
local RADIUS = 5.0
local FORCE = 15.0        -- intensidade do impacto
local UP_FORCE = 13.0     -- vertical (batida, não balão)
local COOLDOWN_MS = 500

RegisterCommand("forcefield", function()
    active = not active
    QBCore.Functions.Notify(
        active and "Campo de força ATIVADO" or "Campo de força DESATIVADO",
        active and "success" or "error"
    )
end)

CreateThread(function()
    while true do
        Wait(50)

        if not active then
            goto skipTick
        end

        local ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped, false) then
            goto skipTick
        end

        local veh = GetVehiclePedIsIn(ped, false)
        local vCoords = GetEntityCoords(veh)
        local forward = GetEntityForwardVector(veh)

        for _, entity in ipairs(GetGamePool("CVehicle")) do
            if entity ~= veh and DoesEntityExist(entity) then
                local eCoords = GetEntityCoords(entity)

                local dx = eCoords.x - vCoords.x
                local dy = eCoords.y - vCoords.y
                local dist = math.sqrt(dx * dx + dy * dy)

                if dist < RADIUS and dist > 0.5 then
                    local now = GetGameTimer()

                    if not hitCooldown[entity] or now - hitCooldown[entity] > COOLDOWN_MS then
                        hitCooldown[entity] = now

                        -- normaliza direção
                        dx = dx / dist
                        dy = dy / dist

                        if not NetworkHasControlOfEntity(entity) then
                            NetworkRequestControlOfEntity(entity)
                        end

                        -- IMPACTO REAL (velocidade instantânea)
                        SetEntityVelocity(
                            entity,
                            dx * FORCE + forward.x * FORCE,
                            dy * FORCE + forward.y * FORCE,
                            UP_FORCE
                        )
                    end
                end
            end
        end

        ::skipTick::
    end
end)
