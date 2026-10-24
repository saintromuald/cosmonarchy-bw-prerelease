local Basic = require "melee.zerg.basic"

---@type AIPersonality
return {
    name = "Assault: Earthen Tides",
    unit_composition = {
        -- signature units
        [UnitId.ZergIzirokor] = 2,
        [UnitId.ZergLakizilisk] = 2,
        [UnitId.ZergProtathalor] = 2,
        -- filler units
        [UnitId.ZergSovroleth] = 1,
        [UnitId.ZergKeskathalor] = 1,
        [UnitId.ZergSkithrokor] = 1,
        [UnitId.ZergBactalisk] = 1,
        [UnitId.ZergNathrokor] = 1,
        [UnitId.ZergVorvrokor] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.ZergHydrithDen, 110, true)
        melee_ai:dynamic_wait(secs(25))
        melee_ai:start_attacking()
        melee_ai:dynamic_wait(secs(45))
        melee_ai:start_expanding()
        -- tier1
        melee_ai:dynamic_wait(secs(30))
        town:build(2, UnitId.ZergHachirosk, 115)
        melee_ai:dynamic_wait(secs(40))
        town:build(1, UnitId.ZergZorkizShroud, 90, true)
        melee_ai:dynamic_wait(mins(1) + secs(30))
        town:build(1, UnitId.ZergSkibactScab, 90, true)
        melee_ai:dynamic_wait(secs(40))
        town:build(1, UnitId.ZergQuazethPool, 90, true)
        melee_ai:dynamic_wait(secs(50))
        -- tier2
        town:build(1, UnitId.ZergIrolIris, 70, true)
        melee_ai:dynamic_wait(secs(40))
        town:build(3, UnitId.ZergHachirosk, 115)
        melee_ai:dynamic_wait(secs(25))
        town:multirun(function(town)
            town:wait_build(1, UnitId.ZergQuazethPool)
            melee_ai:dynamic_wait(mins(1) + secs(40))
            town:build(1, UnitId.ZergVornathPond, 70, true)
            melee_ai:dynamic_wait(mins(1) + secs(40))
            town:build(1, UnitId.ZergKalkiirLake, 70, true)
            town:wait_build(1, UnitId.ZergIrolIris)
            town:build(1, UnitId.ZergMutathSpire, 70, true)
            melee_ai:dynamic_wait(mins(1))
            town:build(1, UnitId.ZergMatravilNest, 70, true)
        end)
        melee_ai:dynamic_wait(mins(2) + secs(5))
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
        -- production for the Earthen Tides army (Izirokor / Lakizilisk / Protathalor)
        town:build(1, UnitId.ZergHydrithDen, 70, true)
        town:build(1, UnitId.ZergQuazethPool, 70, true)
        town:build(1, UnitId.ZergZorkizShroud, 70, true)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.ZergVornathPond, 70, true)
        town:build(1, UnitId.ZergSkibactScab, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.ZergIrolIris, 70, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.ZergMutathSpire, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.ZergTosvrolHaunt, 70, true)
        town:build(1, UnitId.ZergOthstolOviform, 65, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.ZergGeszkathGrotto, 50, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.6,
}
