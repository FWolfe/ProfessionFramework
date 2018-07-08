--[[ Client file for the profession framework mod.
    This handles the special profession trait swaps, adding starter kits, and
    running custom OnNewGame events for each registered profession and trait,
    and OnGameStart events for traits
]]
Events.OnGameStart.Add(function()
    local player = getSpecificPlayer(0)
    for trait, details in pairs(ProfessionFramework.Traits) do
        if player:HasTrait(trait) and details.OnGameStart then
            details.OnGameStart(trait)
        end
    end
end)


Events.OnNewGame.Add(function(player, square)
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
end)
