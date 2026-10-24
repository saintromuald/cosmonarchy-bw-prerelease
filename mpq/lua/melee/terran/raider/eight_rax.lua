local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "Raider: 8Rax",
    unit_composition = {
        -- signature unit
        [UnitId.TerranMaverick] = 3,
        -- healers
        [UnitId.TerranCleric] = 1.5,
        -- filler units
        [UnitId.TerranHarakan] = 1,
        [UnitId.TerranCyprian] = 1,
        [UnitId.TerranMadcap] = 1,
        [UnitId.TerranDilettante] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(15))
        melee_ai:build_and_wait(town, 1, UnitId.TerranStockade, 110, secs(15))
        melee_ai:build_sequence(town, 2, 6, UnitId.TerranStockade, 110, 0, secs(15), 0)
        melee_ai:start_attacking()
        melee_ai:dynamic_wait(secs(15))
        town:wait_build(6, UnitId.TerranStockade, false)
        melee_ai:dynamic_wait(mins(1) + secs(15))
        melee_ai:start_expanding()
        -- tier1 scale-up
        melee_ai:dynamic_wait(secs(40))
        melee_ai:build_and_wait(town, 8, UnitId.TerranStockade, 90, secs(50))
        -- tier2
        town:build(1, UnitId.TerranAtlas, 70, true)
        melee_ai:dynamic_wait(secs(15))
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranStockade)
            town:build(1, UnitId.TerranVestry, 69)
            town:wait_build(2, UnitId.TerranStockade)
            town:build(2, UnitId.TerranVestry, 69)
            town:wait_build(3, UnitId.TerranStockade)
            town:build(1, UnitId.TerranCovenant, 69)
            town:wait_build(4, UnitId.TerranStockade)
            town:build(2, UnitId.TerranCovenant, 69)
        end)
        melee_ai:dynamic_wait(secs(25))
        -- tier3
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranAtlas)
            town:build(1, UnitId.TerranDaedala, 65, true)
        end)
        town:wait_build(1, UnitId.TerranDaedala)
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)

        -- production for the Maverick-heavy raid (+ Cleric / Madcap / Dilettante)
        town:build(1, UnitId.TerranStockade, 70, true)
        town:build(1, UnitId.TerranVestry, 68, true)
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
