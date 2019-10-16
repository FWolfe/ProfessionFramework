--[[- Vanilla traits, reimplemented in Profession Framework style.

Note the data in here is from BaseGameCharacterDetails.DoTraits
in MainCreationMethods.lua.

Any of these table entries can be retrieved and modified using:

local trait = ProfessionFramework.getTrait(name)

]]

-- skip this file unless UsePFTraitVersions is true 
if not ProfessionFramework.UsePFTraitVersions then return end

local addTrait = ProfessionFramework.addTrait

addTrait("Axeman", {
    name = "UI_trait_axeman",
    description = "UI_trait_axemandesc",
    profession = true,
})

addTrait("Handy", {
    name = "UI_trait_handy",
    description = "UI_trait_handydesc",
    cost = 8,
    xp = {
        ["Perks.Maintenance"] = 1,
        ["Perks.Woodwork"] = 1
    }
})

addTrait("SpeedDemon", {
    name = "UI_trait_SpeedDemon",
    description = "UI_trait_SpeedDemonDesc",
    cost = 1,
    exclude = { "SundayDriver" }
})

addTrait("SundayDriver", {
    name = "UI_trait_SundayDriver",
    description = "UI_trait_SundayDriverDesc",
    cost = -1,
})

addTrait("Brave", {
    name = "UI_trait_brave",
    description = "UI_trait_bravedesc",
    cost = 4,
    exclude = { "Cowardly" }
})

addTrait("Cowardly", {
    name = "UI_trait_cowardly",
    description = "UI_trait_cowardlydesc",
    cost = -2,
})

addTrait("Clumsy", {
    name = "UI_trait_clumsy",
    description = "UI_trait_clumsydesc",
    cost = -2,
    exclude = { "Graceful" },
})

addTrait("Graceful", {
    name = "UI_trait_graceful",
    description = "UI_trait_gracefuldesc",
    cost = 4,
})

addTrait("Hypercondriac", {
    name = "UI_trait_hypochon",
    description = "UI_trait_hypochondesc",
    cost = -2,
})

addTrait("ShortSighted", {
    name = "UI_trait_shortsigh",
    description = "UI_trait_shortsighdesc",
    cost = -2,
    exclude = { "EagleEyed" }
})

addTrait("HardOfHearing", {
    name = "UI_trait_hardhear",
    description = "UI_trait_hardheardesc",
    cost = -2,
    exclude = { "KeenHearing" }
})

addTrait("Deaf", {
    name = "UI_trait_deaf",
    description = "UI_trait_deafdesc",
    cost = -12,
    exclude = { "HardOfHearing", "KeenHearing" }
})

addTrait("KeenHearing", {
    name = "UI_trait_keenhearing",
    description = "UI_trait_keenhearingdesc",
    cost = 6,
})

addTrait("EagleEyed", {
    name = "UI_trait_eagleeyed",
    description = "UI_trait_eagleeyeddesc",
    cost = 6,
})

addTrait("HeartyAppitite", {
    name = "UI_trait_heartyappetite",
    description = "UI_trait_heartyappetitedesc",
    cost = -4,
    exclude = { "LightEater" }
})

addTrait("LightEater", {
    name = "UI_trait_lighteater",
    description = "UI_trait_lighteaterdesc",
    cost = 4,
})

addTrait("ThickSkinned", {
    name = "UI_trait_thickskinned",
    description = "UI_trait_thickskinneddesc",
    cost = -6,
    exclude = { "Thinskinned" }
})

addTrait("Unfit", {
    name = "UI_trait_unfit",
    description = "UI_trait_unfitdesc",
    cost = -10,
    xp = {
        [Perks.Fitness] = -4,
    },
    exclude = { "Out of Shape" }
})

addTrait("Out of Shape", {
    name = "UI_trait_outofshape",
    description = "UI_trait_outofshapedesc",
    cost = -6,
    xp = {
        [Perks.Fitness] = -2,
    }
})

addTrait("Fit", {
    name = "UI_trait_fit",
    description = "UI_trait_fitdesc",
    cost = 6,
    xp = {
        [Perks.Fitness] = 2,
    },
    exclude = { "Out of Shape", "Unfit", "Overweight", "Obese" }
})

addTrait("Athletic", {
    name = "UI_trait_athletic",
    description = "UI_trait_athleticdesc",
    cost = 10,
    xp = {
        [Perks.Fitness] = 4,
    },
    exclude = { "Overweight", "Fit", "Obese", "Out of Shape", "Unfit" }
})

addTrait("Nutritionist", {
    name = "UI_trait_nutritionist",
    description = "UI_trait_nutritionistdesc",
    cost = 4,
    exclude = { "Nutritionist2" }
})

addTrait("Nutritionist2", {
    name = "UI_trait_nutritionist",
    description = "UI_trait_nutritionistdesc",
    profession = true,
})

addTrait("Emaciated", {
    name = "UI_trait_emaciated",
    description = "UI_trait_emaciateddesc",
    cost = -10,
})

addTrait("Very Underweight", {
    name = "UI_trait_veryunderweight",
    description = "UI_trait_veryunderweightdesc",
    cost = -10,
    exclude = { "Underweight" }
})

addTrait("Underweight", {
    name = "UI_trait_underweight",
    description = "UI_trait_underweightdesc",
    cost = -6,
})

addTrait("Overweight", {
    name = "UI_trait_overweight",
    description = "UI_trait_overweightdesc",
    cost = -6,
    exclude = { "Obese", "Underweight" "Very Underweight", "Emaciated" }
})

addTrait("Obese", {
    name = "UI_trait_obese",
    description = "UI_trait_obesedesc",
    cost = -10,
    exclude = { "Underweight", "Very Underweight", "Emaciated" }
})

addTrait("Strong", {
    name = "UI_trait_strong",
    description = "UI_trait_strongdesc",
    cost = 10,
    xp = {
        [Perks.Strength] = 4
    },
    exclude = { "Feeble", "Stout" }
})

addTrait("Stout", {
    name = "UI_trait_stout",
    description = "UI_trait_stoutdesc",
    cost = 6,
    xp = {
        [Perks.Strength] = 2
    },
    exclude = { "Feeble" }
})

addTrait("Weak", {
    name = "UI_trait_weak",
    description = "UI_trait_weakdesc",
    cost = -10,
    xp = {
        [Perks.Strength] = -5
    },
    exclude = { "Strong", "Stout", "Feeble" }
})

addTrait("Feeble", {
    name = "UI_trait_feeble",
    description = "UI_trait_feebledesc",
    cost = -6,
    xp = {
        [Perks.Strength] = -2
    }
})

addTrait("Resilient", {
    name = "UI_trait_resilient",
    description = "UI_trait_resilientdesc",
    cost = 4,
    exclude = { "ProneToIllness" }
})

addTrait("ProneToIllness", {
    name = "UI_trait_pronetoillness",
    description = "UI_trait_pronetoillnessdesc",
    cost = -4,
})

addTrait("Agoraphobic", {
    name = "UI_trait_agoraphobic",
    description = "UI_trait_agoraphobicdesc",
    cost = -4,
})

addTrait("Claustophobic", {
    name = "UI_trait_claustro",
    description = "UI_trait_claustrodesc",
    cost = -4,
})

addTrait("Lucky", {
    name = "UI_trait_lucky",
    description = "UI_trait_luckydesc",
    cost = 4,
    exclude = { "Unlucky" }
})

addTrait("Unlucky", {
    name = "UI_trait_unlucky",
    description = "UI_trait_unluckydesc",
    cost = -4,
})

addTrait("Marksman", {
    name = "UI_trait_marksman",
    description = "UI_trait_marksmandesc",
    profession = true,
})

addTrait("NightOwl", {
    name = "UI_trait_nightowl",
    description = "UI_trait_nightowldesc",
    profession = true,
})

addTrait("FastHealer", {
    name = "UI_trait_FastHealer",
    description = "UI_trait_FastHealerDesc",
    cost = 6,
    exlude = { "SlowHealer" }
})

addTrait("FastLearner", {
    name = "UI_trait_FastLearner",
    description = "UI_trait_FastLearnerDesc",
    cost = 6,
    exlude = { "SlowLearner" }
})

addTrait("FastReader", {
    name = "UI_trait_FastReader",
    description = "UI_trait_FastReaderDesc",
    cost = 2,
    exlude = { "SlowReader" }
})

addTrait("AdrenalineJunkie", {
    name = "UI_trait_AdrenalineJunkie",
    description = "UI_trait_AdrenalineJunkieDesc",
    cost = 8,
})

addTrait("Inconspicuous", {
    name = "UI_trait_Inconspicuous",
    description = "UI_trait_InconspicuousDesc",
    cost = 4,
})

addTrait("NeedsLessSleep", {
    name = "UI_trait_LessSleep",
    description = "UI_trait_LessSleepDesc",
    cost = 2,
    requiresSleepEnabled = true,
    exclude = { "NeedsMoreSleep" }
})

addTrait("Nightvision", {
    name = "UI_trait_NightVision",
    description = "UI_trait_NightVisionDesc",
    cost = 2,
})

addTrait("Organized", {
    name = "UI_trait_Packmule",
    description = "UI_trait_PackmuleDesc",
    cost = 6,
    exclude = { "Disorganized" }
})

addTrait("LowThirst", {
    name = "UI_trait_LowThirst",
    description = "UI_trait_LowThirstDesc",
    cost = 6,
    exclude = { "HighThirst" }
})

addTrait("FirstAid", {
    name = "UI_trait_FirstAid",
    description = "UI_trait_FirstAidDesc",
    cost = 4,
    xp = {
        [Perks.Doctor] = 1
    }
})

addTrait("Fishing", {
    name = "UI_trait_Fishing",
    description = "UI_trait_FishingDesc",
    cost = 4,
    xp = {
        [Perks.Fishing] = 1
    },
    recipes = { "Make Fishing Rod", "Fix Fishing Rod" },
})

addTrait("Gardener", {
    name = "UI_trait_Gardener",
    description = "UI_trait_GardenerDesc",
    cost = 4,
    xp = {
        [Perks.Farming] = 1
    },
    recipes = { "Make Mildew Cure", "Make Flies Cure" },
})

addTrait("Jogger", {
    name = "UI_trait_Jogger",
    description = "UI_trait_JoggerDesc",
    cost = 4,
    xp = {
        [Perks.Sprinting] = 1
    }
})

addTrait("SlowHealer", {
    name = "UI_trait_SlowHealer",
    description = "UI_trait_SlowHealerDesc",
    cost = -6,
})

addTrait("SlowLearner", {
    name = "UI_trait_SlowLearner",
    description = "UI_trait_SlowHealerDesc",
    cost = -6,
})

addTrait("SlowReader", {
    name = "UI_trait_SlowReader",
    description = "UI_trait_SlowReaderDesc",
    cost = -2,
})

addTrait("NeedsMoreSleep", {
    name = "UI_trait_MoreSleep",
    description = "UI_trait_MoreSleepDesc",
    cost = -4,
    requiresSleepEnabled = true,
})

addTrait("Conspicuous", {
    name = "UI_trait_Conspicuous",
    description = "UI_trait_ConspicuousDesc",
    cost = -4,
    exclude = { "Inconspicuous" }
})

addTrait("Disorganized", {
    name = "UI_trait_Disorganized",
    description = "UI_trait_DisorganizedDesc",
    cost = -4,
})

addTrait("HighThirst", {
    name = "UI_trait_HighThirst",
    description = "UI_trait_HighThirstDesc",
    cost = -6,
})

addTrait("Illiterate", {
    name = "UI_trait_Illiterate",
    description = "UI_trait_IlliterateDesc",
    cost = -8,
    exclude = { "SlowReader", "FastReader" }
})

addTrait("Insomniac", {
    name = "UI_trait_Insomniac",
    description = "UI_trait_InsomniacDesc",
    cost = -6,
    requiresSleepEnabled = true,
})

addTrait("Pacifist", {
    name = "UI_trait_Pacifist",
    description = "UI_trait_PacifistDesc",
    cost = -4,
})

addTrait("Thinskinned", {
    name = "UI_trait_ThinSkinned",
    description = "UI_trait_ThinSkinnedDesc",
    cost = -6,
})

addTrait("Smoker", {
    name = "UI_trait_Smoker",
    description = "UI_trait_SmokerDesc",
    cost = -4,
})

addTrait("Dextrous", {
    name = "UI_trait_Dexterous",
    description = "UI_trait_DexterousDesc",
    cost = 2,
    exclude = { "AllThumbs" }
})

addTrait("AllThumbs", {
    name = "UI_trait_AllThumbs",
    description = "UI_trait_AllThumbsDesc",
    cost = -2,
})

addTrait("Desensitized", {
    name = "UI_trait_Desensitized",
    description = "UI_trait_DesensitizedDesc",
    profession = true,
    exclude = { "Hemophobic", "Cowardly", "Brave", "Agoraphobic", "Claustophobic", "AdrenalineJunkie" }
})

addTrait("WeakStomach", {
    name = "UI_trait_WeakStomach",
    description = "UI_trait_WeakStomachDesc",
    cost = -3,
})

addTrait("IronGut", {
    name = "UI_trait_IronGut",
    description = "UI_trait_IronGutDesc",
    cost = 3,
    exclude = { "WeakStomach" }
})

addTrait("Hemophobic", {
    name = "UI_trait_Hemophobic",
    description = "UI_trait_HemophobicDesc",
    cost = -3,
})

addTrait("Asthmatic", {
    name = "UI_trait_Asthmatic",
    description = "UI_trait_AsthmaticDesc",
    cost = -5,
})

addTrait("Cook", {
    name = "UI_trait_Cook",
    description = "UI_trait_CookDesc",
    cost = 6,
    xp = {
        [Perks.Cooking] = 2,
    },
    recipes = { "Make Cake Batter", "Make Pie Dough", "Make Bread Dough" },
    exclude = { "Cook2" }
})

addTrait("Cook2", {
    name = "UI_trait_Cook",
    description = "UI_trait_Cook2Desc",
    profession = true,
})

addTrait("Herbalist", {
    name = "UI_trait_Herbalist",
    description = "UI_trait_HerbalistDesc",
    cost = 6,
    recipes = { "Herbalist" },
})

addTrait("Brawler", {
    name = "UI_trait_BarFighter",
    description = "UI_trait_BarFighterDesc",
    cost = 6,
    xp = {
        [Perks.Axe] = 1,
        [Perks.Blunt] = 1,
    },
})

addTrait("Formerscout", {
    name = "UI_trait_Scout",
    description = "UI_trait_ScoutDesc",
    cost = 6,
    xp = {
        [Perks.Doctor] = 1,
        [Perks.PlantScavenging] = 1,
    },
})

addTrait("BaseballPlayer", {
    name = "UI_trait_PlaysBaseball",
    description = "UI_trait_PlaysBaseballDesc",
    cost = 4,
    xp = {
        [Perks.Blunt] = 1,
    },
})

addTrait("Hiker", {
    name = "UI_trait_Hiker",
    description = "UI_trait_HikerDesc",
    cost = 6,
    xp = {
        [Perks.PlantScavenging] = 1,
        [Perks.Trapping] = 1,
    },
    recipes = { "Make Stick Trap", "Make Snare Trap", "Make Wooden Cage Trap" },
})

addTrait("Hunter", {
    name = "UI_trait_Hunter",
    description = "UI_trait_HunterDesc",
    cost = 8,
    xp = {
        [Perks.Aiming] = 1,
        [Perks.Trapping] = 1,
        [Perks.Sneak] = 1
    },
    recipes = { "Make Stick Trap", "Make Snare Trap", "Make Wooden Cage Trap", "Make Trap Box", "Make Cage Trap" },
})


addTrait("Gymnast", {
    name = "UI_trait_Gymnast",
    description = "UI_trait_GymnastDesc",
    cost = 5,
    xp = {
        [Perks.Lightfoot] = 1,
        [Perks.Nimble] = 1,
    },
})

addTrait("Mechanics", {
    name = "UI_trait_Mechanics",
    description = "UI_trait_MechanicsDesc",
    cost = 5,
    xp = {
        [Perks.Mechanics] = 1,
    },
    recipes = { "Basic Mechanics", "Intermediate Mechanics" },
    exclude = { "Mechanics2" }
})

addTrait("Mechanics2", {
    name = "UI_trait_Mechanics",
    description = "UI_trait_Mechanics2Desc",
    profession = true,
})


if ProfessionFramework.COMPATIBILITY_MODE then 
    -- build 40
    -- nothing to do!
else
    -- build 41+
    getTrait("Hunter").xp[Perks.SmallBlade] = 1
end
