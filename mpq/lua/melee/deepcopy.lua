---@param original any
---@param seen? table
---@return any
function deepcopy(original, seen)
    if type(original) ~= "table" then
        return original
    end

    seen = seen or {}
    if seen[original] then
        return seen[original]
    end

    local copy = {}
    seen[original] = copy
    for key, value in pairs(original) do
        copy[deepcopy(key, seen)] = deepcopy(value, seen)
    end
    return setmetatable(copy, deepcopy(getmetatable(original), seen))
end
