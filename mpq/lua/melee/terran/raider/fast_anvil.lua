local Basic = require "melee.terran.basic"

---@type AIPersonality
return {
    name = "Raider: Fast Anvil",
    unit_composition = {
        -- signature units
        [UnitId.TerranCyprian] = 2,
        [UnitId.TerranEidolon] = 2,
        -- filler units
        [UnitId.TerranMaverick] = 1,
        [UnitId.TerranMadcap] = 1,
        [UnitId.TerranDilettante] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        -- opener
        melee_ai:dynamic_wait(secs(25))
        town:build(1, UnitId.TerranStockade, 110)
        melee_ai:dynamic_wait(secs(40))
        melee_ai:start_expanding()
        -- tier1
        melee_ai:dynamic_wait(secs(25))
        town:build(2, UnitId.TerranStockade, 90)
        melee_ai:dynamic_wait(secs(25))
        town:build(3, UnitId.TerranStockade, 90)
        melee_ai:dynamic_wait(secs(40))
        town:wait_build(3, UnitId.TerranStockade, false)
        melee_ai:dynamic_wait(secs(25))
        town:multirun(function(town)
            town:wait_build(1, UnitId.TerranStockade)
            town:build(1, UnitId.TerranVestry, 89)
            town:wait_build(2, UnitId.TerranStockade)
            town:build(1, UnitId.TerranCovenant, 89)
            town:wait_build(1, UnitId.TerranCovenant, false)
            town:build(1, UnitId.TerranAnvil, 89)
            town:wait_build(3, UnitId.TerranStockade)
            town:wait_build(1, UnitId.TerranAnvil, false)
            town:build(2, UnitId.TerranCovenant, 89)
            town:wait_build(4, UnitId.TerranStockade)
            town:build(3, UnitId.TerranCovenant, 89)
        end)
        melee_ai:dynamic_wait(secs(25))
        -- tier2
        town:build(1, UnitId.TerranAtlas, 70, true)
        melee_ai:dynamic_wait(secs(15))
        town:build(4, UnitId.TerranStockade, 70)
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
        -- production for the Cyprian + Eidolon anvil raid (+ Madcap / Dilettante)
        town:build(1, UnitId.TerranStockade, 70, true)
        town:build(1, UnitId.TerranCovenant, 68, true)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.TerranAnvil, 68, true)
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
