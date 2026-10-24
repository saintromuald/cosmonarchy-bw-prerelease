local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "Raider: 4Rax Pressure",
    unit_composition = {
        -- healers
        [UnitId.TerranShamanSupportMode] = 2,
        -- filler units
        [UnitId.TerranSavantEntropyGauntlets] = 1,
        [UnitId.TerranCyprian] = 1,
        [UnitId.TerranMadcap] = 1,
        [UnitId.TerranDilettante] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.TerranStockade, 110)
        melee_ai:dynamic_wait(secs(20))
        town:build(2, UnitId.TerranStockade, 90)
        melee_ai:dynamic_wait(secs(20))
        town:build(3, UnitId.TerranStockade, 90)
        melee_ai:dynamic_wait(secs(20))
        melee_ai:start_attacking()
        melee_ai:dynamic_wait(mins(1))
        melee_ai:start_expanding()
        -- tier1
        melee_ai:dynamic_wait(secs(30))
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranStockade)
            town:build(1, UnitId.TerranVestry, 89)
            town:wait_build(2, UnitId.TerranStockade)
            town:build(2, UnitId.TerranVestry, 89)
            town:wait_build(3, UnitId.TerranStockade)
            town:build(1, UnitId.TerranCovenant, 89)
            town:wait_build(4, UnitId.TerranStockade)
            town:build(2, UnitId.TerranCovenant, 89)
        end)
        melee_ai:dynamic_wait(secs(5))
        town:wait_build(4, UnitId.TerranStockade)
        melee_ai:dynamic_wait(mins(1))
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
        -- production for the Shaman + Savant support raid (+ Cyprian / Madcap / Dilettante)
        town:build(1, UnitId.TerranStockade, 70, true)
        town:build(1, UnitId.TerranVestry, 68, true)
        town:build(1, UnitId.TerranCovenant, 68, true)
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranAtlas, 70, true)
        melee_ai:dynamic_wait(secs(30))
        town:build(1, UnitId.TerranCaptaincy, 65, true)
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranDaedala, 65, true)
        end)
        town:wait_build(1, UnitId.TerranDaedala)
        town:build(1, UnitId.TerranApothecary, 65, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.4,
}
