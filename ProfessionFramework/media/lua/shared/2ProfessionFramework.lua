
ProfessionFramework = {
    VERSION = "1.00-stable",
    AUTHOR = "Fenris_Wolf",
    Professions = { }, -- table of registered professions.
    Traits = { }, -- table of registered traits.
    RemoveDefaultProfessions = false,
    RemoveDefaultTraits = false,
    AlwaysUseStartingKits = true,
    LogLevel = 2,
    
    -- logging constants
    ERROR = 0,
    WARN = 1,
    INFO = 2,
    DEBUG = 3,
    LogLevelStrings = { [0] = "ERROR", [1] = "WARN", [2] = "INFO", [3] = "DEBUG"},

    log = function(level, text)
        if level > ProfessionFramework.LogLevel then return end
        local prefix = "ProfessionFramework." .. ProfessionFramework.LogLevelStrings[level] .. ": "
        print(prefix .. text)
    end
}

local oldDoTraits = BaseGameCharacterDetails.DoTraits
local oldDoProfessions = BaseGameCharacterDetails.DoProfessions

--[[ ProfessionFramework.addProfession(type, details)

    Registers a profession with the profession framework. arguments are:
    
    type = string name of a profession
    details = a table containing the profession details. Valid key/value pairs are:
        cost = integer value, the number of points this profession starts with.
        xp = a table containing a list of perks, and the experience levels for each.
        traits = a table containing a list of traits this profession starts with.
        recipes = a table containing a list of recipes this profession starts with.
        inventory = a table containing items the profession starts with. Keys are the
            item name, values are the count.
        square =  a table containing items the profession starts with (on the ground). 
            Keys are the item name, values are the count.
        OnNewGame = a function to be called when the character is created. Arguments are
            a IsoPlayer object, a IsoGridSquare object, and the string profession name.
    

]]
ProfessionFramework.addProfession = function(type, details) 
    ProfessionFramework.Professions[type] = details
end


--[[ ProfessionFramework.getProfession(type)

    type = string name of a profession
    
    returns the profession details

]]
ProfessionFramework.getProfession = function(type)
    return ProfessionFramework.Professions[type]
end


--[[ ProfessionFramework.addTrait(type, details)

    Registers a trait with the profession framework. arguments are:

    type = string name of a trait
    details = a table containing the trait details. Valid key/value pairs are:
        cost = integer value, the number of points this trait costs.
        name = string name of the trait (or of the translation entry)
        description = string description of the trait (or of the translation entry)
        xp = a table containing a list of perks, and the experience levels for each.
        removeInMP = true|false. Is this trait only for single player mode
        requiresSleepEnabled = true|false. Sleeping must be enabled in sandbox settings to select.
        profession = true|false. Is this trait a 'profession trait' (non-selectable)
        swap = a string name of another trait to swap this one with OnNewGame. This should only really
            be used for the 'special' traits.
        exclude = a table containing a list of traits this one should be mutually exclusive with.
        add = a table of additional traits to add OnNewGame
        
        inventory = a table containing items this trait starts with. Keys are the
            item name, values are the count.
        square =  a table containing items this trait starts with (on the ground). 
            Keys are the item name, values are the count.
        OnNewGame = a function to be called when the character is created if it has this 
            trait. Arguments are: a IsoPlayer object, a IsoGridSquare object, and the string 
            trait name.
        OnGameStart = function to be triggered OnGameStart if the player has this trait. Arguments are:
            the string trait name.
]]
ProfessionFramework.addTrait = function(type, details)
    ProfessionFramework.Traits[type] = details
end


--[[ ProfessionFramework.getTrait(type)

    type = string name of a trait
    
    returns the trait details

]]
ProfessionFramework.getTrait = function(type)
    return ProfessionFramework.Traits[type]
end


--[[  ProfessionFramework.doTraits()

    Sets up all 'special traits' so they can be used as profession traits. 
    This creates traits such as Brave2, sets the mutually exclusive so a player with brave2 cant 
    select brave or cowardly, and flags brave2 to be replaced with the real brave with the OnNewGame 
    event so it will function properly.
    
    This function is called automatically with the OnGameBoot event.

]]
ProfessionFramework.doTraits = function()
    oldDoTraits()
    local sleepOK = (isClient() or isServer()) and getServerOptions():getBoolean("SleepAllowed") and getServerOptions():getBoolean("SleepNeeded")

    for ttype, details in pairs(ProfessionFramework.Traits) do
        local remove = details.removeInMP or false
        if details.requiresSleepEnabled and not sleepOK then remove = false end
        local this = TraitFactory.getTrait(ttype)
        if this then
            ProfessionFramework.log(ProfessionFramework.INFO, "Adjusting Trait "..ttype)
            
            -- we cant adjust some things on already existing traits, warn if we were asked to
            if details.cost then
                ProfessionFramework.log(ProfessionFramework.WARN, "Cost can not be adjusted for already existing trait "..ttype)
            end
            if details.name then
                ProfessionFramework.log(ProfessionFramework.WARN, "Name can not be adjusted for already existing trait "..ttype)
            end
            if details.description then
                ProfessionFramework.log(ProfessionFramework.WARN, "Description can not be adjusted for already existing trait "..ttype)
            end
            if details.profession then
                ProfessionFramework.log(ProfessionFramework.WARN, "Profession flag can not be adjusted for already existing trait "..ttype)
            end
            
        else
            ProfessionFramework.log(ProfessionFramework.INFO, "Adding Trait "..ttype)
            this = TraitFactory.addTrait(ttype, getText(details.name), (details.cost or 0), getText(details.description), (details.profession or false), remove)
        end
        if details.xp then
            for perk, bonus in pairs(details.xp) do
                this:addXPBoost(perk, bonus)
            end
        end
        if details.recipes then
            -- this:setFreeRecipies(details.recipes)
            local free = this:getFreeRecipes()
            for _, recipe in ipairs(details.recipes) do
                free:add(recipe)
            end
        end
    end
    for ttype, details in pairs(ProfessionFramework.Traits) do
        local exclude = details.exclude or {}
        for _, name in ipairs(exclude) do
            TraitFactory.setMutualExclusive(ttype, name)
        end
    end

    TraitFactory.sortList()

    for ttype, details in pairs(ProfessionFramework.Traits) do
        BaseGameCharacterDetails.SetTraitDescription(TraitFactory.getTrait(ttype))
    end
end


--[[  ProfessionFramework.doProfessions()
    
    Sets up all professions added with the ProfessionFramework.addProfession() function.
    If a profession already exists with the ProfessionFactory (default game professions) it edits the
    values, if not it registers the new profession.
    
    This function is called automatically with the OnGameBoot event.

]]
ProfessionFramework.doProfessions = function()
    if not ProfessionFramework.RemoveDefaultProfessions then oldDoProfessions() end
    for ptype, details in pairs(ProfessionFramework.Professions) do

        local this = ProfessionFactory.getProfession(ptype)
        if this then
            ProfessionFramework.log(ProfessionFramework.INFO, "Adjusting Profession "..ptype)
            this:setName((details.name or this:getName()))
            this:setCost((details.cost or this:getCost()))
            this:setIconPath((details.icon or this:getIconPath()))
        else
            ProfessionFramework.log(ProfessionFramework.INFO, "Adding Profession "..ptype)
            this = ProfessionFactory.addProfession(ptype, (getText(details.name) or "Unknown"), (details.icon or ""), (details.cost or 0))
        end
        -----------
        if details.xp then
            for perk, bonus in pairs(details.xp) do
                this:addXPBoost(perk, bonus)
            end
        end
        if details.traits then
            local current = this:getFreeTraits()
            for _, trait in ipairs(details.traits) do
                if not current:contains(trait) then this:addFreeTrait(trait) end
            end
        end
        if details.recipes then
            -- this:setFreeRecipies(details.recipes)
            local free = this:getFreeRecipes()
            for _, recipe in ipairs(details.recipes) do
                free:add(recipe)
            end
        end
        
        BaseGameCharacterDetails.SetProfessionDescription(this)
    end
end

--[[ ProfessionFramework.addStartingKit(player, square, details)

    Adds starting kits for any profession and traits. This function is called automatically
    OnNewGame.
    
]]
ProfessionFramework.addStartingKit = function(player, square, details)
    local inventory = player:getInventory()
    if SandboxVars.StarterKit or ProfessionFramework.AlwaysUseStartingKits then
        if details.inventory then
            for item, count in pairs(details.inventory) do
                if getScriptManager():FindItem(item) then
                    inventory:AddItems(item, count)
                end
            end
        end
        -- add items to the floor
        if details.square then
            for item, count in pairs(details.square) do
                if getScriptManager():FindItem(item) then
                    for i=1, count do
                        square:AddWorldInventoryItem(item, 0, 0, 0)
                    end
                end
            end
            ISInventoryPage.dirtyUI()
        end
    end
end


-- overwrite the old functions, this is required to when you create a new character on
-- a server after you've died.
-- NOTE: we need to check after all mods have loaded to see if another mod has overwritten
-- this again, for compatibility!
BaseGameCharacterDetails.DoTraits = ProfessionFramework.doTraits
BaseGameCharacterDetails.DoProfessions = ProfessionFramework.doProfessions

-- remove the old functions from the events
Events.OnGameBoot.Remove(oldDoTraits)
Events.OnGameBoot.Remove(oldDoProfessions)

-- add the new functions to events. 
Events.OnGameBoot.Add(ProfessionFramework.doTraits)
Events.OnGameBoot.Add(ProfessionFramework.doProfessions)

