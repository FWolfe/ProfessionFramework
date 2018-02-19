--[[ Client file for the profession framework mod.
    This handles the special profession trait swaps, adding starter kits, and
    running custom OnNewGame events for each profession.
]]

Events.OnNewGame.Add(function(player, square)
    local profession = player:getDescriptor():getProfession()
    local inventory = player:getInventory()

    -- swap out the special traits for real ones
    for trait, newtrait in pairs(ProfessionFramework.TraitSwaps) do
        if player:HasTrait(trait) then
            player:getTraits():remove(trait)
            player:getTraits():add(newtrait)
        end
    end

    local ptable = ProfessionFramework.getProfession(profession)
    if not ptable then return end
    -- add items to inventory
    if SandboxVars.StarterKit or ProfessionFramework.AlwaysUseStartingKits then
        if ptable.inventory then
            for item, count in pairs(ptable.inventory) do
                if getScriptManager():FindItem(item) then
                    inventory:AddItems(item, count)
                end
            end
        end
        -- add items to the floor
        if ptable.square then
            for item, count in pairs(ptable.square) do
                if getScriptManager():FindItem(item) then
                    for i=1, count do
                        square:AddWorldInventoryItem(item, 0, 0, 0)
                    end
                end
            end
            ISInventoryPage.dirtyUI()
        end
    end
    -- run any event code
    if ptable.OnNewGame then
        ptable.OnNewGame(player, square, profession)
    end
end)
