local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "Armor: FE 5Fulc",
    unit_composition = {
        -- signature units
        [UnitId.TerranVulture] = 2,
        [UnitId.TerranBlackjack] = 2,
        [UnitId.TerranPhalanxTankMode] = 2,
        -- filler units
        [UnitId.TerranMaverick] = 1,
        [UnitId.TerranAzazel] = 1,
        [UnitId.TerranSeraph] = 1,
        [UnitId.TerranRamesses] = 1,
        [UnitId.TerranCuirassTankMode] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranStockade, 110)
        melee_ai:dynamic_wait(secs(35))
        town:build(1, UnitId.TerranFulcrum, 90)
        melee_ai:dynamic_wait(secs(45))
        melee_ai:start_expanding()
        -- tier1
        melee_ai:dynamic_wait(secs(50))
        town:build(3, UnitId.TerranFulcrum, 90)
        melee_ai:dynamic_wait(secs(5))
        -- tier2 (starport/commandment)
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranFulcrum)
            town:build(1, UnitId.TerranScrapyard, 69)
            town:wait_build(2, UnitId.TerranFulcrum)
            town:build(1, UnitId.TerranPalladium, 69)
            town:wait_build(3, UnitId.TerranFulcrum)
            town:build(2, UnitId.TerranPalladium, 69)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranStarport, 70)
            town:wait_build(1, UnitId.TerranStarport)
            town:build(1, UnitId.TerranCommandment, 69)
        end)
        melee_ai:dynamic_wait(secs(25))
        town:wait_build(2, UnitId.TerranFulcrum, false)
        melee_ai:dynamic_wait(secs(70) + secs(25))
        town:build(5, UnitId.TerranFulcrum, 70)
        melee_ai:dynamic_wait(mins(2) + secs(15))
        town:build(1, UnitId.TerranAtlas, 70, true)
        -- tier3
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranDaedala, 65, true)
        end)
        town:wait_build(1, UnitId.TerranDaedala)
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Vulture / Blackjack / Phalanx army (+ Azazel / Seraph / Cuirass)
        town:build(1, UnitId.TerranFulcrum, 70, true)
        town:build(1, UnitId.TerranStockade, 70, true)
        town:build(1, UnitId.TerranScrapyard, 68, true)
        town:build(1, UnitId.TerranPalladium, 68, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranAtlas, 70, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.TerranStarport, 65, true)
        town:build(1, UnitId.TerranCommandment, 65, true)
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
