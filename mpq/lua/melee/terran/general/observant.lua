local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "General: Observant",
    unit_composition = {
        -- signature unit
        [UnitId.TerranCyprian] = 2,
        -- filler units
        [UnitId.TerranSeraph] = 1,
        [UnitId.TerranBlackjack] = 1,
        [UnitId.TerranCentaur] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranStockade, 110)
        melee_ai:dynamic_wait(secs(5))
        -- tier2
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranStockade)
            town:build(1, UnitId.TerranVestry, 69)
            town:wait_build(1, UnitId.TerranFulcrum)
            town:build(1, UnitId.TerranScrapyard, 69)
            town:wait_build(2, UnitId.TerranFulcrum)
            town:build(2, UnitId.TerranPalladium, 69)
            town:wait_build(3, UnitId.TerranFulcrum)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(2, UnitId.TerranStarport, 70)
            town:wait_build(2, UnitId.TerranStarport)
            town:build(2, UnitId.TerranCommandment, 69)
            town:wait_build(1, UnitId.TerranCommandment)
            melee_ai:dynamic_wait(secs(15))
        end)
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.TerranFulcrum, 70)
        melee_ai:dynamic_wait(secs(5) + secs(35))
        town:build(1, UnitId.TerranStarpad, 70)
        melee_ai:dynamic_wait(secs(30))
        town:build(2, UnitId.TerranFulcrum, 70)
        melee_ai:dynamic_wait(secs(25) + secs(50))
        town:build(1, UnitId.TerranAtlas, 70, true)
        town:build(3, UnitId.TerranFulcrum, 70)
        melee_ai:dynamic_wait(secs(50))
        -- tier3
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranDaedala, 65, true)
        end)
        town:wait_build(1, UnitId.TerranDaedala)
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Cyprian core + Blackjack / Seraph / Centaur
        town:build(1, UnitId.TerranStockade, 70, true)
        town:build(1, UnitId.TerranFulcrum, 70, true)
        town:build(1, UnitId.TerranScrapyard, 68, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranAtlas, 70, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.TerranStarport, 65, true)
        town:build(1, UnitId.TerranCommandment, 65, true)
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
