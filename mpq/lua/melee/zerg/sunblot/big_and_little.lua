local Basic = require "melee.zerg.basic"

---@type AIPersonality
return {
    name = "Sunblot: Big and Little",
    unit_composition = {
        -- signature units
        [UnitId.ZergNathrokor] = 2,
        [UnitId.ZergMutalisk] = 2,
        [UnitId.ZergGorgrokor] = 2,
        -- filler units
        [UnitId.ZergGeszithalor] = 1,
        [UnitId.ZergVilgorokor] = 1,
        [UnitId.ZergSovroleth] = 1,
        [UnitId.ZergVorvrokor] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(30))
        melee_ai:start_expanding()
        melee_ai:dynamic_wait(secs(40))
        town:build(1, UnitId.ZergQuazethPool, 90, true)
        melee_ai:dynamic_wait(secs(15))
        town:build(2, UnitId.ZergHachirosk, 115)
        melee_ai:dynamic_wait(secs(40))
        town:build(1, UnitId.ZergVornathPond, 90, true)
        melee_ai:dynamic_wait(secs(45))
        melee_ai:start_attacking()
        -- tier1
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.ZergZorkizShroud, 90, true)
        melee_ai:dynamic_wait(mins(1) + secs(55))
        -- tier2
        town:build(1, UnitId.ZergIrolIris, 70, true)
        melee_ai:dynamic_wait(secs(1))
        town:multirun(function(town)
            melee_ai:dynamic_wait(secs(1))
            town:wait_build(1, UnitId.ZergQuazethPool)
            melee_ai:dynamic_wait(secs(50))
            town:build(1, UnitId.ZergVornathPond, 70, true)
            melee_ai:dynamic_wait(mins(1) + secs(40))
            town:build(1, UnitId.ZergKalkiirLake, 70, true)
            town:wait_build(1, UnitId.ZergZorkizShroud)
            melee_ai:dynamic_wait(mins(1) + secs(40))
            town:build(1, UnitId.ZergUlgorgCavern, 70, true)
            town:wait_build(1, UnitId.ZergIrolIris)
            town:build(1, UnitId.ZergMutathSpire, 70, true)
            town:wait_build(1, UnitId.ZergMutathSpire)
            melee_ai:dynamic_wait(mins(3) + secs(20))
            town:build(1, UnitId.ZergTosvrolHaunt, 70, true)
        end)
        melee_ai:dynamic_wait(mins(1) + secs(15))
        town:build(1, UnitId.ZergCaphrolosk, 70)
        melee_ai:dynamic_wait(mins(1) + secs(45))
        town:build(3, UnitId.ZergHachirosk, 115)
        melee_ai:dynamic_wait(secs(30))
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
        -- production for the Nathrokor / Mutalisk / Gorgrokor flyer army
        town:build(1, UnitId.ZergQuazethPool, 70, true)
        town:build(1, UnitId.ZergZorkizShroud, 70, true)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.ZergVornathPond, 70, true)
        town:build(1, UnitId.ZergUlgorgCavern, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.ZergIrolIris, 70, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.ZergMutathSpire, 70, true)
        town:build(1, UnitId.ZergMatravilNest, 70, true)
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
