---@class Personalities
Personalities = {
    Terran = {
        General = {
            TwoFulcrumMech = require "melee.terran.general.two_fulcrum_mech",
            EarlyRiser = require "melee.terran.general.early_riser",
            TheCube = require "melee.terran.general.the_cube",
            DoublingUp = require "melee.terran.general.doubling_up",
            MechIntoAir = require "melee.terran.general.mech_into_air",
            Observant = require "melee.terran.general.observant",
        },
        Raider = {
            EightRax = require "melee.terran.raider.eight_rax",
            ThreeRaxBio = require "melee.terran.raider.three_rax_bio",
            FastAnvil = require "melee.terran.raider.fast_anvil",
            FourRaxPressure = require "melee.terran.raider.four_rax_pressure",
            Uprising = require "melee.terran.raider.uprising",
            HolyAckmeds = require "melee.terran.raider.holy_ackmeds",
        },
        Armor = {
            TankPush = require "melee.terran.armor.tank_push",
            FeFiveFulc = require "melee.terran.armor.fe_five_fulc",
            TwoFulcVulture = require "melee.terran.armor.two_fulc_vulture",
            WalkerPower = require "melee.terran.armor.walker_power",
            IronCrusade = require "melee.terran.armor.iron_crusade",
            DavidAndGoliath = require "melee.terran.armor.david_and_goliath",
        },
        Orbital = {
            RapidStarpads = require "melee.terran.orbital.rapid_starpads",
            TheDon = require "melee.terran.orbital.the_don",
            WraithBio = require "melee.terran.orbital.wraith_bio",
            Hotdrop = require "melee.terran.orbital.hotdrop",
            SuddenStarport = require "melee.terran.orbital.sudden_starport",
            AcesHigh = require "melee.terran.orbital.aces_high",
        },
    },
    Protoss = {
        General = {
            LunaticLegion = require "melee.protoss.general.lunatic_legion",
            StridentStriders = require "melee.protoss.general.strident_striders",
            Worship = require "melee.protoss.general.worship",
            RoboticsFe = require "melee.protoss.general.robotics_fe",
            TheSwordsmiths = require "melee.protoss.general.the_swordsmiths",
            Matriarchy = require "melee.protoss.general.matriarchy",
        },
        Templar = {
            ThreeGateStrider = require "melee.protoss.templar.three_gate_strider",
            SuffocatingShadow = require "melee.protoss.templar.suffocating_shadow",
            Legion = require "melee.protoss.templar.legion",
            Initiates = require "melee.protoss.templar.initiates",
            Martyrdom = require "melee.protoss.templar.martyrdom",
            LegionsHeralds = require "melee.protoss.templar.legions_heralds",
        },
        Ranger = {
            TwoGateStrider = require "melee.protoss.ranger.two_gate_strider",
            EmissarySquared = require "melee.protoss.ranger.emissary_squared",
            OneGateAuthority = require "melee.protoss.ranger.one_gate_authority",
            LatticeExpo = require "melee.protoss.ranger.lattice_expo",
            SimulantSwarm = require "melee.protoss.ranger.simulant_swarm",
            TheRegistry = require "melee.protoss.ranger.the_registry",
        },
        Skylord = {
            SolarEscort = require "melee.protoss.skylord.solar_escort",
            DeadlyOmen = require "melee.protoss.skylord.deadly_omen",
            TwoGatePanoptus = require "melee.protoss.skylord.two_gate_panoptus",
            Exalted = require "melee.protoss.skylord.exalted",
            SorrowFleet = require "melee.protoss.skylord.sorrow_fleet",
            ShipsAndSwords = require "melee.protoss.skylord.ships_and_swords",
        },
    },
    Zerg = {
        General = {
            SleepingGiant = require "melee.zerg.general.sleeping_giant",
            ShriekingSwarm = require "melee.zerg.general.shrieking_swarm",
            Subjugation = require "melee.zerg.general.subjugation",
            BeforeTheStorm = require "melee.zerg.general.before_the_storm",
            TimeAfterTime = require "melee.zerg.general.time_after_time",
            ConstrainedCoil = require "melee.zerg.general.constrained_coil",
        },
        Swarm = {
            ThreeBaseFlood = require "melee.zerg.swarm.three_base_flood",
            ThreeBaseUltrav = require "melee.zerg.swarm.three_base_ultrav",
            InstantQuazeth = require "melee.zerg.swarm.instant_quazeth",
            ThreeBaseOthstol = require "melee.zerg.swarm.three_base_othstol",
            GatesOfHell = require "melee.zerg.swarm.gates_of_hell",
            PrimitivePressure = require "melee.zerg.swarm.primitive_pressure",
        },
        Assault = {
            ThreeBaseHydrith = require "melee.zerg.assault.three_base_hydrith",
            TwoBaseZorkiz = require "melee.zerg.assault.two_base_zorkiz",
            TwoBaseHydrithQuazeth = require "melee.zerg.assault.two_base_hydrith_quazeth",
            TwoBaseAlkag = require "melee.zerg.assault.two_base_alkag",
            Potency = require "melee.zerg.assault.potency",
            EarthenTides = require "melee.zerg.assault.earthen_tides",
        },
        Sunblot = {
            BigAndLittle = require "melee.zerg.sunblot.big_and_little",
            TheTriad = require "melee.zerg.sunblot.the_triad",
            SkitteringDuo = require "melee.zerg.sunblot.skittering_duo",
            EarlyBirds = require "melee.zerg.sunblot.early_birds",
            FlyingFeint = require "melee.zerg.sunblot.flying_feint",
            DescendingHorizon = require "melee.zerg.sunblot.descending_horizon",
        },
    },
    Askosi = {
        Temp = {
            Default = require "melee.askosi.temp.temp_default",
        },
    },
}

---@class RacePersonalities

---@param race RaceId
---@return RacePersonalities
local function by_race(race)
    if race == RaceId.Terran then
        return Personalities.Terran
    elseif race == RaceId.Zerg then
        return Personalities.Zerg
    elseif race == RaceId.Protoss then
        return Personalities.Protoss
    elseif race == RaceId.Askosi then
        return Personalities.Askosi
    end
    error("Race " .. tostring(race) .. " is not a valid AI race")
end

---@param dict table
---@return AIPersonality
local function pick_random(dict)
    local keys = {}
    for key, _ in pairs(dict) do
        table.insert(keys, key)
    end
    local random_key = keys[math.random(#keys)]
    return dict[random_key]
end

---@param player? Player
---@return AIPersonality
function Personalities.pick_random(player)
    player = player or Player()
    local race = by_race(player.race)
    local category = pick_random(race)
    local personality = pick_random(category)
    return personality
end

return Personalities
