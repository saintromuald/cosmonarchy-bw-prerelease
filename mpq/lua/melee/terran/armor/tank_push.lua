local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "Armor: Tank Push",
    unit_composition = {
        -- signature units
        [UnitId.TerranMatadorTankMode] = 2,
        [UnitId.TerranPhalanxTankMode] = 2,
        -- healers
        [UnitId.TerranCleric] = 1,
        -- filler units
        [UnitId.TerranCyprian] = 1,
        [UnitId.TerranBlackjack] = 1,
        [UnitId.TerranMadrigalImperiosoMode] = 1,
        [UnitId.TerranRamesses] = 1,
        [UnitId.TerranCuirassTankMode] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranFulcrum, 110)
        melee_ai:dynamic_wait(secs(5))
        town:wait_build(1, UnitId.TerranFulcrum)
        melee_ai:dynamic_wait(secs(5))
        town:build(1, UnitId.TerranScrapyard, 90)
        town:multirun(function(town)
            melee_ai:dynamic_wait(secs(18))
            town:wait_build(2, UnitId.TerranFulcrum)
            town:build(1, UnitId.TerranPalladium, 89)
            town:wait_build(3, UnitId.TerranFulcrum)
            town:build(2, UnitId.TerranPalladium, 89)
            town:wait_build(4, UnitId.TerranFulcrum)
            town:build(3, UnitId.TerranPalladium, 89)
            town:wait_build(1, UnitId.TerranStockade)
            town:build(1, UnitId.TerranVestry, 89)
        end)
        town:wait_build(1, UnitId.TerranScrapyard, false)
        town:build(2, UnitId.TerranFulcrum, 90)
        town:wait_build(2, UnitId.TerranFulcrum, false)
        melee_ai:start_expanding()
        melee_ai:dynamic_wait(secs(40))
        town:build(3, UnitId.TerranFulcrum, 90)
        melee_ai:dynamic_wait(secs(25))
        town:build(4, UnitId.TerranFulcrum, 90)
        melee_ai:dynamic_wait(secs(25))
        melee_ai:start_attacking()
        melee_ai:dynamic_wait(secs(25))
        -- tier2
        town:build(1, UnitId.TerranAtlas, 70, true)
        melee_ai:dynamic_wait(mins(1))
        town:build(1, UnitId.TerranStockade, 70)
        melee_ai:dynamic_wait(secs(25))
        -- tier3
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranDaedala, 65, true)
        end)
        town:wait_build(1, UnitId.TerranDaedala)
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Matador / Phalanx tank push (+ Cleric / Ramesses / Cuirass)
        town:build(1, UnitId.TerranFulcrum, 70, true)
        town:build(1, UnitId.TerranStockade, 70, true)
        town:build(1, UnitId.TerranScrapyard, 68, true)
        town:build(1, UnitId.TerranPalladium, 68, true)
        town:build(1, UnitId.TerranVestry, 68, true)
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
