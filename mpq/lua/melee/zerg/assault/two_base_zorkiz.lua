local Basic = require "melee.zerg.basic"

---@type AIPersonality
return {
    name = "Assault: 2 Base Hydrith-Zorkiz",
    unit_composition = {
        -- signature units
        [UnitId.ZergHydralisk] = 3,
        [UnitId.ZergUltrokor] = 2,
        [UnitId.ZergZoryusthaleth] = 2,
        -- filler units
        [UnitId.ZergIzirokor] = 1,
        [UnitId.ZergKalkalisk] = 1,
        [UnitId.ZergSovroleth] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(25))
        melee_ai:start_expanding()
        melee_ai:dynamic_wait(secs(5))
        town:build(1, UnitId.ZergHydrithDen, 90, true)
        -- tier1
        melee_ai:dynamic_wait(secs(55))
        town:build(2, UnitId.ZergHachirosk, 115)
        melee_ai:dynamic_wait(secs(15))
        -- tier2
        town:build(1, UnitId.ZergIrolIris, 70, true)
        melee_ai:dynamic_wait(secs(35))
        town:build(1, UnitId.ZergZorkizShroud, 70, true)
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.ZergTethvithSwamp, 70, true)
        town:build(1, UnitId.ZergCaphrolosk, 70)
        melee_ai:dynamic_wait(secs(45))
        -- tier3
        town:build(1, UnitId.ZergOthstolOviform, 65, true)
        melee_ai:dynamic_wait(secs(25))
        -- saturated production
        town:multirun(function(town)
            town:wait_build(1, UnitId.ZergIrolIris)
            town:build(5, UnitId.ZergLarvoskCesiant, 90)
            melee_ai:dynamic_wait(secs(45))
            town:build(6, UnitId.ZergHachirosk, 90)
            melee_ai:dynamic_wait(secs(45))
            town:build(6, UnitId.ZergCaphrolosk, 90)
            town:wait_build(1, UnitId.ZergOthstolOviform)
            melee_ai:dynamic_wait(secs(45))
            town:build(6, UnitId.ZergGathtelosk, 50)
        end)
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        town:multirun(function(town)
            town:wait_build(1, UnitId.ZergIrolIris)
            town:build(5, UnitId.ZergLarvoskCesiant, 90)
            melee_ai:dynamic_wait(secs(45))
            town:build(6, UnitId.ZergHachirosk, 90)
            melee_ai:dynamic_wait(secs(45))
            town:build(6, UnitId.ZergCaphrolosk, 90)
            town:wait_build(1, UnitId.ZergOthstolOviform)
            melee_ai:dynamic_wait(secs(45))
            town:build(6, UnitId.ZergGathtelosk, 50)
        end)
        -- production for the Hydralisk / Ultrokor / Zoryusthaleth assault army
        town:build(1, UnitId.ZergHydrithDen, 70, true)
        town:build(1, UnitId.ZergZorkizShroud, 70, true)
        town:build(1, UnitId.ZergKalkiirLake, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.ZergUlgorgCavern, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.ZergIrolIris, 70, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.ZergMutathSpire, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.ZergTosvrolHaunt, 70, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.6,
}
