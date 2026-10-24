local Basic = {}

---@type BuildOrder
function Basic.build_anti_ground(melee_ai, town)
    melee_ai:build_sequence(town, 1, 3, UnitId.ZergSurkithCesiant, 80, 5, secs(25), secs(5))
    melee_ai:wait_can_make(UnitId.ZergSkortrithCesiant)
    melee_ai:build_sequence(town, 1, 3, UnitId.ZergSkortrithCesiant, 80, 5, secs(25), secs(5))
end

---@type BuildOrder
function Basic.build_anti_air(melee_ai, town)
    melee_ai:build_sequence(town, 1, 3, UnitId.ZergSpraithCesiant, 80, 5, secs(25), secs(5))
    melee_ai:wait_can_make(UnitId.ZergSpirtithCesiant)
    melee_ai:build_sequence(town, 1, 3, UnitId.ZergSpirtithCesiant, 80, 5, secs(25), secs(5))
end

return Basic
