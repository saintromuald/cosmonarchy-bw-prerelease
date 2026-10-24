local Basic = require "melee.zerg.basic"

---@type AIPersonality
return {
    name = "Assault: 2 Base Alkag",
    unit_composition = {
        -- signature units (Alkag Iteth)
        [UnitId.ZergKagralisk] = 2,
        [UnitId.ZergEvigrilisk] = 2,
        [UnitId.ZergAlmaksalisk] = 2,
        -- filler units
        [UnitId.ZergSkithrokor] = 1,
        [UnitId.ZergBactalisk] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(25))
        town:multirun(function(town)
            town:wait_build(1, UnitId.ZergHydrithDen)
            melee_ai:dynamic_wait(secs(40))
            town:build(1, UnitId.ZergSkibactScab, 90, true)
            melee_ai:dynamic_wait(mins(1) + secs(40))
            town:build(1, UnitId.ZergTethvithSwamp, 90, true)
            town:wait_build(1, UnitId.ZergIrolIris)
            melee_ai:dynamic_wait(secs(15))
            town:build(1, UnitId.ZergAlkagIteth, 90, true)
            town:build(1, UnitId.ZergOthstolOviform, 90, true)
        end)
        town:build(1, UnitId.ZergHydrithDen, 90, true)
        melee_ai:dynamic_wait(secs(30))
        melee_ai:start_expanding()
        -- tier2
        melee_ai:dynamic_wait(secs(55))
        town:build(1, UnitId.ZergIrolIris, 70, true)
        melee_ai:dynamic_wait(mins(1) + secs(15))
        town:build(2, UnitId.ZergHachirosk, 115)
        melee_ai:dynamic_wait(mins(1) + secs(5))
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
        -- production for the Alkag Iteth army (Kagralisk / Evigrilisk / Almaksalisk)
        town:build(1, UnitId.ZergHydrithDen, 70, true)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.ZergSkibactScab, 70, true)
        town:build(1, UnitId.ZergTethvithSwamp, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.ZergIrolIris, 70, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.ZergAlkagIteth, 70, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.6,
}
