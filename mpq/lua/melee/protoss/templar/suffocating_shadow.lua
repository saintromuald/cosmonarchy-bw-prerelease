local Basic = require "melee.protoss.basic"

---@type AIPersonality
return {
    name = "Templar: Suffocating Shadow",
    unit_composition = {
        -- signature units (Rogue Gallery)
        [UnitId.ProtossVagrant] = 2,
        [UnitId.ProtossCabalist] = 2,
        [UnitId.ProtossCharlatan] = 2,
        [UnitId.ProtossBarghest] = 2,
        [UnitId.ProtossZealot] = 2,
        -- filler units
        [UnitId.ProtossAtreus] = 1,
        [UnitId.ProtossEcclesiast] = 1,
        [UnitId.ProtossPariah] = 1,
        [UnitId.ProtossArchon] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossPylon, 40)
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossGateway, 90)
        -- tier1
        melee_ai:dynamic_wait(secs(20))
        town:build(2, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(45))
        -- tier2
        town:build(1, UnitId.ProtossRogueGallery, 70)
        town:build(2, UnitId.ProtossRogueGallery, 70)
        melee_ai:dynamic_wait(secs(30) + secs(40))
        town:build(1, UnitId.ProtossGrandLibrary, 70)
        melee_ai:dynamic_wait(mins(1) + secs(5))
        -- tier3
        town:build(1, UnitId.ProtossProstrationStage, 65)
        melee_ai:dynamic_wait(secs(50))
        -- tier4
        town:build(1, UnitId.ProtossAncestralArchives, 45)
        melee_ai:dynamic_wait(secs(15))
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Rogue Gallery shadow army (Vagrant / Cabalist / Charlatan / Barghest + Zealot)
        town:build(1, UnitId.ProtossGateway, 85, true)
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossRogueGallery, 75, true)
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
