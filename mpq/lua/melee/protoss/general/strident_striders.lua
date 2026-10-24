local Basic = require "melee.protoss.basic"

---@type AIPersonality
return {
    name = "General: Strident Striders",
    unit_composition = {
        -- signature unit
        [UnitId.ProtossDracadin] = 2,
        -- filler units
        [UnitId.ProtossAtreus] = 1,
        [UnitId.ProtossPariah] = 1,
        [UnitId.ProtossAnalogue] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossPylon, 40)
        town:build(1, UnitId.ProtossGateway, 90)
        -- tier1
        melee_ai:dynamic_wait(secs(20))
        town:build(2, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(15))
        town:build(2, UnitId.ProtossPylon, 40)
        melee_ai:dynamic_wait(secs(50))
        town:build(3, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(mins(1) + secs(45))
        -- tier2
        town:build(1, UnitId.ProtossLattice, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(2, UnitId.ProtossGateway, 70)
        town:build(1, UnitId.ProtossGrandLibrary, 70)
        -- tier3
        town:build(1, UnitId.ProtossProstrationStage, 65)
        melee_ai:dynamic_wait(secs(50))
        -- tier4
        town:build(1, UnitId.ProtossSyntheticSynod, 45)
        melee_ai:dynamic_wait(secs(15))
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        melee_ai:dynamic_wait(secs(25))
        -- production for the Dracadin striders (+ Atreus / Pariah / Analogue) + Synthetic Synod tech
        town:build(1, UnitId.ProtossGateway, 85, true)
        town:build(1, UnitId.ProtossLattice, 82, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.ProtossGrandLibrary, 70, true)
        town:build(1, UnitId.ProtossArdentAuthority, 70, true)
        melee_ai:dynamic_wait(secs(45))
        town:build(1, UnitId.ProtossProstrationStage, 55, true)
        town:build(1, UnitId.ProtossUnitaryUnion, 55, true)
        melee_ai:dynamic_wait(secs(50))
        town:build(1, UnitId.ProtossSyntheticSynod, 45, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.5,
}
