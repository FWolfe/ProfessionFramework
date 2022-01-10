--[[- Modifications to the Profession/Trait selection screen.

Modifies various apsects of the selection screen, allowing for traits with requirements (ie: only allowed for specific
professions, or to have other traits selected first).

Please Note this is experimental, and requires `ProfessionFramework.ExperimentalFeatures` to be `true`

@script ProfessionSpecificTraitHandler
@author Fenris_Wolf
@release 1.2
@copyright 2018

]]

local PF = ProfessionFramework

if not PF.ExperimentalFeatures then return end

local oldOnSelectProf = CharacterCreationProfession.onSelectProf
local oldCreate = CharacterCreationProfession.create
local oldAddTrait = CharacterCreationProfession.addTrait
local oldRemoveTrait = CharacterCreationProfession.removeTrait

local NORMAL = 0
local FILTERED = 1
local SELECTED = 2


-- stupid lua....
local function contains(tbl, value)
    for _,v in ipairs(tbl) do if v == value then return true end end
    return false
end

local function copyTable(data, depth)
    depth = depth or 0
    if depth > 100 then return nil end
    local result = {}
    for k, v in pairs(data) do
        if type(v) == 'table' then
            v = copyTable(v, 1 + depth)
        end
        result[k] = v
    end
    return result
end


-- returns a table of currently selected trait names
local function getSelected(self)
    local result = {}
    if not self.listboxTraitSelected then return result end -- for trait clothing hack
    for i,v in ipairs(self.listboxTraitSelected.items) do
        table.insert(result, v.item:getType())
    end
    return result
end


-- check if the trait positive or negative and return the correct listbox
local function goodOrBad(self, trait)
    if not trait:isFree() and trait:getCost() < 0 then return self.listboxBadTrait end
    return self.listboxTrait
end


-- adds a previously filtered trait back into the listbox
local function addFiltered(self, trait)
    PF.log(PF.DEBUG, "Unfiltering ".. trait:getType())
    self.filteredTraits[trait:getType()] = NORMAL

    local list = goodOrBad(self, trait)
    list:addItem(trait:getLabel(), trait)
end


-- removes a filtered trait from the listbox
local function removeFiltered(self, trait)
    PF.log(PF.DEBUG, "Filtering ".. trait:getType())
    self.filteredTraits[trait:getType()] = FILTERED

    local list = goodOrBad(self, trait)
    list:removeItem(trait:getLabel())

    for i,v in ipairs(list.items) do
        if v.item:getType() == trait:getType() then
            PF.log(PF.WARN, "Failed to filter trait. Attempting again. (listbox bug?)")
            list:removeItem(trait:getLabel())
        end
    end
    for i,v in ipairs(list.items) do
        if v.item:getType() == trait:getType() then
            PF.log(PF.ERROR, "Trait failed to remove twice. Not good.")
        end
    end

end


local function isDirty(self, profession)
    local restricted = ProfessionFramework.getRestrictedTraits(profession, getSelected(self))
    for i,v in ipairs(self.listboxTraitSelected.items) do
        if contains(restricted, v.item:getType()) then
            return i
        end
    end
    return nil
end

local function removeSelected(self, profession)
    -- build a list of not allowed traits.
    while true do
        local index = isDirty(self, profession)
        if not index then break end
        self.listboxTraitSelected.selected = index
        local trait = self.listboxTraitSelected.items[index].item
        self.filteredTraits[trait:getType()] = NORMAL -- NOTE: setting FILTERED here may cause doubling?
        self:removeTrait(true) -- dont update list filters yet
    end

    --[[
    local restricted = ProfessionFramework.getRestrictedTraits(profession, getSelected(self))
    -- remove any selected traits that are now restricted. this is messy vanilla code
    for i=self.listboxTraitSelected:size(),1,-1 do
        local trait = self.listboxTraitSelected.items[i].item
        if contains(restricted, trait:getType()) then
            self.listboxTraitSelected.selected = i
            self:removeTrait(true) -- dont update list filters yet
            self.filteredTraits[trait:getType()] = NORMAL -- NOTE: setting FILTERED here may cause doubling?
        end
    end
    ]]
end

local function alphaSort(a, b)
    return a.text < b.text
end
-- filter the traits, both selected and available.
local function filterTraits(self, profession)
    -- build a list of not allowed traits.
    local restricted = PF.getRestrictedTraits(profession, getSelected(self))
    PF.log(PF.DEBUG, "Filtering Traits.....")

    -- add previously filtered stuff back onto the list
    for trait, value in pairs(self.filteredTraits) do
        if value == FILTERED then
            addFiltered(self, TraitFactory.getTrait(trait))
        end
    end

    -- and now remove whatever shouldnt be there
    for _, trait in ipairs(restricted) do
        removeFiltered(self, TraitFactory.getTrait(trait))
    end

    --self.filteredTraits = restricted -- update the list

    -- resort the listboxes
    if ProfessionFramework.ALPHASORT then
        table.sort(self.listboxTrait.items, alphaSort)
        table.sort(self.listboxBadTrait.items, alphaSort)
        --not string.sort(a.text, b.text)
    else
        CharacterCreationMain.sort(self.listboxTrait.items);
        CharacterCreationMain.invertSort(self.listboxBadTrait.items);
    end
end


-- OVERWRITES
function CharacterCreationProfession:create()
    self.filteredTraits = { } -- setup a list of currently filtered traits
    for trait, details in pairs(ProfessionFramework.Traits) do
        self.filteredTraits[trait] = NORMAL
    end
    oldCreate(self)
end

function CharacterCreationProfession:addTrait(bad, nofilter)
    PF.log(PF.DEBUG, "Removing trait nofilter:"..tostring(nofilter))
    oldAddTrait(self, bad)
    if nofilter ~= true then
        filterTraits(self, self.profession:getType())
    end
end

function CharacterCreationProfession:removeTrait(nofilter)
    PF.log(PF.DEBUG, "Removing trait nofilter:"..tostring(nofilter))
    PF.log(PF.DEBUG, "Index is: ".. tostring(self.listboxTraitSelected.selected))
    local trait = self.listboxTraitSelected.items[self.listboxTraitSelected.selected]
    PF.log(PF.DEBUG, "Trait is: "..tostring(trait.text))
    oldRemoveTrait(self)
    removeSelected(self, self.profession:getType())

    if nofilter ~= true then
        filterTraits(self, self.profession:getType())
    end
end

function CharacterCreationProfession:onSelectProf(item)
    local profession = item:getType()
    PF.log(PF.DEBUG, "New Profession selected: ".. profession)
    oldOnSelectProf(self, item)
    removeSelected(self, profession)
    filterTraits(self, profession)
end

if not ProfessionFramework.COMPATIBILITY_MODE then
    local oldDoClothingCombo = CharacterCreationMain.doClothingCombo

    function CharacterCreationMain:doClothingCombo(definition, erasePrevious)
        if not self.clothingPanel then return end
        -- edit definition
        local selected = getSelected(MainScreen.instance.charCreationProfession)
        definition = copyTable(definition)
        for _, trait in ipairs(selected) do repeat
            local details = ProfessionFramework.getTrait(trait)
            if not details or not details.clothing then break end
            for location, clothes in pairs(details.clothing) do
                if definition[location] then
                    for _,c in ipairs(clothes) do
                        local items =  definition[location].items
                        if not contains(items, c) then table.insert(items, c) end
                    end
                else
                    definition[locaiton] = { items = copyTable(clothes) } -- copy so we dont insert and modify original
                end
            end
        until true end

        oldDoClothingCombo(self, definition, erasePrevious)
    end
end
