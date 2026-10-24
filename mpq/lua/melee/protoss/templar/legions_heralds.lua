local Basic = require "melee.protoss.basic"

---@type AIPersonality
return {
    name = "Templar: Legion's Heralds",
    unit_composition = {
        -- signature unit
        [UnitId.ProtossLegionnaire] = 2,
        -- filler units
        [UnitId.ProtossEcclesiast] = 1,
        [UnitId.ProtossAtreus] = 1,
        [UnitId.ProtossHerald] = 1,
        [UnitId.ProtossPatriarch] = 1,
        [UnitId.ProtossPariah] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossPylon, 40)
        town:build(1, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(30))
        melee_ai:start_expanding()
        -- tier1
        melee_ai:dynamic_wait(secs(20))
        town:build(2, UnitId.ProtossPylon, 40)
        melee_ai:dynamic_wait(secs(15))
        town:build(2, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(20))
        -- tier2
        town:build(1, UnitId.ProtossGrandLibrary, 70)
        melee_ai:dynamic_wait(secs(20))
        town:build(3, UnitId.ProtossPylon, 40)
        melee_ai:dynamic_wait(secs(15))
        town:build(3, UnitId.ProtossGateway, 70)
        melee_ai:dynamic_wait(secs(40) + mins(1))
        town:build(5, UnitId.ProtossGateway, 70)
        melee_ai:dynamic_wait(secs(40))
        town:build(2, UnitId.ProtossGrandLibrary, 70)
        melee_ai:dynamic_wait(mins(1))
        town:build(9, UnitId.ProtossGateway, 70)
        melee_ai:dynamic_wait(mins(1) + secs(55))
        -- tier3
        town:build(1, UnitId.ProtossProstrationStage, 65)
        melee_ai:dynamic_wait(secs(50))
        -- tier4
        town:build(1, UnitId.ProtossAncestralArchives, 45)
        melee_ai:dynamic_wait(secs(15))
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Legionnaire + Herald / Patriarch core (Gateway -> Grand Library -> Ancestral Archives)
        town:build(1, UnitId.ProtossGateway, 85, true)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.ProtossGrandLibrary, 70, true)
        melee_ai:dynamic_wait(secs(40))
        town:build(1, UnitId.ProtossProstrationStage, 55, true)
        melee_ai:dynamic_wait(secs(45))
        town:build(1, UnitId.ProtossAncestralArchives, 45, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.4,
}
