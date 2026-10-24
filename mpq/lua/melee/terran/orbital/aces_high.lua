local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "Orbital: Aces High",
    unit_composition = {
        -- signature units
        [UnitId.TerranVulture] = 3,
        [UnitId.TerranWraith] = 3,
        -- filler units
        [UnitId.TerranBlackjack] = 1,
        [UnitId.TerranCyclops] = 1,
        [UnitId.TerranSalamander] = 1,
        [UnitId.TerranCentaur] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.TerranFulcrum, 110)
        melee_ai:dynamic_wait(secs(20))
        town:build(2, UnitId.TerranFulcrum, 90)
        melee_ai:dynamic_wait(secs(25))
        town:wait_build(2, UnitId.TerranFulcrum, false)
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranFulcrum)
            town:build(1, UnitId.TerranScrapyard, 89)
            town:wait_build(2, UnitId.TerranFulcrum)
            town:build(2, UnitId.TerranScrapyard, 89)
            town:wait_build(3, UnitId.TerranFulcrum)
            town:build(3, UnitId.TerranScrapyard, 89)
        end)
        melee_ai:dynamic_wait(secs(25))
        melee_ai:start_attacking()
        melee_ai:dynamic_wait(secs(30))
        melee_ai:start_expanding()
        -- tier1
        melee_ai:dynamic_wait(secs(50))
        town:build(3, UnitId.TerranFulcrum, 90)
        melee_ai:dynamic_wait(secs(25))
        town:build(3, UnitId.TerranStarpad, 90)
        melee_ai:dynamic_wait(mins(1) + secs(20))
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
        -- production for the Vulture + Wraith aces (+ Blackjack / Cyclops / Salamander / Centaur)
        town:build(1, UnitId.TerranFulcrum, 70, true)
        town:build(1, UnitId.TerranScrapyard, 68, true)
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
