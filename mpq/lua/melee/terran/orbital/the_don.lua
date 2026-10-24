local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "Orbital: The Don",
    unit_composition = {
        -- signature units (Nanite Assembly x3)
        [UnitId.TerranMinotaur] = 2,
        [UnitId.TerranCentaur] = 2,
        [UnitId.TerranMagnetar] = 2,
        -- filler units
        [UnitId.TerranGorgon] = 1,
        [UnitId.TerranWraith] = 0.5,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        melee_ai:dynamic_wait(secs(50))
        melee_ai:start_expanding()
        -- tier1
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranStockade, 90)
        melee_ai:dynamic_wait(mins(1))
        town:wait_build(1, UnitId.TerranStockade)
        melee_ai:dynamic_wait(secs(40))
        -- tier2
        town:build(1, UnitId.TerranAtlas, 70, true)
        -- tier3
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranDaedala, 65, true)
        end)
        town:wait_build(1, UnitId.TerranDaedala)
        town:build(2, UnitId.TerranNaniteAssembly, 50)
        melee_ai:dynamic_wait(secs(20))
        town:build(3, UnitId.TerranNaniteAssembly, 50)
        melee_ai:dynamic_wait(secs(20))
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Nanite Assembly capital fleet (+ Gorgon / Wraith)
        town:build(1, UnitId.TerranStarpad, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranAtlas, 70, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.TerranStarport, 65, true)
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
