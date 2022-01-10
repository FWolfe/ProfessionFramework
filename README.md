# Profession Framework

A mod for Project Zomboid (by **Fenris_Wolf**)

Adds a framework to simply adding additional professions and traits to project zomboid,
and editing the default professions. As well as simplifying the modding process and letting
professions have the 'special' traits (brave, lucky, etc), it also  simplifies the processes
of adding starting gear to various professions/traits.

Be aware this mod adds no new professions or traits itself, it is merely a framework to assist modders.
For maximum compatibility this mod should not included in your own mod, but instead listed as
a requirement in your `mod.info` file.

The advantages of using the Profession Framework vs the vanilla system:

* Cleaner syntax. Professions and traits are defined in a table, instead of potentially writing dozens of function calls.

* All aspects of professions are defined in a single spot (the table), instead of multiple files (initial setup, spawn points, clothing).

* Allows for adding customized starting kits including inventory and items on the ground, for both professions and traits.

The vanilla game files define the Hunter trait and Park Ranger profession as:

```lua
-- trait definition in MainCreationMethods.lua
local hunter = TraitFactory.addTrait("Hunter", getText("UI_trait_Hunter"), 8, getText("UI_trait_HunterDesc"), false);

hunter:addXPBoost(Perks.Aiming, 1)
hunter:addXPBoost(Perks.Trapping, 1)
hunter:addXPBoost(Perks.Sneak, 1)
hunter:addXPBoost(Perks.SmallBlade, 1)
hunter:getFreeRecipes():add("Make Stick Trap");
hunter:getFreeRecipes():add("Make Snare Trap");
hunter:getFreeRecipes():add("Make Wooden Cage Trap");
hunter:getFreeRecipes():add("Make Trap Box");
hunter:getFreeRecipes():add("Make Cage Trap");


-- profession definition in MainCreationMethods.lua
local parkranger = ProfessionFactory.addProfession("parkranger", getText("UI_prof_parkranger"), "profession_parkranger2", -4);
parkranger:addXPBoost(Perks.Trapping, 2)
parkranger:addXPBoost(Perks.Axe, 1)
parkranger:addXPBoost(Perks.PlantScavenging, 2)
parkranger:addXPBoost(Perks.Woodwork, 1)
parkranger:getFreeRecipes():add("Make Stick Trap");
parkranger:getFreeRecipes():add("Make Snare Trap");
parkranger:getFreeRecipes():add("Make Wooden Cage Trap");
parkranger:getFreeRecipes():add("Make Trap Box");
parkranger:getFreeRecipes():add("Make Cage Trap");

-- clothing options in ClothingSelectionDefinitions
ClothingSelectionDefinitions.parkranger = {
	Female = {
		Tshirt = {
			items = {"Base.Tshirt_Profession_RangerBrown", "Base.Tshirt_Profession_RangerGreen"},
		},
        Pants = {
			items = {"Base.Trousers_Ranger"},
		},
	},
}

-- spawn locations in Muldraugh, KY/spawnpoints.lua
-- ... snip ...
    parkranger = {
        {worldX=11+25, worldY=6+25, posX=140, posY=74}, -- Medium House near forest
        {worldX=11+25, worldY=9+25, posX=62, posY=47}, -- Medium house2
        {worldX=11+25, worldY=8+25, posX=116, posY=232}, -- little house2
        {worldX=11+25, worldY=8+25, posX=3, posY=173}, -- little house2
        {worldX=11+25, worldY=8+25, posX=118, posY=229}, -- little house2
        {worldX=11+25, worldY=6+25, posX=142, posY=72},
        {worldX=11+25, worldY=6+25, posX=151, posY=190},
        {worldX=11+25, worldY=6+25, posX=72, posY=189},
        {worldX=11+25, worldY=7+25, posX=176, posY=185},
        {worldX=11+25, worldY=7+25, posX=51, posY=246},
        {worldX=11+25, worldY=7+25, posX=54, posY=294},
        {worldX=11+25, worldY=8+25, posX=108, posY=94},
        {worldX=11+25, worldY=8+25, posX=84, posY=259},
        {worldX=11+25, worldY=8+25, posX=123, posY=196},
    },
-- ... snip ...

-- -- spawn locations in spawnpoints.lua for other maps...
-- ... snip ...

```

Using the Profession Framework, the same information would be defined like:
```lua
-- add the trait
ProfessionFramework.addTrait('Hunter', {
    name = "UI_prof_parkranger",
    description = "UI_trait_HunterDesc",
    cost = 8,
    xp = {
        [Perks.Aiming] = 1,
        [Perks.Trapping] = 1,
        [Perks.Sneak] = 1,
        [Perks.SmallBlade] = 1,
    },
    recipes = {"Make Stick Trap", "Make Snare Trap", "Make Wooden Cage Trap", "Make Trap Box", "Make Cage Trap"},        
})

-- add the profession
ProfessionFramework.addProfession('parkranger', {
    icon = "profession_parkranger2",
    name = "UI_prof_parkranger",
    cost = -4,
    xp = {
        [Perks.Trapping] = 2,
        [Perks.Axe] = 1,
        [Perks.PlantScavenging] = 2,
        [Perks.Woodwork] = 1,
    },
    recipes = {"Make Stick Trap", "Make Snare Trap", "Make Wooden Cage Trap", "Make Trap Box", "Make Cage Trap"},
    clothing = {
        Tshirt = {"Base.Tshirt_Profession_RangerBrown", "Base.Tshirt_Profession_RangerGreen"},
        Pants = {"Base.Trousers_Ranger"},
    }
    spawn = {
        "Muldraugh, KY" = {
            { worldX=11+25, worldY=6+25, posX=140, posY=74 }, -- Medium House near forest
            { worldX=11+25, worldY=9+25, posX=62, posY=47 }, -- Medium house2
            { worldX=11+25, worldY=8+25, posX=116, posY=232 }, -- little house2
            { worldX=11+25, worldY=8+25, posX=3, posY=173 }, -- little house2
            { worldX=11+25, worldY=8+25, posX=118, posY=229 }, -- little house2
            { worldX=11+25, worldY=6+25, posX=142, posY=72 },
            { worldX=11+25, worldY=6+25, posX=151, posY=190 },
            { worldX=11+25, worldY=6+25, posX=72, posY=189 },
            { worldX=11+25, worldY=7+25, posX=176, posY=185 },
            { worldX=11+25, worldY=7+25, posX=51, posY=246 },
            { worldX=11+25, worldY=7+25, posX=54, posY=294 },
            { worldX=11+25, worldY=8+25, posX=108, posY=94 },
            { worldX=11+25, worldY=8+25, posX=84, posY=259 },
            { worldX=11+25, worldY=8+25, posX=123, posY=196 },
        }
        -- -- spawn locations for other maps
        -- ... snip ...
    }
})
```

The above example only shows the basic structure vs the vanilla files, and doesn't make use of any of the Framework's
features. Let's say we want to add some starting gear for these. A hunting rifle if you chose the trait, and some camping
gear for the profession.

```lua
-- we don't actually need to fill out all the information
-- from the above examples, since vanilla already defines them

ProfessionFramework.addTrait('Hunter', {
    -- add a item to the inventory
    inventory = { ["Base.HuntingRifle"] = 1 }
})

ProfessionFramework.addProfession('parkranger', {
    -- these items appear at the player's feet on spawn
    square = {
        ["camping.CampingTentKit"] = 1,
        ["camping.CampfireKit"] = 1,
    }
})

```

The Framework can also be used to easily create new traits with custom effects, as in this 'Nightmares' trait example:
```lua
ProfessionFramework.addTrait('Nightmares', {
    name = "UI_trait_nightmares",
    description = "UI_trait_nightmaresdesc",
    exclude = {"Desensitized"},
    cost = -4,
    requiresSleepEnabled = true,
    inventory = {
        -- starting kit to help get back to sleep
        ["Base.PillsBeta"] = 1,
        ["Base.PillsSleepingTablets"] = 1,
    },
    OnGameStart = function(trait)
        -- add a new event to trigger every ten minutes
        Events.EveryTenMinutes.Add(function()
            local p = getSpecificPlayer(0)
            if p:isAsleep() and ZombRand(100) < 2 then
                p:forceAwake()
                p:getStats():setPanic(90)
            end
        end)
    end
})
```

## Changelog

#### v1.2

* added check to ensure traits exsist before setting mutually exclusive
* added Experimental trait features (needs to be manually enabled with `ProfessionFramework.ExperimentalFeatures`).  
Note these are not fully tested for stability at this time, and modify the character selection UI.

* EXPERIMENTAL: added trait 'requirements', needing another trait or profession to be selected first.
* EXPERIMENTAL: clothing options can be added from traits

#### v1.1

* added `spawn` key to profession tables, for custom spawn locations.
* added `clothing` key to profession tables, for adding/editting character creation clothing options.
* added SundayDriver2, SpeedDemon2, and BaseballPlayer2 as profession traits.
* fixed trait key removeInMP being overwritten by requiresSleepEnabled
* fixed trait key requiresSleepEnabled applying wrong value

* Refactored functions in the client file into the main ProfessionFramework table.
* Rewrote and expanded internal documentation in LDoc syntax
* Included HTML documentation for the API in the `docs` folder.
