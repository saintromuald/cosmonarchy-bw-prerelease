local Basic = require "melee.protoss.basic"

---@type AIPersonality
return {
    name = "Skylord: Sorrow Fleet",
    unit_composition = {
        -- signature units (Monument of Sin)
        [UnitId.ProtossVassal] = 2,
        [UnitId.ProtossStarSovereign] = 2,
        [UnitId.ProtossAnthelion] = 1.5,
        -- filler units
        [UnitId.ProtossPanoptus] = 1,
        [UnitId.ProtossGladius] = 1,
        [UnitId.ProtossEmpyrean] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(30))
        melee_ai:start_expanding()
        melee_ai:dynamic_wait(secs(15))
        town:build(2, UnitId.ProtossPylon, 40)
        melee_ai:dynamic_wait(secs(15))
        melee_ai:start_expanding()
        melee_ai:dynamic_wait(mins(1) + secs(40))
        town:build(1, UnitId.ProtossLattice, 90)
        melee_ai:dynamic_wait(mins(1))
        town:build(1, UnitId.ProtossStargate, 90)
        melee_ai:dynamic_wait(secs(40))
        melee_ai:start_attacking()
        melee_ai:dynamic_wait(secs(40))
        -- tier2
        town:build(1, UnitId.ProtossLattice, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(2, UnitId.ProtossGateway, 70)
        -- tier3
        town:build(1, UnitId.ProtossArgosy, 50)
        melee_ai:dynamic_wait(mins(1))
        town:build(2, UnitId.ProtossArgosy, 50)
        melee_ai:dynamic_wait(secs(40))
        town:build(3, UnitId.ProtossArgosy, 50)
        melee_ai:dynamic_wait(mins(1) + secs(15))
        -- tier4
        town:build(1, UnitId.ProtossMonumentOfSin, 45)
        melee_ai:dynamic_wait(mins(2) + secs(45))
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Monument of Sin fleet (Star Sovereign / Anthelion) + Stargate / Argosy
        town:build(1, UnitId.ProtossGateway, 85, true)
        town:build(1, UnitId.ProtossLattice, 80, true)
        town:build(1, UnitId.ProtossEmbassy, 78, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.ProtossStargate, 70, true)
        melee_ai:dynamic_wait(secs(45))
        town:build(1, UnitId.ProtossArgosy, 55, true)
        melee_ai:dynamic_wait(secs(50))
        town:build(1, UnitId.ProtossMonumentOfSin, 45, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.6,
}
