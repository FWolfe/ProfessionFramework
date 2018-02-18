--[[
    examples of adding or modifying professions.
    This goes in the lua/shared folder

    any of the table key/value pairs may be nil, it is not nessessary to define anything.
    

    
]]

ProfessionFramework.addProfession('sniper', {
    name = "Military Sniper", -- the display name
    icon = "profession_veteran2", -- icon to use
    cost = -4, -- points cost for this profession
    xp = {  -- list of perks and the starting levels
        [Perks.Aiming] = 6,
        [Perks.Reloading] = 4,
        [Perks.Sneak] = 4,
        [Perks.Lightfoot] = 3,
    },
    traits = {"Inconspicuous2", "Graceful2", "Brave2"}, -- traits to add
    recipes = {}, -- no free recipies
    inventory = { -- inventory items to add
        ["ORGM.SR25"] = 1,
        ["ORGM.SR25Mag"] = 2,
        ["ORGM.Ammo_762x51mm_FMJ_Box"] = 3,
    },
    square = {}, -- items to drop on the floor on start
    OnNewGame = function(player, square, profession) end, -- function to run OnNewGame event
})

ProfessionFramework.addProfession('policeofficer', {
    traits = {"Brave2",},
    inventory = {
        ["ORGM.Ber92"] = 1,
        ["ORGM.Ber92Mag"] = 1,
        ["ORGM.Ammo_9x19mm_FMJ_Box"] = 2,
    },
})

ProfessionFramework.addProfession('carpenter', {
    inventory = {
        ["Base.Hammer"] = 1,
        ["Base.Saw"] = 1,
        ["Woodglue"] = 2,
        ["Base.NailsBox"] = 2,
    },
    square = {
        ["Base.Plank"] = 10,
    },
})




--[[
ProfessionFramework.addProfession('unemployed', {
    inventory = {},
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('fireofficer', {
    inventory = {
        ["Base.Axe"] = 1,
    },
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('parkranger', {
    inventory = {
        ["ORGM.LENo4"] = 1,
        ["ORGM.LENo4Mag"] = 2,
    },
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('constructionworker', {
    inventory = {
        ["Base.Sledgehammer"] = 1,
        ["Base.Hammer"] = 1,
        ["Base.NailsBox"]  = 2,
    },
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('securityguard', {
    -- some revolver and flashlight
    inventory = {},
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('burglar', {
    inventory = {},
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('chef', {
    inventory = {},
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('repairman', {
    inventory = {
        ["Base.Screwdriver"] = 1,
        ["Base.Hammer"] = 1,
        ["Base.Glue"] = 2,
        ["Base.DuctTape"] = 2,
    },
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('farmer', {
    inventory = {},
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('fisherman', {
    inventory = {},
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('doctor', {
    inventory = {},
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('veteran', {
    inventory = {},
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('nurse', {
    inventory = {},
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('lumberjack', {
    inventory = {
        ["Base.Axe"] = 1,
    },
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('fitnessInstructor', {
    inventory = {},
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('burgerflipper', {
    inventory = {},
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('electrician', {
    inventory = {
        ["Base.Screwdriver"] = 1,
    },
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('engineer', {
    inventory = {},
    square = {},
    OnNewGame = function(player, square, profession) end,
})
ProfessionFramework.addProfession('metalworker', {
    inventory = {
        ["Base.BallPeenHammer"] = 1,
    },
    square = {},
    OnNewGame = function(player, square, profession) end,
})

]]