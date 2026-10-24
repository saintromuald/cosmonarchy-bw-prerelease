local Basic = require "melee.askosi.basic"

---@type AIPersonality
return {
    name = "Temp Default",
    unit_composition = {
        -- ground
        [UnitId.AskosiMissionary] = 1,
        [UnitId.AskosiCardinal] = 1,
        [UnitId.AskosiRove] = 1,
        [UnitId.AskosiObject] = 1,
        [UnitId.AskosiScepter] = 1,
        [UnitId.AskosiIntendent] = 1,
        -- air
        [UnitId.AskosiHelion] = 1,
        [UnitId.AskosiEmissary] = 1,
        [UnitId.AskosiInkblot] = 1,
        [UnitId.AskosiTirade] = 1,
    },
    main_build_order = function(melee_ai, town)
        melee_ai:build_main(town)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.AskosiRadix, 100, true)
        town:build(1, UnitId.AskosiFunction, 100, true)
        melee_ai:dynamic_wait(secs(20))
        town:build(1, UnitId.AskosiCosmoscope, 90, true)
        melee_ai:dynamic_wait(secs(20))
        melee_ai:start_attacking()
        melee_ai:start_expanding()
    end,
    expansion_build_order = function(melee_ai, town)
        melee_ai:build_expansion(town, true)
        town:build(1, UnitId.AskosiRadix, 70, true)
        town:build(1, UnitId.AskosiFunction, 70, true)
        town:build(1, UnitId.AskosiCosmoscope, 70, true)
    end,
    build_anti_ground_defenses = Basic.build_anti_ground,
    build_anti_air_defenses = Basic.build_anti_air,
    attack_wave_cost_bias = 0.5,
}
