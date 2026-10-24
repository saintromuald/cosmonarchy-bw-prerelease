require "melee.melee_ai"

local eight_rax_harakan = deepcopy(Personalities.Terran.Raider.EightRax)
eight_rax_harakan.unit_composition[UnitId.TerranHarakan] = 3

MeleeAI(eight_rax_harakan):run()
