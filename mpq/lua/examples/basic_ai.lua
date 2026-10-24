-- Setup main variables
local player = Player()
if player.type ~= PlayerType.Computer then
    return
end
local ai = AI()
local config = PlayerVars().ai_config or {}

local main_town = ai:start_town()

-- Neat way to organize stuff is to use a table
local brain = {
    saw_air_units = false,
}

---@param town Town
local function flyer_watch(town)
    wait_until(function() return brain.saw_air_units end)
    for i = 1, 5 do
        town:build(i, UnitId.TerranWatchdog, 70-i)
        wait(secs(30 + 5 * i))
    end
end

---@param town Town
local function build_main_town(town)
    town:build(20, UnitId.TerranMason, 90)
    wait(secs(30))
    town:build(1, UnitId.TerranStockade, 100)
    wait(secs(90))
    town:build(2, UnitId.TerranStockade, 90)
    wait(secs(5))
    town:build(3, UnitId.TerranStockade, 70)
    wait(mins(1))
    town:multirun(flyer_watch)
    town:build(4, UnitId.TerranStockade, 70)
end

---@param town Town
local function build_expo(town)
    cprint(TextColor.Orange, "Expanding:")
    print(town)
    town:build(1, UnitId.TerranMinistry, 90)
    town:wait_build(1, UnitId.TerranMinistry)
    town:transfer_workers(4)
    town:build(20, UnitId.TerranMason, 85)
    town:wait_build(10, UnitId.TerranMason)
    town:multirun(flyer_watch)
    town:build(1, UnitId.TerranStockade, 80)
    wait(secs(30))
    town:build(2, UnitId.TerranStockade, 70)
    -- TODO: town:build_at(UnitId.TerranStockage, Point(69, 69), 90)
    -- TODO: town:new_guard(...)
end

local function expand_loop()
    wait(secs(90))
    while true do
        local town = ai:expand()
        town:multirun(build_expo) -- town:multirun manages script lifetime based on town alive state
        if town.is_alive then
            wait(math.random(mins(3), mins(4)))
        else
            wait(math.random(secs(30), mins(1))) -- if town didn't create we wait for shorter
        end

        -- NOTE: if we didn't need the town.is_alive check we can use nice shorthand:
        -- ai:expand:multirun(build_expo)
    end
end

local function attack_waves()
    main_town:wait_build(1, UnitId.TerranStockade)
    while true do
        -- Classic attack wave with counts
        --[[
        local attack = ai:new_attack()
        attack.from = Point(3800, 500)
        if Time.elapsed <= mins(5) then
            attack:add(5 + (Time.elapsed // mins(2)), UnitId.TerranMaverick)
        else
            attack:add(4 + (Time.elapsed // mins(4)), UnitId.TerranMaverick)
            attack:add(2 + (Time.elapsed // mins(4)), UnitId.TerranHarakan)
        end
        ]]

        -- Composing attack wave from power value
        local attack_budget = player:unit_count(UnitId.TerranMason) * 50
            + (player.minerals + player.gas) // 2
        local attack = ai:new_attack(attack_budget)
        attack.budget = attack_budget
        attack.timeout = 120
        -- attack.from = Point(3800, 500)
        if player:unit_count(UnitId.TerranStockade) > 0 then
            attack:compose(config.pref_maverick or 1, UnitId.TerranMaverick)
            attack:compose(config.pref_harakan or 1, UnitId.TerranHarakan)
            attack:compose(config.pref_cyprian or 1, UnitId.TerranCyprian)
        end

        cprint(TextColor.Red, "Sending attack:")
        print(attack)
        attack:send()
        wait(math.random(secs(5), secs(15)))
    end
end

local function dump_defenses()
    cprint(TextColor.Yellow3, "Defenses:")
    print("build.gg:", ai.defense.build.gg)
    print("use.gg:", ai.defense.use.gg)
    print("build.ag:", ai.defense.build.ag)
    print("use.ag:", ai.defense.use.ag)
    print("build.ga:", ai.defense.build.ga)
    print("use.ga:", ai.defense.use.ga)
    print("build.aa:", ai.defense.build.aa)
    print("use.aa:", ai.defense.use.aa)
end

---@param unit_id UnitId
---@param cond fun(): boolean
local function defense_watch_impl(unit_id, cond)
    while true do
        wait_until(cond, secs(1))
        ai.defense:auto_set(unit_id)
        -- dump_defenses()
        wait_while(cond, secs(1))
        ai.defense:auto_remove(unit_id)
        -- dump_defenses()
    end
end

---@param factory_id UnitId
---@param unit_id UnitId
local function defense_watch(factory_id, unit_id)
    defense_watch_impl(unit_id, function()
        return player:unit_count(factory_id) > 0
    end)
end

-- Run all the functions

-- Special kind of multirun, this script will die when town dies
-- Equivalent to `multirun(function(town) town:auto_kill() ... end, town)`
main_town:multirun(build_main_town)
multirun(expand_loop)
multirun(attack_waves)
multirun(defense_watch, UnitId.TerranStockade, UnitId.TerranMaverick)
multirun(defense_watch, UnitId.TerranStockade, UnitId.TerranHarakan)

wait(mins(8))
brain.saw_air_units = true -- let's pretend, since we don't have api for detecting units yet
