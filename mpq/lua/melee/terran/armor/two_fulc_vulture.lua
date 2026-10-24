local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "Armor: 2Fulc Vulture",
    unit_composition = {
        -- signature unit
        [UnitId.TerranVulture] = 3,
        -- filler units
        [UnitId.TerranMaverick] = 1,
        [UnitId.TerranCyclops] = 1,
        [UnitId.TerranRamesses] = 1,
        [UnitId.TerranCuirassTankMode] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.TerranFulcrum, 110)
        melee_ai:dynamic_wait(secs(15))
        town:build(2, UnitId.TerranFulcrum, 90)
        melee_ai:dynamic_wait(mins(1) + secs(15))
        melee_ai:start_attacking()
        melee_ai:dynamic_wait(secs(50))
        melee_ai:start_expanding()
        -- tier1
        town:build(3, UnitId.TerranFulcrum, 90)
        melee_ai:dynamic_wait(secs(5))
        town:build(1, UnitId.TerranStockade, 90)
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
        -- production for the Vulture-heavy mech (+ Maverick / Cyclops / Ramesses / Cuirass)
        town:build(1, UnitId.TerranFulcrum, 70, true)
        town:build(1, UnitId.TerranStockade, 70, true)
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
