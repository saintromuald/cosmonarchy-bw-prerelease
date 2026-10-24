local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "Orbital: Hotdrop",
    unit_composition = {
        -- signature unit
        [UnitId.TerranHarakan] = 3,
        -- filler units
        [UnitId.TerranWraith] = 1,
        [UnitId.TerranSalamander] = 1,
        [UnitId.TerranCentaur] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.TerranStockade, 110)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranStarpad, 90)
        melee_ai:dynamic_wait(secs(35))
        town:build(2, UnitId.TerranStarpad, 90)
        melee_ai:dynamic_wait(secs(45))
        town:build(2, UnitId.TerranStockade, 90)
        melee_ai:dynamic_wait(secs(20))
        town:build(3, UnitId.TerranStarpad, 90)
        melee_ai:dynamic_wait(secs(35))
        melee_ai:start_attacking()
        melee_ai:dynamic_wait(secs(15))
        melee_ai:start_expanding()
        melee_ai:dynamic_wait(secs(40))
        town:wait_build(3, UnitId.TerranStarpad)
        town:wait_build(2, UnitId.TerranStockade, false)
        -- tier2
        town:build(1, UnitId.TerranAtlas, 70, true)
        melee_ai:dynamic_wait(secs(20))
        town:multirun(function(town)
            town:build(1, UnitId.TerranCovenant, 69)
            town:wait_build(1, UnitId.TerranCovenant)
            town:build(1, UnitId.TerranAnvil, 69)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranStarport, 70)
            town:wait_build(1, UnitId.TerranStarport)
            town:build(1, UnitId.TerranRotary, 69)
            town:build(2, UnitId.TerranStarport, 70)
            town:wait_build(2, UnitId.TerranStarport)
            town:build(2, UnitId.TerranRotary, 69)
            melee_ai:dynamic_wait(secs(50))
        end)
        melee_ai:dynamic_wait(secs(40))
        -- tier3
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranDaedala, 65, true)
        end)
        town:wait_build(1, UnitId.TerranDaedala)
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Harakan drop force + Wraith / Salamander / Centaur support
        town:build(1, UnitId.TerranStockade, 70, true)
        town:build(1, UnitId.TerranStarpad, 70, true)
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
