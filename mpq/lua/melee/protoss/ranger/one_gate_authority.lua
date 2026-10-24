local Basic = require "melee.protoss.basic"

---@type AIPersonality
return {
    name = "Ranger: 1 Gate Authority",
    unit_composition = {
        -- signature unit
        [UnitId.ProtossManifold] = 2,
        -- filler units (Prostration Stage)
        [UnitId.ProtossPariah] = 1,
        [UnitId.ProtossPotentate] = 1,
        [UnitId.ProtossSycophant] = 1,
        [UnitId.ProtossMindTyrant] = 1,
        [UnitId.ProtossIdol] = 1,
        [UnitId.ProtossAccantor] = 1,
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
        town:build(2, UnitId.ProtossPylon, 40)
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ProtossLattice, 90)
        melee_ai:dynamic_wait(secs(25))
        melee_ai:start_attacking()
        -- tier1
        melee_ai:dynamic_wait(secs(25))
        town:build(2, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(45))
        town:build(3, UnitId.ProtossGateway, 90)
        melee_ai:dynamic_wait(secs(25))
        -- tier2
        town:build(1, UnitId.ProtossArdentAuthority, 70)
        melee_ai:dynamic_wait(secs(15))
        town:build(4, UnitId.ProtossGateway, 70)
        melee_ai:dynamic_wait(secs(25))
        town:build(2, UnitId.ProtossLattice, 70)
        melee_ai:dynamic_wait(secs(15))
        town:build(3, UnitId.ProtossLattice, 70)
        melee_ai:dynamic_wait(secs(5))
        town:build(4, UnitId.ProtossLattice, 70)
        melee_ai:dynamic_wait(secs(15))
        -- tier3
        town:build(1, UnitId.ProtossProstrationStage, 65)
        melee_ai:dynamic_wait(secs(50))
        town:build(2, UnitId.ProtossArdentAuthority, 50)
        melee_ai:dynamic_wait(mins(1) + secs(15))
        -- tier4
        town:build(1, UnitId.ProtossSyntheticSynod, 45)
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Manifold + Prostration Stage army (+ Accantor / Analogue)
        town:build(1, UnitId.ProtossLattice, 85, true)
        town:build(1, UnitId.ProtossGateway, 82, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.ProtossArdentAuthority, 70, true)
        town:build(1, UnitId.ProtossGrandLibrary, 70, true)
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
