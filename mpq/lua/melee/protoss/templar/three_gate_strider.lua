local Basic = require "melee.protoss.basic"

---@type AIPersonality
return {
    name = "Templar: 3 Gate Strider",
    unit_composition = {
        -- signature unit
        [UnitId.ProtossLegionnaire] = 2,
        -- filler units
        [UnitId.ProtossAccantor] = 1,
        [UnitId.ProtossDracadin] = 1,
        [UnitId.ProtossArchon] = 1,
        [UnitId.ProtossPariah] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossPylon, 40)
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossGateway, 90)
        -- tier1
        melee_ai:dynamic_wait(secs(30))
        town:build(2, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(mins(1))
        town:build(3, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(15))
        town:build(4, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(45))
        town:build(5, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(15))
        -- tier2
        town:build(1, UnitId.ProtossGrandLibrary, 70)
        melee_ai:dynamic_wait(mins(1))
        town:build(2, UnitId.ProtossGrandLibrary, 70)
        town:build(1, UnitId.ProtossArdentAuthority, 70)
        -- tier3
        town:build(1, UnitId.ProtossProstrationStage, 65)
        melee_ai:dynamic_wait(secs(50))
        -- tier4
        town:build(1, UnitId.ProtossAncestralArchives, 45)
        melee_ai:dynamic_wait(secs(15))
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Legionnaire striders (+ Accantor / Dracadin / Archon / Pariah)
        town:build(1, UnitId.ProtossGateway, 85, true)
        town:build(1, UnitId.ProtossLattice, 80, true)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.ProtossGrandLibrary, 70, true)
        town:build(1, UnitId.ProtossArdentAuthority, 70, true)
        melee_ai:dynamic_wait(secs(45))
        town:build(1, UnitId.ProtossProstrationStage, 55, true)
        melee_ai:dynamic_wait(secs(45))
        town:build(1, UnitId.ProtossAncestralArchives, 45, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.4,
}
