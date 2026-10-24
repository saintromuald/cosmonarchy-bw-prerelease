local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "General: The Cube",
    unit_composition = {
        -- signature unit
        [UnitId.TerranMaverick] = 2,
        -- filler units
        [UnitId.TerranVulture] = 1,
        [UnitId.TerranPhalanxTankMode] = 1,
        [UnitId.TerranSalamander] = 1,
        [UnitId.TerranCentaur] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.TerranFulcrum, 110)
        -- tier1
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.TerranStockade, 90)
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.TerranStarpad, 90)
        melee_ai:dynamic_wait(secs(25))
        -- tier2
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranStockade)
            town:build(1, UnitId.TerranVestry, 69)
            town:wait_build(1, UnitId.TerranFulcrum)
            town:build(1, UnitId.TerranPalladium, 69)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranStarport, 70)
            town:wait_build(1, UnitId.TerranStarport)
            town:build(1, UnitId.TerranRotary, 69)
        end)
        melee_ai:dynamic_wait(secs(40) + secs(25) + secs(50))
        town:build(1, UnitId.TerranAtlas, 70, true)
        melee_ai:dynamic_wait(secs(20))
        town:build(3, UnitId.TerranFulcrum, 70)
        melee_ai:dynamic_wait(secs(45))
        -- tier3
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranDaedala, 65, true)
        end)
        town:wait_build(1, UnitId.TerranDaedala)
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Maverick core + Vulture / Phalanx / Salamander / Centaur
        town:build(1, UnitId.TerranStockade, 70, true)
        town:build(1, UnitId.TerranFulcrum, 70, true)
        town:build(1, UnitId.TerranPalladium, 68, true)
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
    attack_wave_cost_bias = 0.5,
}
