local oldOnSelectProf = CharacterCreationProfession.onSelectProf
local oldCreate = CharacterCreationProfession.create
local oldAddTrait = CharacterCreationProfession.addTrait
local oldRemoveTrait = CharacterCreationProfession.removeTrait

-- stupid lua....
local function contains(tbl, value)
    for _,v in ipairs(tbl) do if v == value then return true end end
    return false
end


local function isSelected(self, trait)
    for i,v in ipairs(self.listboxTraitSelected.items) do
        if v.item:getType() == trait then
            return i
        end
    end
end

-- returns the list of traits this profession cant have
local function getRestricted(self, profession)
    local result = {}
    for trait, details in pairs(ProfessionFramework.Traits) do repeat
        if details.profession then break end

        local remove = false
        if details.restricted and not contains(details.restricted, profession) then remove = true end
        if details.required then
            for _, req in ipairs(details.required) do
                if not isSelected(self, req) then remove = true end
            end
        end
        
        if remove then table.insert(result, trait) end
    until true end
    return result
end



-- check if the trait positive or negative and return the correct listbox
local function goodOrBad(self, trait)
    if not trait:isFree() and trait:getCost() < 0 then return self.listboxBadTrait end
    return self.listboxTrait
end


-- adds a previously filtered trait back into the listbox
local function addFiltered(self, trait)
    local list = goodOrBad(self, trait)  
    list:addItem(trait:getLabel(), trait)
end


-- removes a filtered trait from the listbox
local function removeFiltered(self, trait)
    local list = goodOrBad(self, trait)
    list:removeItem(trait:getLabel())
end


-- filter the traits, both selected and available.
local function filterTraits(self, profession)
    -- build a list of not allowed traits.
    local restricted = getRestricted(self, profession)
    
    -- remove any selected traits that are now restricted. this is messy vanilla code
    for i=self.listboxTraitSelected:size(),1,-1 do
        local trait = self.listboxTraitSelected.items[i].item
        if contains(restricted, trait:getType()) then
            self.listboxTraitSelected.selected = i
            self:removeTrait()
        end
    end

    -- add previously filtered stuff back onto the list
    for _, trait in ipairs(self.filteredTraits) do
        addFiltered(self, TraitFactory.getTrait(trait))
    end

    -- and no remove whatever shouldnt be there
    for _, trait in ipairs(restricted) do
        removeFiltered(self, TraitFactory.getTrait(trait))
    end

    self.filteredTraits = restricted -- update the list

    -- resort the listboxes
    CharacterCreationMain.sort(self.listboxTrait.items);
    CharacterCreationMain.invertSort(self.listboxBadTrait.items);
end 

function CharacterCreationProfession:onSelectProf(item)
    ProfessionFramework.log(ProfessionFramework.INFO, "New Profession selected")
    oldOnSelectProf(self, item)
    filterTraits(self, item:getType())
end

function CharacterCreationProfession:create()
    self.filteredTraits = {}
    oldCreate(self)
end

function CharacterCreationProfession:addTrait(bad)
    oldAddTrait(self, bad)
    filterTraits(self, self.profession:getType())
end
function CharacterCreationProfession:removeTrait()
    oldRemoveTrait(self)
    filterTraits(self, self.profession:getType())
end

