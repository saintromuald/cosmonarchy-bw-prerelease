local Basic = require "melee.protoss.basic"

---@type AIPersonality
return {
    name = "Skylord: 2 Gate Panoptus",
    unit_composition = {
        -- signature units
        [UnitId.ProtossPanoptus] = 3,
        [UnitId.ProtossVassal] = 2,
        -- filler units
        [UnitId.ProtossHierophant] = 1,
        [UnitId.ProtossPariah] = 1,
        [UnitId.ProtossStarSovereign] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossPylon, 40)
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(25))
        town:build(2, UnitId.ProtossPylon, 40)
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossStargate, 90)
        melee_ai:dynamic_wait(secs(50))
        town:build(2, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(5))
        melee_ai:start_attacking()
        -- tier1
        melee_ai:dynamic_wait(mins(1) + secs(35))
        town:build(3, UnitId.ProtossGateway, 90)
        -- tier2
        town:build(1, UnitId.ProtossLattice, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(2, UnitId.ProtossGateway, 70)
        -- tier3
        town:build(1, UnitId.ProtossProstrationStage, 65)
        melee_ai:dynamic_wait(secs(50))
        -- tier4
        town:build(1, UnitId.ProtossMonumentOfSin, 45)
        melee_ai:dynamic_wait(secs(15))
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Panoptus + Vassal army (-> Argosy -> Monument of Sin) + Hierophant / Pariah tech
        town:build(1, UnitId.ProtossGateway, 85, true)
        town:build(1, UnitId.ProtossLattice, 80, true)
        town:build(1, UnitId.ProtossEmbassy, 78, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.ProtossStargate, 70, true)
        town:build(1, UnitId.ProtossGrandLibrary, 68, true)
        melee_ai:dynamic_wait(secs(45))
        town:build(1, UnitId.ProtossArgosy, 55, true)
        town:build(1, UnitId.ProtossProstrationStage, 55, true)
        melee_ai:dynamic_wait(secs(50))
        town:build(1, UnitId.ProtossMonumentOfSin, 45, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.6,
}
