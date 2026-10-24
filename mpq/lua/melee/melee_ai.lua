require "melee.deepcopy"
require "melee.personalities"

---@alias BuildOrder fun(melee_ai: MeleeAI, town: Town)

---@class AIPersonality
---@field name string
---@field unit_composition table<UnitId, number>
---@field main_build_order BuildOrder
---@field expansion_build_order BuildOrder
---@field build_anti_ground_defenses BuildOrder
---@field build_anti_air_defenses BuildOrder
---@field expand_rate? number Default is 3 minutes 30 seconds
---@field expand_wait_after_fail? number Default is 30 seconds
---@field attack_wave_budget_scaling? number Default is 1.0
---@field attack_wave_cost_bias? number Default derived from AI:new_attack()

---@class TownState
---@field started_anti_ground_defenses boolean
---@field started_anti_air_defenses boolean

---@overload fun(personality?: AIPersonality, player?: Player): MeleeAI
---@class MeleeAI
---@field debugging {enabled: boolean, last_tick: number, last_script_id: number}
---@field player Player
---@field personality AIPersonality
---@field ai AI
---@field main_town Town
---@field towns table<Town, TownState>
---@field started_expanding boolean
---@field started_attacking boolean
---@field seen_air_threats boolean
MeleeAI = {}
MeleeAI.__index = MeleeAI

setmetatable(MeleeAI, {
    __call = function(cls, ...)
        return cls.new(...)
    end,
})

---@param personality? AIPersonality
---@param player? Player
---@return MeleeAI melee_ai
function MeleeAI.new(personality, player)
    local self = setmetatable({}, MeleeAI)
    self.player = player or Player()
    if self.player.type ~= PlayerType.Computer then
        return self
    end
    self.debugging = {
        enabled = PlayerVars(self.player).ai_debug or false,
        last_tick = -1,
        last_script_id = -1,
    }
    self.personality = personality or Personalities.pick_random(player)
    self.ai = AI(self.player.id)
    self.main_town = self.ai:start_town()
    self.towns = {
        [self.main_town] = {
            started_anti_ground_defenses = false,
            started_anti_air_defenses = false,
        },
    }
    self.started_expanding = false
    self.started_attacking = false
    self.seen_air_threats = true -- TODO: detect dynamically or after timeout
    -- TODO: maybe have a dynamic unit loss threshold check that triggers a stronger defense response

    self:cdebug(TextColor.White, "Starting AI with personality: " .. self.personality.name)
    return self
end

function MeleeAI:debug_header()
    if self.debugging.last_tick ~= Time.elapsed or self.debugging.last_script_id ~= Script.id then
        self.debugging.last_tick = Time.elapsed
        self.debugging.last_script_id = Script.id
        print()
        cprint(TextColor.Yellow3, "-- " .. tostring(self.player.name) .. " (P" .. tostring(self.player.id) .. "):\n")
    end
end

function MeleeAI:debug(...)
    if self.debugging.enabled then
        self:debug_header()
        print(...)
    end
end

function MeleeAI:cdebug(color, ...)
    if self.debugging.enabled then
        self:debug_header()
        cprint(color, ...)
    end
end

---@protected
---@return table<UnitId, number>
function MeleeAI:get_final_unit_composition()
    local unit_composition = {}
    for unit_id, preference in pairs(self.personality.unit_composition) do
        unit_composition[unit_id] = preference
    end
    return unit_composition
end

function MeleeAI:run()
    if not self.ai then
        return
    end
    for unit_id, preference in pairs(self:get_final_unit_composition()) do
        if preference > 0 then
            multirun(function()
                wait_until(function() return self.player:can_make(unit_id) end, secs(1))
                self:cdebug(TextColor.Teal, "Added " .. UnitId.name(unit_id) .. " to defense")
                self.ai.defense:auto_set(unit_id)
                wait_while(function() return self.player:can_make(unit_id) end, secs(1))
                self:cdebug(TextColor.Teal, "Added " .. UnitId.name(unit_id) .. " to defense")
                self.ai.defense:auto_remove(unit_id)
            end)
        end
    end

    self.main_town:multirun(function(main_town)
        self.personality.main_build_order(self, main_town)
    end)
end

function MeleeAI:start_expanding()
    if self.started_expanding then
        return
    end
    self.started_expanding = true
    multirun(function()
        while true do
            local town = self.ai:expand()
            self:cdebug(TextColor.Green, "Expanding:")
            self:debug(town)
            if town.is_alive then
                self.towns[town] = {
                    started_anti_ground_defenses = false,
                    started_anti_air_defenses = false,
                }
                town:multirun(function()
                    self.personality.expansion_build_order(self, town)
                end)
                wait(self.personality.expand_rate or (mins(3) + secs(30)))
            else
                wait(self.personality.expand_wait_after_fail or secs(30))
            end
        end
    end)
end

function MeleeAI:start_attacking()
    if self.started_attacking then
        return
    end
    self.started_attacking = true
    multirun(function()
        while true do
            local budget = self:town_count() * 500 +
                self.player:unit_count(self:default_worker()) * 50 +
                (self.ai.minerals + self.ai.gas) / 2
            budget = budget * (self.personality.attack_wave_budget_scaling or 1.0)

            local attack = self.ai:new_attack(budget, self.personality.attack_wave_cost_bias or nil)
            for unit_id, preference in pairs(self:get_final_unit_composition()) do
                if preference > 0 and self.player:can_make(unit_id) then
                    attack:compose(preference, unit_id)
                end
            end

            self:cdebug(TextColor.Orange, "Sending attack:")
            self:debug(attack)
            attack:send()
            wait(secs(5))
        end
    end)
end

function MeleeAI:start_anti_ground_defenses(town)
    if self.personality.build_anti_ground_defenses == nil then
        return
    end
    if self.towns[town].started_anti_ground_defenses then
        return
    end
    self.towns[town].started_anti_ground_defenses = true

    multirun(function()
        self.personality.build_anti_ground_defenses(self, town)
    end)
end

function MeleeAI:start_anti_air_defenses(town)
    if self.personality.build_anti_air_defenses == nil then
        return
    end
    if self.towns[town].started_anti_air_defenses then
        return
    end
    self.towns[town].started_anti_air_defenses = true

    multirun(function()
        wait_until(function() return self.seen_air_threats end, secs(1))
        self.personality.build_anti_air_defenses(self, town)
    end)
end

---@return UnitId worker_unit_id
function MeleeAI:default_worker()
    local race = self.player.race
    if race == RaceId.Terran then
        return UnitId.TerranMason
    elseif race == RaceId.Zerg then
        return UnitId.ZergDroleth
    elseif race == RaceId.Protoss then
        return UnitId.ProtossScribe
    elseif race == RaceId.Askosi then
        return UnitId.AskosiPilgrim
    end
    error("Race " .. tostring(race) .. " has no default worker set")
end

---@return UnitId town_building_unit_id
function MeleeAI:default_town_building()
    local race = self.player.race
    if race == RaceId.Terran then
        return UnitId.TerranMinistry
    elseif race == RaceId.Zerg then
        return UnitId.ZergHachirosk
    elseif race == RaceId.Protoss then
        return UnitId.ProtossNexus
    elseif race == RaceId.Askosi then
        return UnitId.AskosiLandlock
    end
    error("Race " .. tostring(race) .. " has no default town set")
end

---@param unit_id UnitId
---@return boolean
function MeleeAI:can_make(unit_id)
    return self.player:can_make(unit_id)
end

---@return number
function MeleeAI:worker_count(town)
    return town:unit_count(self:default_worker(), true)
end

---@return number
function MeleeAI:total_worker_count()
    return self.player:unit_count(self:default_worker(), true)
end

---@return number
function MeleeAI:town_count()
    local count = 0
    for town, _ in pairs(self.towns) do
        if town.is_alive and town:unit_count(self:default_town_building(), true) > 0 then
            count = count + 1
        end
    end
    return count
end

---@param duration integer
function MeleeAI:dynamic_wait(duration)
    local elapsed = 0
    while elapsed < duration do
        local chunk = math.min(secs(2), duration - elapsed)
        local resources = self.ai.minerals + self.ai.gas
        local resource_scale = math.max(0, math.min(1, (1100 - resources) / 600))
        local scaled_chunk = math.floor(chunk * resource_scale)
        if scaled_chunk > 0 then
            wait(scaled_chunk)
        end
        elapsed = elapsed + chunk
    end
end

---@param unit_id UnitId
function MeleeAI:wait_can_make(unit_id)
    wait_until(function()
        return self.player:can_make(unit_id)
    end, secs(1))
end

---@param town Town
---@param count number
function MeleeAI:wait_worker_count(town, count)
    wait_until(function()
        return self:worker_count(town) >= count
    end, secs(1))
end

---@param count number
function MeleeAI:wait_total_worker_count(count)
    wait_until(function()
        return self:total_worker_count() >= count
    end, secs(1))
end

---@param count number
function MeleeAI:wait_town_count(count)
    wait_until(function()
        return self:town_count() >= count
    end, secs(1))
end

---@param town Town
---@param ... BuildOrder
function MeleeAI:pick_random(town, ...)
    local builds = {...}
    builds[math.random(#builds)](self, town)
end

---@param town Town
function MeleeAI:build_main(town)
    town:build(1, self:default_town_building(), 120)
    town:build(town.max_workers, self:default_worker(), 100)
end

---@param town Town
---@param wait_for_workers boolean
function MeleeAI:build_expansion(town, wait_for_workers)
    town:build(1, self:default_town_building(), 120)
    town:wait_build(1, self:default_town_building())
    town:build(town.max_workers, self:default_worker(), 100)
    town:transfer_workers(8)
    if wait_for_workers then
        town:wait_build(10, self:default_worker())
    end
end

---@param town Town
---@param count integer
---@param unit_id UnitId
---@param priority integer
---@param wait? integer
function MeleeAI:build_and_wait(town, count, unit_id, priority, wait)
    town:build(count, unit_id, priority)
    town:wait_build(count, unit_id, false)
    if wait then
        self:dynamic_wait(wait)
    end
end

---@param town Town
---@param start integer
---@param end_ integer
---@param unit_id UnitId
---@param priority integer
---@param priority_decrease integer
---@param wait integer
---@param wait_increase integer
function MeleeAI:build_sequence(town, start, end_, unit_id, priority, priority_decrease, wait, wait_increase)
    for i = start, end_ do
        town:build(i, unit_id, priority - priority_decrease * (i - 1))
        town:wait_build(i, unit_id, false)
        if wait and i ~= end_ then
            self:dynamic_wait(wait + wait_increase * (i - 1))
        end
    end
end
