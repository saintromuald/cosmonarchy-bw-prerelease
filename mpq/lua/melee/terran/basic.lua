local Basic = {}

---@type BuildOrder
function Basic.build_anti_ground(melee_ai, town)
    melee_ai:build_sequence(town, 1, 2, UnitId.TerranAnchor, 70, 5, secs(25), secs(5))
end

---@type BuildOrder
function Basic.build_anti_air(melee_ai, town)
    melee_ai:build_sequence(town, 1, 4, UnitId.TerranWatchdog, 80, 5, secs(25), secs(5))
end

return Basic
