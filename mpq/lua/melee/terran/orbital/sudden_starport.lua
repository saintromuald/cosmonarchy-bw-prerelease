local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "Orbital: Sudden Starport",
    unit_composition = {
        -- signature units
        [UnitId.TerranMaverick] = 2,
        [UnitId.TerranSundog] = 2,
        [UnitId.TerranSalamander] = 2,
        -- healers
        [UnitId.TerranCleric] = 1.5,
        -- filler units
        [UnitId.TerranCentaur] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.TerranStockade, 110)
        melee_ai:dynamic_wait(secs(25))
        melee_ai:start_expanding()
        melee_ai:dynamic_wait(secs(40))
        town:build(2, UnitId.TerranStockade, 90)
        melee_ai:dynamic_wait(secs(20))
        town:build(3, UnitId.TerranStockade, 90)
        melee_ai:dynamic_wait(secs(15))
        melee_ai:start_attacking()
        melee_ai:dynamic_wait(secs(50))
        town:wait_build(3, UnitId.TerranStockade, false)
        -- tier2
        town:multirun(function(town)
            town:wait_build(2, UnitId.TerranStockade)
            town:build(1, UnitId.TerranVestry, 69)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranStarport, 70)
            town:wait_build(1, UnitId.TerranStarport, false)
            town:build(4, UnitId.TerranStarport, 70)
            town:wait_build(1, UnitId.TerranStarport)
            town:build(1, UnitId.TerranRotary, 69)
            town:wait_build(2, UnitId.TerranStarport)
            town:build(2, UnitId.TerranRotary, 69)
            town:wait_build(3, UnitId.TerranStarport)
            town:build(3, UnitId.TerranRotary, 69)
            town:wait_build(4, UnitId.TerranStarport)
            town:build(4, UnitId.TerranRotary, 69)
            melee_ai:dynamic_wait(secs(15))
        end)
        melee_ai:dynamic_wait(mins(1) + secs(15))
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
        -- production for the Maverick + Sundog / Salamander army (+ Cleric / Centaur)
        town:build(1, UnitId.TerranStockade, 70, true)
        town:build(1, UnitId.TerranVestry, 68, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranAtlas, 70, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.TerranStarport, 65, true)
        town:build(1, UnitId.TerranRotary, 65, true)
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranDaedala, 65, true)
        end)
        town:wait_build(1, UnitId.TerranDaedala)
        town:build(1, UnitId.TerranNaniteAssembly, 65, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.6,
}
