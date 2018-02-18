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
    if ptable.inventory then
        for item, count in pairs(ptable.inventory) do
            inventory:AddItems(item, count)
        end
    end
    -- add items to the floor
    if ptable.square then
        for item, count in pairs(ptable.square) do
            for i=1, count do
                square:AddWorldInventoryItem(item, 0, 0, 0)
            end
        end
        ISInventoryPage.dirtyUI()
    end
    -- run any event code
    if ptable.OnNewGame then
        ptable.OnNewGame(player, square, profession)
    end
end)
