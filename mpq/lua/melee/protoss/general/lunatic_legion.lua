local Basic = require "melee.protoss.basic"

---@type AIPersonality
return {
    name = "General: Lunatic Legion",
    unit_composition = {
        -- signature units
        [UnitId.ProtossLegionnaire] = 2,
        [UnitId.ProtossSimulacrum] = 2,
        -- filler units
        [UnitId.ProtossEcclesiast] = 1,
        [UnitId.ProtossAurora] = 1,
        [UnitId.ProtossMagister] = 1,
        [UnitId.ProtossDidact] = 1,
        [UnitId.ProtossAnalogue] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossPylon, 40)
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(20))
        town:build(2, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(25))
        town:build(2, UnitId.ProtossPylon, 40)
        melee_ai:start_expanding()
        melee_ai:dynamic_wait(secs(40))
        -- tier2
        town:build(1, UnitId.ProtossStargate, 70)
        melee_ai:dynamic_wait(secs(20))
        town:build(2, UnitId.ProtossStargate, 70)
        melee_ai:dynamic_wait(secs(45))
        town:build(3, UnitId.ProtossGateway, 70)
        melee_ai:dynamic_wait(secs(15))
        town:build(3, UnitId.ProtossStargate, 70)
        melee_ai:dynamic_wait(secs(20))
        town:build(4, UnitId.ProtossGateway, 70)
        melee_ai:dynamic_wait(secs(15))
        town:build(4, UnitId.ProtossStargate, 70)
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossGrandLibrary, 70)
        melee_ai:dynamic_wait(secs(15))
        town:build(2, UnitId.ProtossGrandLibrary, 70)
        melee_ai:dynamic_wait(secs(15))
        -- tier3
        town:build(1, UnitId.ProtossArgosy, 50)
        -- tier4
        town:build(1, UnitId.ProtossSyntheticSynod, 45)
        melee_ai:dynamic_wait(secs(15))
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        melee_ai:dynamic_wait(secs(25))
        -- production for the Legionnaire + Simulacrum army + Stargate / Argosy fleet & Synthetic Synod
        town:build(1, UnitId.ProtossGateway, 85, true)
        town:build(1, UnitId.ProtossLattice, 82, true)
        town:build(1, UnitId.ProtossEmbassy, 80, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.ProtossStargate, 70, true)
        town:build(1, UnitId.ProtossArdentAuthority, 70, true)
        melee_ai:dynamic_wait(secs(45))
        town:build(1, UnitId.ProtossArgosy, 55, true)
        town:build(1, UnitId.ProtossUnitaryUnion, 55, true)
        melee_ai:dynamic_wait(secs(50))
        town:build(1, UnitId.ProtossSyntheticSynod, 45, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.5,
}
