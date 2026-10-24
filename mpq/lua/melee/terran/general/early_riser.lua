local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "General: Early Riser",
    unit_composition = {
        -- signature unit
        [UnitId.TerranMaverick] = 2,
        -- healers
        [UnitId.TerranCleric] = 1,
        -- filler units
        [UnitId.TerranCyclops] = 1,
        [UnitId.TerranRamesses] = 1,
        [UnitId.TerranCuirassTankMode] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        melee_ai:dynamic_wait(secs(40))
        melee_ai:start_expanding()
        -- tier1
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranStockade, 90)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranFulcrum, 90)
        melee_ai:dynamic_wait(secs(25))
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranStockade)
            town:build(1, UnitId.TerranVestry, 89)
            town:wait_build(1, UnitId.TerranFulcrum)
            town:build(1, UnitId.TerranPalladium, 89)
        end)
        melee_ai:dynamic_wait(secs(5))
        town:build(1, UnitId.TerranStarpad, 90)
        melee_ai:dynamic_wait(secs(5))
        town:build(2, UnitId.TerranStockade, 90)
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
        -- production for the Maverick + Cleric core (+ Cyclops / Ramesses / Cuirass)
        town:build(1, UnitId.TerranStockade, 70, true)
        town:build(1, UnitId.TerranVestry, 68, true)
        town:build(1, UnitId.TerranFulcrum, 70, true)
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
    attack_wave_cost_bias = 0.5,
}
