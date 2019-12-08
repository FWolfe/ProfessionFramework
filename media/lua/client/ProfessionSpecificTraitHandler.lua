local oldOnSelectProf = CharacterCreationProfession.onSelectProf

-- stupid lua....
local function contains(tbl, value)
    for _,v in ipairs(tbl) do if v == value then return true end end
    return false
end


-- checks if a profession is allowed to have a specific trait
local function isAllowed(trait, profession)
    local details = ProfessionFramework.getTrait(trait)
    if not details then return true end -- unknown trait
    if not details.restricted then return true end -- no restrictions
    return contains(details.restricted, profession)
end


-- returns the list of traits this profession cant have
local function getRestricted(profession)
    local restricted = {}
    for trait, details in pairs(ProfessionFramework.Traits) do repeat
        if details.profession then break end
        if isAllowed(trait, profession) then break end -- skip to next trait
        table.insert(restricted, trait)
    until true end
    return restricted
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
    local restricted = getRestricted(profession)
    
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
    for _, trait in ipairs(restricted) do repeat
        removeFiltered(self, TraitFactory.getTrait(trait))
    until true end

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
end