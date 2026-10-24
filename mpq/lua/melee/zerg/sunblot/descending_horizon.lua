local Basic = require "melee.zerg.basic"

---@type AIPersonality
return {
    name = "Sunblot: Descending Horizon",
    unit_composition = {
        -- signature units (Skibact Scab)
        [UnitId.ZergSkithrokor] = 2,
        [UnitId.ZergBactalisk] = 2,
        -- filler units
        [UnitId.ZergGorgrokor] = 1,
        [UnitId.ZergMutalisk] = 1,
        [UnitId.ZergGeszithalor] = 1,
        [UnitId.ZergNathrokor] = 1,
        [UnitId.ZergVorvrokor] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.ZergQuazethPool, 110, true)
        melee_ai:dynamic_wait(secs(25))
        melee_ai:start_expanding()
        melee_ai:dynamic_wait(mins(1) + secs(50))
        town:build(2, UnitId.ZergHachirosk, 115)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.ZergVornathPond, 90, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.ZergHydrithDen, 90, true)
        melee_ai:dynamic_wait(secs(25))
        melee_ai:start_attacking()
        melee_ai:dynamic_wait(mins(1))
        -- tier2
        town:build(1, UnitId.ZergIrolIris, 70, true)
        town:multirun(function(town)
            town:wait_build(1, UnitId.ZergHydrithDen)
            melee_ai:dynamic_wait(mins(1) + secs(40))
            town:build(1, UnitId.ZergSkibactScab, 70, true)
            melee_ai:dynamic_wait(mins(1) + secs(40))
            town:build(1, UnitId.ZergTethvithSwamp, 70, true)
            melee_ai:dynamic_wait(secs(25))
            town:wait_build(1, UnitId.ZergQuazethPool)
            town:build(1, UnitId.ZergVornathPond, 70, true)
            town:wait_build(1, UnitId.ZergVornathPond)
            melee_ai:dynamic_wait(mins(1) + secs(40))
            town:build(1, UnitId.ZergKalkiirLake, 70, true)
            melee_ai:dynamic_wait(secs(25))
            town:wait_build(1, UnitId.ZergIrolIris)
            town:build(1, UnitId.ZergMutathSpire, 70, true)
            town:wait_build(1, UnitId.ZergMutathSpire)
            melee_ai:dynamic_wait(mins(1) + secs(40))
            town:build(1, UnitId.ZergTosvrolHaunt, 70, true)
            melee_ai:dynamic_wait(secs(25))
            town:build(1, UnitId.ZergMatravilNest, 70, true)
        end)
        melee_ai:dynamic_wait(mins(2))
        -- tier3
        town:multirun(function(town)
            melee_ai:dynamic_wait(mins(1) + secs(15))
            town:build(1, UnitId.ZergOthstolOviform, 65, true)
        end)
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
        -- production for the Skibact horizon army + Nathrokor flyer support
        town:build(1, UnitId.ZergHydrithDen, 70, true)
        town:build(1, UnitId.ZergQuazethPool, 70, true)
        town:build(1, UnitId.ZergZorkizShroud, 70, true)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.ZergSkibactScab, 70, true)
        town:build(1, UnitId.ZergVornathPond, 70, true)
        town:build(1, UnitId.ZergUlgorgCavern, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.ZergIrolIris, 70, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.ZergMutathSpire, 70, true)
        town:build(1, UnitId.ZergOthstolOviform, 65, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.ZergGeszkathGrotto, 50, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.6,
}
