local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "Armor: Iron Crusade",
    unit_composition = {
        -- signature units (Iron Foundry x4 is the real investment of this build)
        [UnitId.TerranPaladin] = 3,
        [UnitId.TerranCuirassTankMode] = 2,
        [UnitId.TerranPazuzu] = 2,
        -- filler units
        [UnitId.TerranVulture] = 1,
        [UnitId.TerranWraith] = 1,
        [UnitId.TerranRamesses] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(30))
        melee_ai:start_expanding()
        -- tier1
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.TerranFulcrum, 90)
        melee_ai:dynamic_wait(mins(1))
        town:wait_build(1, UnitId.TerranFulcrum)
        melee_ai:dynamic_wait(secs(15))
        town:build(1, UnitId.TerranStarpad, 90)
        melee_ai:dynamic_wait(secs(15))
        town:build(2, UnitId.TerranFulcrum, 90)
        melee_ai:dynamic_wait(mins(1) + secs(20))
        -- tier2
        town:build(1, UnitId.TerranAtlas, 70, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(3, UnitId.TerranFulcrum, 70)
        melee_ai:dynamic_wait(secs(5))
        town:wait_build(2, UnitId.TerranFulcrum)
        town:wait_build(3, UnitId.TerranFulcrum, false)
        town:wait_build(1, UnitId.TerranAtlas)
        melee_ai:dynamic_wait(secs(20))
        town:build(4, UnitId.TerranFulcrum, 70)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.TerranMantle, 69, true)
        -- tier3
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranDaedala, 65, true)
        end)
        town:wait_build(1, UnitId.TerranDaedala)
        melee_ai:dynamic_wait(secs(5))
        town:build(1, UnitId.TerranIronFoundry, 50)
        melee_ai:dynamic_wait(secs(5))
        town:build(2, UnitId.TerranIronFoundry, 50)
        melee_ai:dynamic_wait(secs(5))
        town:build(3, UnitId.TerranIronFoundry, 50)
        melee_ai:dynamic_wait(secs(5))
        town:build(4, UnitId.TerranIronFoundry, 50)
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        -- production for the Iron Foundry crusade (Paladin / Cuirass / Pazuzu + Vulture / Wraith / Ramesses)
        town:build(1, UnitId.TerranFulcrum, 70, true)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.TerranStarpad, 68, true)
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
