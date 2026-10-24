local Basic = require "melee.protoss.basic"

---@type AIPersonality
return {
    name = "Templar: Initiates",
    unit_composition = {
        -- signature unit
        [UnitId.ProtossZealot] = 2,
        -- filler units
        [UnitId.ProtossEcclesiast] = 1,
        [UnitId.ProtossCantavis] = 1,
        [UnitId.ProtossAccantor] = 1,
        [UnitId.ProtossArchon] = 1,
        [UnitId.ProtossPariah] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossPylon, 40)
        town:build(1, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(25))
        town:build(2, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(15))
        town:build(2, UnitId.ProtossPylon, 40)
        town:wait_build(2, UnitId.ProtossGateway)
        melee_ai:dynamic_wait(secs(10))
        town:build(3, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(25))
        melee_ai:start_attacking()
        melee_ai:dynamic_wait(secs(40))
        melee_ai:start_expanding()
        -- tier1
        melee_ai:dynamic_wait(secs(20))
        town:build(4, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(25))
        -- tier2
        town:build(1, UnitId.ProtossLattice, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(2, UnitId.ProtossGateway, 70)
        town:build(1, UnitId.ProtossGrandLibrary, 70)
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
        -- production for the Zealot core (+ Cantavis / Accantor / Archon / Pariah)
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
