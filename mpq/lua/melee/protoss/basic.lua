local Basic = {}

---@type BuildOrder
function Basic.build_anti_ground(melee_ai, town)
    melee_ai:build_sequence(town, 1, 4, UnitId.ProtossWarden, 70, 5, secs(25), secs(5))
end

---@type BuildOrder
function Basic.build_anti_air(melee_ai, town)
    melee_ai:build_sequence(town, 1, 3, UnitId.ProtossMatrix, 80, 5, secs(25), secs(5))
end

return Basic
