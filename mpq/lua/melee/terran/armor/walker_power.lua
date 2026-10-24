local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "Armor: Walker Power",
    unit_composition = {
        -- signature units (walkers)
        [UnitId.TerranGoliath] = 3,
        [UnitId.TerranCyclops] = 2,
        [UnitId.TerranBlackjack] = 2,
        -- filler units
        [UnitId.TerranPhalanxTankMode] = 1,
        [UnitId.TerranMaverick] = 1,
        [UnitId.TerranRamesses] = 1,
        [UnitId.TerranCuirassTankMode] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.TerranFulcrum, 110)
        melee_ai:dynamic_wait(secs(20))
        town:build(2, UnitId.TerranFulcrum, 90)
        melee_ai:dynamic_wait(secs(35))
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranFulcrum)
            town:build(1, UnitId.TerranScrapyard, 89)
            melee_ai:dynamic_wait(secs(15))
            town:wait_build(2, UnitId.TerranFulcrum)
            town:build(1, UnitId.TerranPalladium, 89)
        end)
        melee_ai:dynamic_wait(secs(25))
        melee_ai:start_attacking()
        melee_ai:dynamic_wait(secs(5))
        town:wait_build(1, UnitId.TerranFulcrum)
        town:wait_build(2, UnitId.TerranFulcrum, false)
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.TerranStockade, 90)
        melee_ai:dynamic_wait(mins(1) + secs(10))
        melee_ai:start_expanding()
        melee_ai:dynamic_wait(mins(1))
        -- tier2/tier3
        town:build(1, UnitId.TerranAtlas, 70, true)
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranDaedala, 65, true)
        end)
        town:wait_build(1, UnitId.TerranDaedala)
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Goliath / Cyclops / Blackjack walkers (+ Phalanx / Ramesses / Cuirass)
        town:build(1, UnitId.TerranFulcrum, 70, true)
        town:build(1, UnitId.TerranStockade, 70, true)
        town:build(1, UnitId.TerranScrapyard, 68, true)
        town:build(1, UnitId.TerranPalladium, 68, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranAtlas, 70, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.TerranMantle, 65, true)
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranDaedala, 65, true)
        end)
        town:wait_build(1, UnitId.TerranDaedala)
        town:build(1, UnitId.TerranIronFoundry, 65, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.6,
}
