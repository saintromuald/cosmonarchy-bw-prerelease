local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "Armor: David and Goliath",
    unit_composition = {
        -- signature units
        [UnitId.TerranGoliath] = 3,
        [UnitId.TerranMaverick] = 2,
        -- filler units
        [UnitId.TerranMatadorTankMode] = 1,
        [UnitId.TerranPhalanxTankMode] = 1,
        [UnitId.TerranWraith] = 1,
        [UnitId.TerranBlackjack] = 1,
        [UnitId.TerranRamesses] = 1,
        [UnitId.TerranCuirassTankMode] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranFulcrum, 110)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranStockade, 90)
        melee_ai:dynamic_wait(secs(40))
        town:build(2, UnitId.TerranStockade, 90)
        town:wait_build(2, UnitId.TerranStockade, false)
        melee_ai:dynamic_wait(secs(15))
        melee_ai:start_attacking()
        melee_ai:dynamic_wait(secs(30))
        town:build(2, UnitId.TerranFulcrum, 90)
        town:wait_build(2, UnitId.TerranFulcrum, false)
        town:multirun(function(town)
            town:wait_build(2, UnitId.TerranFulcrum)
            town:build(1, UnitId.TerranScrapyard, 89)
            town:wait_build(2, UnitId.TerranFulcrum)
            town:build(1, UnitId.TerranPalladium, 89)
            melee_ai:dynamic_wait(secs(5))
            town:wait_build(3, UnitId.TerranFulcrum)
            town:build(2, UnitId.TerranPalladium, 89)
            melee_ai:dynamic_wait(secs(15))
            town:wait_build(5, UnitId.TerranFulcrum)
            town:build(3, UnitId.TerranPalladium, 89)
            melee_ai:dynamic_wait(secs(15))
        end)
        melee_ai:dynamic_wait(secs(25))
        melee_ai:start_expanding()
        -- tier1
        melee_ai:dynamic_wait(secs(50))
        town:build(3, UnitId.TerranStockade, 90)
        melee_ai:dynamic_wait(secs(25))
        town:build(4, UnitId.TerranStockade, 90)
        melee_ai:dynamic_wait(secs(25))
        town:build(3, UnitId.TerranFulcrum, 90)
        melee_ai:dynamic_wait(mins(1) + secs(20))
        town:wait_build(1, UnitId.TerranFulcrum)
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.TerranStarpad, 90)
        melee_ai:dynamic_wait(secs(40))
        -- tier2
        town:build(1, UnitId.TerranAtlas, 70, true)
        melee_ai:dynamic_wait(secs(20))
        town:build(4, UnitId.TerranFulcrum, 70)
        melee_ai:dynamic_wait(secs(25))
        town:build(5, UnitId.TerranFulcrum, 70)
        melee_ai:dynamic_wait(secs(5))
        -- tier3
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranDaedala, 65, true)
        end)
        town:wait_build(1, UnitId.TerranDaedala)
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Goliath / Maverick army (+ Matador / Phalanx / Wraith / Cuirass)
        town:build(1, UnitId.TerranFulcrum, 70, true)
        town:build(1, UnitId.TerranStockade, 70, true)
        town:build(1, UnitId.TerranScrapyard, 68, true)
        town:build(1, UnitId.TerranPalladium, 68, true)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.TerranStarpad, 68, true)
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
