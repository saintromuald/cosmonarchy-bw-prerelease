local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "General: Mech into Air",
    unit_composition = {
        -- signature units (the mech-into-air transition)
        [UnitId.TerranPhalanxTankMode] = 2,
        [UnitId.TerranMinotaur] = 2,
        -- filler units
        [UnitId.TerranMatadorTankMode] = 1,
        [UnitId.TerranSalamander] = 1,
        [UnitId.TerranSeraph] = 1,
        [UnitId.TerranHippogriff] = 1,
        [UnitId.TerranPhobos] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.TerranFulcrum, 110)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.TerranStockade, 90)
        melee_ai:dynamic_wait(secs(15))
        town:build(2, UnitId.TerranFulcrum, 90)
        melee_ai:dynamic_wait(secs(25))
        melee_ai:start_attacking()
        melee_ai:dynamic_wait(mins(1))
        -- tier2
        town:build(1, UnitId.TerranAtlas, 70, true)
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranFulcrum)
            town:build(1, UnitId.TerranScrapyard, 69)
            town:wait_build(2, UnitId.TerranFulcrum)
            town:build(2, UnitId.TerranScrapyard, 69)
            town:build(1, UnitId.TerranQuarry, 69)
            town:wait_build(3, UnitId.TerranFulcrum)
            town:build(1, UnitId.TerranPalladium, 69)
            town:wait_build(4, UnitId.TerranFulcrum)
            town:build(2, UnitId.TerranPalladium, 69)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(2, UnitId.TerranStarport, 70)
            town:wait_build(1, UnitId.TerranStarport)
            town:build(1, UnitId.TerranRotary, 69)
            town:wait_build(2, UnitId.TerranStarport)
            town:build(2, UnitId.TerranRotary, 69)
            town:wait_build(5, UnitId.TerranFulcrum)
            town:build(3, UnitId.TerranPalladium, 69)
            town:wait_build(6, UnitId.TerranFulcrum)
            town:build(4, UnitId.TerranPalladium, 69)
            town:wait_build(3, UnitId.TerranStarport)
            town:build(3, UnitId.TerranRotary, 69)
            town:wait_build(4, UnitId.TerranStarport)
            town:build(4, UnitId.TerranRotary, 69)
            town:wait_build(5, UnitId.TerranStarport)
            town:build(5, UnitId.TerranRotary, 69)
            town:wait_build(1, UnitId.TerranDaedala)
            town:wait_build(6, UnitId.TerranStarport)
            town:build(1, UnitId.TerranCommandment, 69)
            town:wait_build(7, UnitId.TerranStarport)
            town:build(2, UnitId.TerranCommandment, 69)
            town:wait_build(8, UnitId.TerranStarport)
            town:build(3, UnitId.TerranCommandment, 69)
            town:build(2, UnitId.TerranNaniteAssembly, 69)
            town:wait_build(1, UnitId.TerranNaniteAssembly)
            town:build(1, UnitId.TerranHadron, 69)
        end)
        melee_ai:dynamic_wait(mins(1) + secs(15))
        town:build(1, UnitId.TerranStarpad, 70)
        melee_ai:dynamic_wait(secs(15) + mins(1) + secs(15))
        town:build(6, UnitId.TerranFulcrum, 70)
        melee_ai:dynamic_wait(mins(1) + secs(40))
        -- tier3
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranDaedala, 65, true)
        end)
        town:wait_build(1, UnitId.TerranDaedala)
        melee_ai:dynamic_wait(mins(1) + secs(15))
        town:build(4, UnitId.TerranStarport, 50)
        melee_ai:dynamic_wait(mins(1) + secs(40))
        town:build(8, UnitId.TerranStarport, 50)
        melee_ai:dynamic_wait(mins(1) + secs(15))
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the mech-to-air transition (Phalanx / Matador -> Minotaur / Seraph / Hippogriff)
        town:build(1, UnitId.TerranFulcrum, 70, true)
        town:build(1, UnitId.TerranScrapyard, 68, true)
        town:build(1, UnitId.TerranPalladium, 68, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranAtlas, 70, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.TerranStarport, 65, true)
        town:build(1, UnitId.TerranRotary, 65, true)
        town:build(1, UnitId.TerranCommandment, 65, true)
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranDaedala, 65, true)
        end)
        town:wait_build(1, UnitId.TerranDaedala)
        town:build(1, UnitId.TerranNaniteAssembly, 65, true)
        town:build(1, UnitId.TerranHadron, 65, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.5,
}
