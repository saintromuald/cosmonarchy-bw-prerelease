local Basic = require "melee.protoss.basic"

---@type AIPersonality
return {
    name = "Skylord: Exalted",
    unit_composition = {
        -- signature units (Monument of Sin)
        [UnitId.ProtossVassal] = 2,
        [UnitId.ProtossStarSovereign] = 2,
        [UnitId.ProtossAnthelion] = 2,
        -- filler units
        [UnitId.ProtossPanoptus] = 1,
        [UnitId.ProtossExemplar] = 1,
        [UnitId.ProtossDidact] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossPylon, 40)
        town:build(1, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.ProtossStargate, 90)
        town:build(1, UnitId.ProtossWarden, 79)
        melee_ai:dynamic_wait(secs(15))
        town:build(2, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(25))
        town:build(2, UnitId.ProtossWarden, 79)
        melee_ai:dynamic_wait(secs(30))
        melee_ai:start_attacking()
        melee_ai:dynamic_wait(secs(25))
        melee_ai:start_expanding()
        -- tier1
        melee_ai:dynamic_wait(mins(1))
        town:build(3, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(mins(1))
        town:build(3, UnitId.ProtossStargate, 90)
        melee_ai:dynamic_wait(secs(40))
        -- tier2
        town:build(1, UnitId.ProtossLattice, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(2, UnitId.ProtossGateway, 70)
        -- tier3
        town:build(1, UnitId.ProtossArgosy, 50)
        town:wait_build(1, UnitId.ProtossArgosy, false)
        melee_ai:dynamic_wait(secs(50))
        town:build(1, UnitId.ProtossCrucible, 50)
        melee_ai:dynamic_wait(secs(40))
        town:build(2, UnitId.ProtossArgosy, 50)
        melee_ai:dynamic_wait(mins(1) + secs(15))
        -- tier4
        town:build(1, UnitId.ProtossMonumentOfSin, 45)
        melee_ai:dynamic_wait(mins(1) + secs(40))
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the exalted capital fleet (Star Sovereign / Anthelion / Didact) + Crucible
        town:build(1, UnitId.ProtossGateway, 85, true)
        town:build(1, UnitId.ProtossLattice, 80, true)
        town:build(1, UnitId.ProtossEmbassy, 78, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.ProtossStargate, 70, true)
        melee_ai:dynamic_wait(secs(45))
        town:build(1, UnitId.ProtossArgosy, 55, true)
        melee_ai:dynamic_wait(secs(40))
        town:build(1, UnitId.ProtossCrucible, 50, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.ProtossMonumentOfSin, 45, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.6,
}
