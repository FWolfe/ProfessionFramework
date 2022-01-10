--[[- Simple Framework for adding or modifying Professions and Traits.

All functions and tables can be accessed via the global table named ProfessionFramework.
Generally you will only need to make use of the functions `ProfessionFramework.addProfession` and `ProfessionFramework.addTrait`

## Examples

    -- edit a existing profession, changing skill levels and starting equipment
    ProfessionFramework.addProfession('carpenter', {
        cost = 4, -- was 2
        xp = {
            [Perks.Woodwork] = 4,
        },
        inventory = {
            ["Base.Hammer"] = 2,
            ["Base.Saw"] = 1,
            ["Base.Woodglue"] = 3,
            ["Base.NailsBox"] = 3,
        },
        square = {
            ["Base.Plank"] = 10,
        },
    })


    -- add a new trait that randomly wake up the player in a panic
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

@module ProfessionFramework
@release 1.2
@author Fenris_Wolf
@copyright 2018

]]

ProfessionFramework = { }

--- Constants
-- @section Constants

--- Current version number
ProfessionFramework.VERSION = "1.2-stable"
--- Author/Maintainer
ProfessionFramework.AUTHOR = "Fenris_Wolf"
--- Backwards compatibility mode (build 40)
ProfessionFramework.COMPATIBILITY_MODE = false

--[[- Logging Constants.
These are passed to and checked when making calls to `ProfessionFramework.log`.
@section Logging
]]

--- integer 0
ProfessionFramework.ERROR = 0
--- integer 1
ProfessionFramework.WARN = 1
--- integer 2
ProfessionFramework.INFO = 2
--- integer 3
ProfessionFramework.DEBUG = 3


--[[- Data Tables.
These should not be directly accessed, use function such as `ProfessionFramework.addProfession` and
`ProfessionFramework.getProfession` instead
@section DataTables
]]

--- Table of registered professions
ProfessionFramework.Professions = { }
--- Table of registered traits
ProfessionFramework.Traits = { }


--- Configuration Options
-- @section ConfigOpt

--- Remove all vanilla professions (bool)
ProfessionFramework.RemoveDefaultProfessions = false
--- Remove all vanilla traits (bool)
-- note this flag should not normally be used, as several traits overweight/underweight/etc are essentially required by the game.
-- however required traits can be recreated using the PF if needed.
ProfessionFramework.RemoveDefaultTraits = false
--- Always supply starting kits, false to obey sandbox settings (bool)
ProfessionFramework.AlwaysUseStartingKits = true
--- Logging level verbosity.
ProfessionFramework.LogLevel = 2
--- Experimental Features. Enable at own risk. Expect breakage.
ProfessionFramework.ExperimentalFeatures = false

-- string names for log levels.
ProfessionFramework.LogLevelStrings = { [0] = "ERROR", [1] = "WARN", [2] = "INFO", [3] = "DEBUG"}

-- store original functions.
local oldDoTraits = BaseGameCharacterDetails.DoTraits
local oldDoProfessions = BaseGameCharacterDetails.DoProfessions

--- Functions
-- @section Functions


--[[- Basic logging function.

Prints a message to the console and console.txt log, if ProfessionFramework.LogLevel is equal or less then the level arguement.

@tparam int level logging level constant
@tparam string text text message to log.

@usage ProfessionFramework.log(ProfessionFramework.WARN, "this is a warning log message")

]]
ProfessionFramework.log = function(level, text)
    if level > ProfessionFramework.LogLevel then return end
    local prefix = "ProfessionFramework." .. ProfessionFramework.LogLevelStrings[level] .. ": "
    print(prefix .. text)
end


--[[- Registers a profession with the profession framework.

Defines a profession selectable by the player. Both new custom professions and the default vanilla ones can be defined in
this manor.

When overwriting a vanilla (or pre-existing) profession, not all key/value pairs in the `details` table argument
will be valid as the existing entries will be modified. Vanilla professions **do not** need to be registered with this
function, but won't be able to make use of the ProfessionFramework's features unless they are.

Note no action is taken when this function is called, other then inserting into the `ProfessionFramework.Professions` table.
Any calls to this function need to be done before the `OnGameBoot` event.

@tparam string type name of the profession
@tparam table details a table containing the profession details.

@treturn table the details table passed as a arg

Valid key/value pairs the `details` table are:

* name = string value of a translation key. (default "Unknown")

* cost = integer value, the number of points this profession starts with. (default 0)

* icon = string value, image filename (without extension) to use. (default "")

* xp = a table of perk enum values (keys), and the experience levels for each (values). (default nil)

* traits = a table list of traits this profession starts with. (default nil)

* recipes = a table list of recipes this profession starts with. (default nil)

* inventory = a table of items the profession starts with. Keys are item names, values are the count. (default nil)

* square =  a table of items the profession starts with (on the ground). Keys are item names, values are the count. (default nil)

* spawn = a table of region names (keys), and subtable values of spawn locations. Use of this key will overrides vanilla regions. (default nil)

* clothing = a table of BodyLocations and subtable values of clothing items to enable on the character creation screen. (default nil)  
The clothing table supports several 'special' key/value pairs:  

    * `replace` bool value, completely replaces all vanilla clothing options (default false)  

    * `replace_items` bool value, only replace vanilla options for the BodyLocations specified in this table. (default false)  

    * `Male` clothing subtable for male selection only (default nil)  

    * `Female` clothing subtable for female seleciton only (default nil)  

* OnNewGame = a function to be called when the character is created. (default nil)  
Arguments are a `IsoPlayer` object, a `IsoGridSquare` object, and the `string` profession name.


Note unlike the details table passed to `ProfessionFramework.addTrait`, the profession table does not include a
`description` key. The description's translation string is **automatically generated by PZ**, using a `UI_profdesc﻿_`
prefix such as `UI_prof_unemployed`

]]
ProfessionFramework.addProfession = function(type, details)
    ProfessionFramework.Professions[type] = details
    return details
end


--[[- Returns the details of a registered profession.

@tparam string type The name of the profession

@treturn nil|table the profession details or nil

]]
ProfessionFramework.getProfession = function(type)
    return ProfessionFramework.Professions[type]
end


--[[- Registers a trait with the profession framework.

Defines a trait selectable by the player. Both new custom traits and the default vanilla ones can be defined in
this manor.

When overwriting a vanilla (or pre-existing) trait, not all key/value pairs in the `details` table argument
will be valid as the existing entries will be modified. Vanilla traits **do not** need to be registered with this
function, but won't be able to make use of the ProfessionFramework's features unless they are.

Note no action is taken when this function is called, other then inserting into the `ProfessionFramework.Traits` table.
Any calls to this function need to be done before the `OnGameBoot` event.

@tparam string type name of the trait
@tparam table details a table containing the profession details.

Valid key/value pairs the `details` table are:

* `cost`: (integer) the number of points this trait costs.  
Note: Can not be adjusted for traits already registered with the java TraitFactory.

* `name`: (string) name of the trait (or of the translation entry).  
Note: Can not be adjusted for traits already registered with the java TraitFactory.

* `description`: (string) description of the trait (or of the translation entry).  
Note: Can not be adjusted for traits already registered with the java TraitFactory.

* `removeInMP`: (bool) Is this trait only for single player mode  
Note: Can not be adjusted for traits already registered with the java TraitFactory.

* `requiresSleepEnabled`: (bool) Sleeping must be enabled in sandbox settings to select. (MP only)  
Note: Can not be adjusted for traits already registered with the java TraitFactory.

* `profession`: (bool) Is this trait a 'profession trait' (non-selectable)  
Note: Can not be adjusted for traits already registered with the java TraitFactory.

* `xp`: (table) perk enum values (keys), and the experience levels for each (values).  
Note when using the xp table on a trait already setup with the java TraitFactory this table will not change 
existing xp levels unless they are redefined here.

* `swap`: (string) name of another trait to swap this one with OnNewGame. This trait is removed from the player, and the 
new one added This should only really be used for the 'special' traits.

* `exclude`: (table) list of traits this one should be mutually exclusive with.

* `add`: (table) list of additional traits to add to the player OnNewGame

* `inventory`: (table) containing items this trait starts with. Keys are item names, values are the count.

* `square`: (table) containing items this trait starts with (on the ground). Keys the item names, values are the count.

* `OnNewGame`: (function) a callback executed when the character is created if it has this trait. Arguments are:  
a IsoPlayer object, a IsoGridSquare object, and the string trait name.

* `OnGameStart`: (function) a callback executed OnGameStart if the player has this trait. Arguments are:  
the string trait name.

]]
ProfessionFramework.addTrait = function(type, details)
    ProfessionFramework.Traits[type] = details
end


--[[- Returns the details of a registered trait.

@tparam string type The name of the trait

@treturn nil|table The trait details or nil

]]
ProfessionFramework.getTrait = function(type)
    return ProfessionFramework.Traits[type]
end


--- Automatically Called Functions
-- @section AutoFunctions

--[[-  Adds all registered traits to the java TraitFactory.

This function is called automatically with the `OnGameBoot` event, and overrides the vanilla `BaseGameCharacterDetails.DoTraits`

It calls the original `BaseGameCharacterDetails.DoTraits` before running its custom code unless RemoveDefaultTraits is true.

The overwrite is required to ensure custom traits are still available in MP after player death.

]]
ProfessionFramework.doTraits = function()
    if not ProfessionFramework.RemoveDefaultTraits then oldDoTraits() end


    local sleepOK = (isClient() or isServer()) and getServerOptions():getBoolean("SleepAllowed") and getServerOptions():getBoolean("SleepNeeded")

    for ttype, details in pairs(ProfessionFramework.Traits) do
        local remove = details.removeInMP or false
        if details.requiresSleepEnabled and not sleepOK then remove = true end -- was false? might be safer to check if its MP a start of this IF

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
            if TraitFactory.getTrait(name) then
                TraitFactory.setMutualExclusive(ttype, name)
            else
                ProfessionFramework.log(ProfessionFramework.ERROR, "Trait "..ttype .. "tried to set mutually excludive on non-existant trait ".. name)
            end
        end
    end

    TraitFactory.sortList()

    for ttype, details in pairs(ProfessionFramework.Traits) do
        BaseGameCharacterDetails.SetTraitDescription(TraitFactory.getTrait(ttype))
    end
end


--[[- Adds all registered professions to the java ProfessionFactory.

This function is called automatically with the `OnGameBoot` event, and overrides the vanilla `BaseGameCharacterDetails.DoProfessions`

It calls the original `BaseGameCharacterDetails.DoProfessions` before running its custom code **unless**
`ProfessionFramework.RemoveDefaultProfessions` is `true`. The overwrite is required to ensure custom traits are still
available in MP after player death.

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
            -- TODO: validate!
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

        ------------------------------------------------------------
        ProfessionFramework.addClothes(ptype, details)
        ------------------------------------------------------------
        BaseGameCharacterDetails.SetProfessionDescription(this)
    end
end


--[[- Adds starting kits for any profession and traits.

This function is called automatically by `ProfessionFramework.onNewGame`

@tparam IsoPlayer player
@tparam IsoGridSquare square
@tparam table details

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


-- stupid lua....
local function contains(tbl, value)
    for _,v in ipairs(tbl) do if v == value then return true end end
    return false
end

--[[- Returns a table list of traits that should be restricted.

Note this currently experimental, and requires `ProfessionFramework.ExperimentalFeatures`

@tparam string profession the string name of the profession to check against.
@tparam table current_traits a table list of traits already selected.

@treturn table a table list of traits this character shouldn't have.

]]
ProfessionFramework.getRestrictedTraits = function(profession, current_traits)
    local result = {}
    for trait, details in pairs(ProfessionFramework.Traits) do repeat
        local restrict = false
        if details.profession then break end -- profession traits are restricted by nature.
        if details.restricted and not contains(details.restricted, profession) then restrict = true end
        if details.required then
            for _, req in ipairs(details.required) do
                for t in req:gmatch('([^|]+)') do -- split into potential 'optionals'
                    restrict = true -- set this back to false if we find one
                    if contains(current_traits, t) then -- found it! no need to check other optionals
                         restrict = false
                         break
                    end
                end
                if restrict then break end -- we didnt find our last required item.
                --if not contains(current_traits, req) then restrict = true end
            end
        end

        if restrict then table.insert(result, trait) end
    until true end
    return result
end

--[[- Adds clothes to the character creation screen.

Called automatically by `ProfessionFramework.doProfessions`

@tparam string name
@tparam table details

]]
ProfessionFramework.addClothes = function(name, details)
    ProfessionFramework.log(ProfessionFramework.DEBUG, "Checking clothing for ".. name)
    if not details.clothing or ProfessionFramework.COMPATIBILITY_MODE == true then return end
    local clothing = details.clothing
    local group = BodyLocations.getGroup("Human")
    local defaults
    if clothing.replace then
        defaults = {}
    else
        defaults = ClothingSelectionDefinitions[name] or {} -- get the current table, or make one
    end
    ProfessionFramework.log(ProfessionFramework.DEBUG, "Clothing options found")

    ClothingSelectionDefinitions[name] = defaults -- apply it back, just incase we made a new one

    if clothing.replace then
        ProfessionFramework.log(ProfessionFramework.DEBUG, "Removing default clothing ")
        defaults.Male = nil
        defaults.Female = nil
    end

    if not defaults.Female then defaults.Female = { } end -- TODO: need to make sure this exists, even if we dont add clothes at all!

    -- make a local function to merge tables cleanly.
    local function applyTable(gTable, lTable)
        if gTable == nil or lTable == nil then
            ProfessionFramework.log(ProfessionFramework.DEBUG, "Missing clothing table.")
            return
        end
        for loc, newitems in pairs(lTable) do repeat
            if loc == 'replace' or loc == 'replace_items' or loc == "Male" or loc == "Female" then break end -- already handled.
            if not group:getLocation(loc) then -- invalid location.
                ProfessionFramework.log(ProfessionFramework.WARN, "Invalid clothing location: ".. loc)
                break
            end
            local here = gTable[loc] or {}
            gTable[loc] = here -- apply it back, just incase we made a new one

            if clothing.replace_items and not clothing.replace then
                ProfessionFramework.log(ProfessionFramework.DEBUG, "Replacing clothing table for ".. loc)
                here.items = newitems
            else
                ProfessionFramework.log(ProfessionFramework.DEBUG, "Merging clothing table for ".. loc)
                here.items = here.items or {}
                for _, ni in ipairs(newitems) do
                    if not contains(here.items, ni) then
                        table.insert(here.items, ni)
                    end
                end
            end
            ProfessionFramework.log(ProfessionFramework.DEBUG, "Final clothing table: ".. table.concat(here.items, ", "))
        until true end
    end

    local function applyGender(gender)
        if clothing[gender] then
            --print("applying gender specific " .. gender)
            defaults[gender] = defaults[gender] or { }
            applyTable(defaults[gender], clothing[gender])
        end
        --print("applying global to " .. gender)
        applyTable(defaults[gender], clothing) -- will return if defaults[gender] is nil
    end
    applyGender("Female")
    applyGender("Male")
end

--[[- Injects custom spawn points into the region table.

Called automatically by the `OnSpawnRegionsLoaded` event.

@tparam table regions

]]
ProfessionFramework.onSpawnRegionsLoaded = function(regions)
    for profession, details in pairs(ProfessionFramework.Professions) do
        if details.spawns then
            for _, region in ipairs(regions) do
                if details.spawns[region.name] then
                    ProfessionFramework.log(ProfessionFramework.INFO, "Injecting Custom Spawn Regions for " .. profession .. " in " .. region.name)
                    region.points[profession] = details.spawns[region.name]
                end
            end
        end
    end
end

--[[- Triggered when the player enters the game world.

Called automatically by the `OnGameStart` event hooked in `ProfessionFrameworkClient`.

Runs any custom trait `OnGameStart` callbacks for the player's traits.

]]
ProfessionFramework.onGameStart = function()
    local player = getSpecificPlayer(0)
    for trait, details in pairs(ProfessionFramework.Traits) do
        if player:HasTrait(trait) and details.OnGameStart then
            details.OnGameStart(trait)
        end
    end
end

--[[- Triggered when the player enters the game world for the first time.

Called automatically by the `OnNewGame` event hooked in `ProfessionFrameworkClient`.

Runs any custom `OnNewGame` callbacks and calls `ProfessionFramework.addStartingKit` for the player's chosen traits and
profession. Any traits defined with the `swap` key will be swapped out here.

@tparam IsoPlayer player
@tparam IsoGridSquare square

]]
ProfessionFramework.onNewGame = function(player, square)
    -- handle trait stuff
    for trait, details in pairs(ProfessionFramework.Traits) do repeat
        if not player:HasTrait(trait) then break end

        -- add items to inventory
        ProfessionFramework.addStartingKit(player, square, details)
        if details.swap then
            -- swap out the special traits for real ones
            player:getTraits():remove(trait)
            player:getTraits():add(details.swap)
        end
        if details.add then
            for _, trait in ipairs(details.add) do
                if not player:HasTrait(trait) then player:getTraits():add(trait) end
            end
        end
        if details.OnNewGame then
            -- run any event code
            details.OnNewGame(player, square, trait)
        end
    until true end

    -- handle profession stuff
    local profession = player:getDescriptor():getProfession()

    local details = ProfessionFramework.getProfession(profession)
    if not details then return end
    -- add items to inventory
    ProfessionFramework.addStartingKit(player, square, details)
    -- run any event code
    if details.OnNewGame then
        details.OnNewGame(player, square, profession)
    end
end

-- setup backwards compatibility mode if need
ProfessionFramework.COMPATIBILITY_MODE = not ClothingSelectionDefinitions

-- Inject Custom Spawn Locations for both Client and Server
Events.OnSpawnRegionsLoaded.Add(ProfessionFramework.onSpawnRegionsLoaded)

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
