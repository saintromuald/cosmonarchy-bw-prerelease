local Basic = require "melee.zerg.basic"

---@type AIPersonality
return {
    name = "Swarm: 3 Base Othstol",
    unit_composition = {
        -- signature units
        [UnitId.ZergIzirokor] = 2,
        [UnitId.ZergUltrokor] = 2,
        [UnitId.ZergHydralisk] = 2,
        -- filler units
        [UnitId.ZergKalkalisk] = 1,
        [UnitId.ZergZoryusthaleth] = 1,
        [UnitId.ZergGorgrokor] = 1,
        [UnitId.ZergSkithrokor] = 1,
        [UnitId.ZergBactalisk] = 1,
        [UnitId.ZergZobriolisk] = 1,
        [UnitId.ZergZarcavrokor] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(45))
        melee_ai:start_expanding()
        melee_ai:dynamic_wait(mins(1) + secs(55))
        town:build(1, UnitId.ZergQuazethPool, 90, true)
        -- tier1
        melee_ai:dynamic_wait(mins(1) + secs(15))
        town:build(2, UnitId.ZergHachirosk, 115)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.ZergVornathPond, 90, true)
        melee_ai:dynamic_wait(secs(15))
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
            melee_ai:dynamic_wait(mins(1) + secs(40))
            town:wait_build(1, UnitId.ZergHydrithDen)
            town:build(1, UnitId.ZergSkibactScab, 70, true)
            melee_ai:dynamic_wait(mins(1) + secs(40))
            town:wait_build(1, UnitId.ZergZorkizShroud)
            town:build(1, UnitId.ZergUlgorgCavern, 70, true)
            melee_ai:dynamic_wait(mins(1) + secs(40))
            town:build(1, UnitId.ZergTethvithSwamp, 70, true)
            melee_ai:dynamic_wait(mins(1) + secs(40))
            town:build(1, UnitId.ZergZozarcGorge, 70, true)
            town:wait_build(1, UnitId.ZergIrolIris)
            melee_ai:dynamic_wait(secs(40))
            town:build(1, UnitId.ZergMatravilNest, 70, true)
            town:wait_build(1, UnitId.ZergOthstolOviform)
            town:build(1, UnitId.ZergGathtelosk, 50)
            town:wait_build(1, UnitId.ZergGathtelosk, false)
            town:wait_build(2, UnitId.ZergHachirosk, false)
        end)
        town:build(1, UnitId.ZergZorkizShroud, 70, true)
        melee_ai:dynamic_wait(secs(40))
        town:build(1, UnitId.ZergHydrithDen, 70, true)
        melee_ai:dynamic_wait(secs(15))
        town:build(3, UnitId.ZergHachirosk, 115)
        melee_ai:dynamic_wait(secs(5))
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
        -- production for the Izirokor / Ultrokor / Hydralisk + Zozarc swarm
        town:build(1, UnitId.ZergHydrithDen, 70, true)
        town:build(1, UnitId.ZergZorkizShroud, 70, true)
        town:build(1, UnitId.ZergKalkiirLake, 70, true)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.ZergSkibactScab, 70, true)
        town:build(1, UnitId.ZergUlgorgCavern, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.ZergZozarcGorge, 70, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.4,
}
