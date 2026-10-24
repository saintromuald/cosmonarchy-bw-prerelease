local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "General: 2 Fulcrum Mech",
    unit_composition = {
        -- signature units (Mantle x2)
        [UnitId.TerranPhalanxTankMode] = 2,
        [UnitId.TerranRamesses] = 2,
        [UnitId.TerranDurendal] = 2,
        [UnitId.TerranCataphract] = 2,
        -- filler units
        [UnitId.TerranBlackjack] = 1,
        [UnitId.TerranMadrigalImperiosoMode] = 1,
        [UnitId.TerranCuirassTankMode] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        melee_ai:dynamic_wait(secs(40))
        town:build(1, UnitId.TerranFulcrum, 110)
        melee_ai:dynamic_wait(secs(25))
        town:build(2, UnitId.TerranFulcrum, 90)
        melee_ai:dynamic_wait(secs(25))
        melee_ai:start_expanding()
        -- tier1
        melee_ai:dynamic_wait(mins(1))
        town:build(3, UnitId.TerranFulcrum, 90)
        melee_ai:dynamic_wait(secs(40))
        -- tier2
        town:build(1, UnitId.TerranAtlas, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranFulcrum)
            town:build(1, UnitId.TerranScrapyard, 69)
            town:wait_build(2, UnitId.TerranFulcrum)
            town:build(2, UnitId.TerranScrapyard, 69)
            town:wait_build(3, UnitId.TerranFulcrum)
            town:build(1, UnitId.TerranPalladium, 69)
            town:wait_build(4, UnitId.TerranFulcrum)
            town:build(2, UnitId.TerranPalladium, 69)
        end)
        melee_ai:dynamic_wait(secs(40) + secs(40))
        town:build(2, UnitId.TerranMantle, 70)
        -- tier3
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranDaedala, 65, true)
        end)
        town:wait_build(1, UnitId.TerranDaedala)
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Mantle walkers (Ramesses / Durendal / Cataphract) + Phalanx / Blackjack / Cuirass
        town:build(1, UnitId.TerranFulcrum, 70, true)
        town:build(1, UnitId.TerranScrapyard, 68, true)
        town:build(1, UnitId.TerranPalladium, 68, true)
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
