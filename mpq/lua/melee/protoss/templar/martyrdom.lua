local Basic = require "melee.protoss.basic"

---@type AIPersonality
return {
    name = "Templar: Martyrdom",
    unit_composition = {
        -- signature units (Ancestral Archives x4)
        [UnitId.ProtossArchon] = 2,
        [UnitId.ProtossLegionnaire] = 2,
        -- filler units
        [UnitId.ProtossAtreus] = 1,
        [UnitId.ProtossMindTyrant] = 1,
        [UnitId.ProtossOptecton] = 1,
        [UnitId.ProtossPatriarch] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(30))
        melee_ai:start_expanding()
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.ProtossPylon, 40)
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(15))
        town:build(3, UnitId.ProtossPylon, 40)
        melee_ai:dynamic_wait(secs(15))
        town:build(2, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(15))
        town:build(3, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(40))
        melee_ai:start_attacking()
        melee_ai:dynamic_wait(mins(2) + secs(30))
        -- tier2
        town:build(4, UnitId.ProtossPylon, 40)
        town:build(2, UnitId.ProtossRogueGallery, 70)
        town:build(1, UnitId.ProtossGrandLibrary, 70)
        -- tier3
        town:build(1, UnitId.ProtossProstrationStage, 65)
        melee_ai:dynamic_wait(secs(50))
        town:build(1, UnitId.ProtossCrucible, 50)
        melee_ai:dynamic_wait(secs(50))
        -- tier4
        town:build(2, UnitId.ProtossAncestralArchives, 45)
        melee_ai:dynamic_wait(mins(1))
        town:wait_build(2, UnitId.ProtossAncestralArchives, false)
        melee_ai:dynamic_wait(secs(25))
        town:build(4, UnitId.ProtossAncestralArchives, 45)
        melee_ai:dynamic_wait(secs(45))
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Ancestral Archives martyrs (Archon / Optecton / Patriarch + Legionnaire)
        town:build(1, UnitId.ProtossGateway, 85, true)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.ProtossGrandLibrary, 70, true)
        melee_ai:dynamic_wait(secs(40))
        town:build(1, UnitId.ProtossProstrationStage, 55, true)
        melee_ai:dynamic_wait(secs(40))
        town:build(1, UnitId.ProtossCrucible, 50, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.ProtossAncestralArchives, 45, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.4,
}
