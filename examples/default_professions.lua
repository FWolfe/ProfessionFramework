--[[- Vanilla professions, reimplemented in Profession Framework style.

Note the data in here is only from BaseGameCharacterDetails.DoProfessions
in MainCreationMethods.lua. Clothing and spawnpoints are not covered here.

This file aims to be compatibile with both build 40 and 41, skill differences
are added at the bottom of this file instead of directly in the addProfession 
call.

Any of these table entries can be retrieved and modified using:

local profession = ProfessionFramework.getProfession(name)

]]

local addProfession = ProfessionFramework.addProfession 
local getProfession = ProfessionFramework.getProfession 

-- set this to true since we skip the vanilla definitions.
ProfessionFramework.RemoveDefaultProfessions = true


addProfession('unemployed', {
    name = "UI_prof_unemployed",
    icon = "",
    cost = 8,
})

addProfession('fireofficer', {
    name = "UI_prof_fireoff",
    icon = "profession_fireofficer2",
    cost = 0,
    xp = {
        [Perks.Sprinting] = 1,
        [Perks.Strength] = 1,
        [Perks.Fitness] = 1,
    },
})

addProfession('policeofficer', {
    name = "UI_prof_policeoff",
    icon = "profession_policeofficer2",
    cost = -4,
    xp = {
        [Perks.Aiming] = 3,
        [Perks.Reloading] = 2,
        [Perks.Nimble] = 1,
    },
})

addProfession('parkranger', {
    name = "UI_prof_parkranger",
    icon = "profession_parkranger2",
    cost = -4,
    xp = {
        [Perks.Trapping] = 2,
        [Perks.PlantScavenging] = 2,
        [Perks.Woodwork] = 1,
    },
    recipes = {"Make Stick Trap", "Make Snare Trap", "Make Wooden Cage Trap", "Make Trap Box", "Make Cage Trap"},
})

addProfession('constructionworker', {
    name = "UI_prof_constructionworker",
    icon = "profession_constructionworker2",
    cost = -2,
    xp = {
        [Perks.SmallBlunt] = 2,
        [Perks.Woodwork] = 1,
    },
})

addProfession('securityguard', {
    name = "UI_prof_securityguard",
    icon = "profession_securityguard2",
    cost = -2,
    xp = {
        [Perks.Sprinting] = 2,
        [Perks.Lightfoot] = 1,
    },
    traits = {"NightOwl"},
})

addProfession('carpenter', {
    name = "UI_prof_Carpenter",
    icon = "profession_hammer2",
    cost = 2,
    xp = {
        [Perks.Woodwork] = 3,
    },
})

addProfession('burglar', {
    name = "UI_prof_Burglar",
    icon = "profession_burglar2",
    cost = -6,
    xp = {
        [Perks.Nimble] = 2,
        [Perks.Sneak] = 2,
        [Perks.Lightfoot] = 2,
    },
})

addProfession('chef', {
    name = "UI_prof_Chef",
    icon = "profession_chef2",
    cost = -4,
    xp = {
        [Perks.Cooking] = 3,
    },
    traits = {"Cook2"},
    recipes = {"Make Cake Batter", "Make Pie Dough", "Make Bread Dough"},
})

addProfession('repairman', {
    name = "UI_prof_Repairman",
    icon = "profession_repairman2",
    cost = -4,
    xp = {
        [Perks.Woodwork] = 1,
    },
})

addProfession('farmer', {
    name = "UI_prof_Farmer",
    icon = "profession_farmer2",
    cost = 2,
    xp = {
        [Perks.Farming] = 3,
    },
    recipes = {"Make Mildew Cure", "Make Flies Cure"},
})

addProfession('fisherman', {
    name = "UI_prof_Fisherman",
    icon = "profession_fisher2",
    cost = -2,
    xp = {
        [Perks.Fishing] = 3,
        [Perks.PlantScavenging] = 1,
    },
    recipes = {"Make Fishing Rod", "Fix Fishing Rod", "Get Wire Back", "Make Fishing Net"},
})

addProfession('doctor', {
    name = "UI_prof_Doctor",
    icon = "profession_doctor2",
    cost = 2,
    xp = {
        [Perks.Doctor] = 3
    },
})

addProfession('veteran', {
    name = "UI_prof_Veteran",
    icon = "profession_veteran2",
    cost = -8,
    xp = {
        [Perks.Aiming] = 2,
        [Perks.Reloading] = 2,
    },
    traits = {"Desensitized" },
})

addProfession('nurse', {
    name = "UI_prof_Nurse",
    icon = "profession_nurse",
    cost = 2,
    xp = {
        [Perks.Doctor] = 2,
        [Perks.Lightfoot] = 1,
    },
})

addProfession('lumberjack', {
    name = "UI_prof_Lumberjack",
    icon = "profession_lumberjack",
    cost = 0,
    xp = {
        [Perks.Axe] = 2,
        [Perks.Strength] = 1,
    },
    traits = {"Axeman"},
})

addProfession('fitnessInstructor', {
    name = "UI_prof_FitnessInstructor",
    icon = "profession_fitnessinstructor",
    cost = -6,
    xp = {
        [Perks.Fitness] = 3,
        [Perks.Sprinting] = 2,
    },
    traits = {"Nutritionist2"},
})

addProfession('burgerflipper', {
    name = "UI_prof_BurgerFlipper",
    icon = "profession_burgerflipper",
    cost = 2,
    xp = {
        [Perks.Cooking] = 2
    },
    traits = { "Cook2" }
})

addProfession('electrician', {
    name = "UI_prof_Electrician",
    icon = "profession_electrician",
    cost = -4,
    xp = {
        [Perks.Electricity] = 3
    },
    recipes = {
        "Generator", "Make Remote Controller V1", "Make Remote Controller V2", "Make Remote Controller V3",
        "Make Remote Trigger", "Make Timer", "Craft Makeshift Radio", "Craft Makeshift HAM Radio", "Craft Makeshift Walkie Talkie"
    }
})

addProfession('engineer', {
    name = "UI_prof_Engineer",
    icon = "profession_engineer",
    cost = -4,
    xp = {
        [Perks.Electricity] = 1,
        [Perks.Woodwork] = 1
    },
    recipes = { "Make Aerosol bomb", "Make Flame bomb", "Make Pipe bomb", "Make Noise generator", "Make Smoke Bomb" }
})

addProfession('metalworker', {
    name = "UI_prof_MetalWorker",
    icon = "profession_metalworker",
    cost = -6,
    xp = {
        [Perks.MetalWelding] = 3
    },
    recipes = { "Make Metal Walls", "Make Metal Fences", "Make Metal Containers", "Make Metal Sheet", "Make Small Metal Sheet", "Make Metal Roof" }
})

addProfession('mechanics', {
    name = "UI_prof_Mechanics",
    icon = "profession_mechanic",
    cost = -4,
    xp = {
        [Perks.Mechanics] = 3        
    },
    traits = { "Mechanics2" },
    recipes = { "Basic Mechanics", "Intermediate Mechanics", "Advanced Mechanics" }
})


if ProfessionFramework.COMPATIBILITY_MODE then 
    -- build 40 only
    getProfession('constructionworker').xp[Perks.Blunt] = 3
    getProfession('chef').xp[Perks.BladeMaintenance] = 1
    getProfession('chef').xp[Perks.Axe] = 1
    getProfession('repairman').xp[Perks.BladeMaintenance] = 2
    getProfession('repairman').xp[Perks.BluntMaintenance] = 2
    getProfession('burgerflipper').xp[Perks.BladeMaintenance] = 1
else
    -- build 41 only
    getProfession('fireofficer').xp[Perks.Axe] = 1
    getProfession('parkranger').xp[Perks.Axe] = 1
    getProfession('constructionworker').xp[Perks.SmallBlunt] = 2
    getProfession('carpenter').xp[Perks.SmallBlunt] = 1
    getProfession('chef').xp[Perks.Maintance] = 1    
    getProfession('chef').xp[Perks.SmallBlade] = 1
    getProfession('repairman').xp[Perks.Maintenance] = 2
    getProfession('repairman').xp[Perks.SmallBlunt] = 1
    getProfession('doctor').xp[Perks.SmallBlade] = 1
    getProfession('burgerflipper').xp[Perks.Maintenance] = 1
    getProfession('burgerflipper').xp[Perks.SmallBlade] = 1
    getProfession('mechanics').xp[Perks.SmallBlunt] = 1
end
