
ProfessionFramework = {
    VERSION = "1.00-alpha",
    AUTHOR = "Fenris_Wolf",
    RemoveDefaultProfessions = false,
    RemoveDefaultTraits = false,
    Professions = { }, -- table of registered professions.
    Traits = { }, -- table of registered traits.
    TraitSwaps = { },
    AlwaysUseStartingKits = true,
}

local oldDoTraits = BaseGameCharacterDetails.DoTraits
local oldDoProfessions = BaseGameCharacterDetails.DoProfessions

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

    TraitFactory.addTrait("Brave2", getText("UI_trait_brave"), 0, getText("UI_trait_bravedesc"), true)
    TraitFactory.addTrait("Cowardly2", getText("UI_trait_cowardly"), 0, getText("UI_trait_cowardlydesc"), true)
    TraitFactory.setMutualExclusive("Brave2", "Brave")
    TraitFactory.setMutualExclusive("Brave2", "Cowardly")
    TraitFactory.setMutualExclusive("Cowardly2", "Brave")
    TraitFactory.setMutualExclusive("Cowardly2", "Cowardly")
    ProfessionFramework.TraitSwaps["Brave2"] = "Brave"
    ProfessionFramework.TraitSwaps["Cowardly2"] = "Cowardly"
    
    
    TraitFactory.addTrait("Clumsy2", getText("UI_trait_clumsy"), 0, getText("UI_trait_clumsydesc"), true)
    TraitFactory.addTrait("Graceful2", getText("UI_trait_graceful"), 0, getText("UI_trait_gracefuldesc"), true)
    TraitFactory.setMutualExclusive("Clumsy2", "Graceful")
    TraitFactory.setMutualExclusive("Clumsy2", "Clumsy")
    TraitFactory.setMutualExclusive("Graceful2", "Graceful")
    TraitFactory.setMutualExclusive("Graceful2", "Clumsy")
    ProfessionFramework.TraitSwaps["Clumsy2"] = "Clumsy"
    ProfessionFramework.TraitSwaps["Graceful2"] = "Graceful"


    TraitFactory.addTrait("ShortSighted2", getText("UI_trait_shortsigh"), 0, getText("UI_trait_shortsighdesc"), true)
    TraitFactory.addTrait("EagleEyed2", getText("UI_trait_eagleeyed"), 0, getText("UI_trait_eagleeyeddesc"), true)
    TraitFactory.setMutualExclusive("ShortSighted2", "EagleEyed");
    TraitFactory.setMutualExclusive("ShortSighted2", "ShortSighted");
    TraitFactory.setMutualExclusive("EagleEyed2", "EagleEyed");
    TraitFactory.setMutualExclusive("EagleEyed2", "ShortSighted");
    ProfessionFramework.TraitSwaps["ShortSighted2"] = "ShortSighted"
    ProfessionFramework.TraitSwaps["EagleEyed2"] = "EagleEyed"


    TraitFactory.addTrait("HardOfHearing2", getText("UI_trait_hardhear"), 0, getText("UI_trait_hardheardesc"), true)
    TraitFactory.addTrait("Deaf2", getText("UI_trait_deaf"), 0, getText("UI_trait_deafdesc"), true)
    TraitFactory.addTrait("KeenHearing2", getText("UI_trait_keenhearing"), 0, getText("UI_trait_keenhearingdesc"), true)
    TraitFactory.setMutualExclusive("HardOfHearing2", "KeenHearing")
    TraitFactory.setMutualExclusive("HardOfHearing2", "HardOfHearing")
    TraitFactory.setMutualExclusive("HardOfHearing2", "Deaf")
    TraitFactory.setMutualExclusive("Deaf2", "HardOfHearing")
    TraitFactory.setMutualExclusive("Deaf2", "KeenHearing")
    TraitFactory.setMutualExclusive("Deaf2", "Deaf")
    TraitFactory.setMutualExclusive("KeenHearing2", "KeenHearing")
    TraitFactory.setMutualExclusive("KeenHearing2", "HardOfHearing")
    TraitFactory.setMutualExclusive("KeenHearing2", "Deaf")
    ProfessionFramework.TraitSwaps["HardOfHearing2"] = "HardOfHearing"
    ProfessionFramework.TraitSwaps["Deaf2"] = "Deaf"
    ProfessionFramework.TraitSwaps["KeenHearing2"] = "KeenHearing"


    TraitFactory.addTrait("HeartyAppitite2", getText("UI_trait_heartyappetite"), 0, getText("UI_trait_heartyappetitedesc"), true)
    TraitFactory.addTrait("LightEater2", getText("UI_trait_lighteater"), 0, getText("UI_trait_lighteaterdesc"), true)
    TraitFactory.setMutualExclusive("HeartyAppitite2", "LightEater")
    TraitFactory.setMutualExclusive("HeartyAppitite2", "HeartyAppitite")
    TraitFactory.setMutualExclusive("LightEater2", "LightEater")
    TraitFactory.setMutualExclusive("LightEater2", "HeartyAppitite")
    ProfessionFramework.TraitSwaps["HeartyAppitite2"] = "HeartyAppitite"
    ProfessionFramework.TraitSwaps["LightEater2"] = "LightEater"

    
    TraitFactory.addTrait("ThickSkinned2", getText("UI_trait_thickskinned"), 0, getText("UI_trait_thickskinneddesc"), true)
    TraitFactory.addTrait("Thinskinned2", getText("UI_trait_ThinSkinned"), 0, getText("UI_trait_ThinSkinnedDesc"), true)
    TraitFactory.setMutualExclusive("ThickSkinned2", "Thinskinned")
    TraitFactory.setMutualExclusive("ThickSkinned2", "ThickSkinned")
    TraitFactory.setMutualExclusive("Thinskinned2", "Thinskinned")
    TraitFactory.setMutualExclusive("Thinskinned2", "ThickSkinned")
    ProfessionFramework.TraitSwaps["ThickSkinned2"] = "ThickSkinned"
    ProfessionFramework.TraitSwaps["Thinskinned2"] = "Thinskinned"


    TraitFactory.addTrait("Resilient2", getText("UI_trait_resilient"), 0, getText("UI_trait_resilientdesc"), true)
    TraitFactory.addTrait("ProneToIllness2", getText("UI_trait_pronetoillness"), 0, getText("UI_trait_pronetoillnessdesc"), true)
    TraitFactory.setMutualExclusive("Resilient2", "ProneToIllness")
    TraitFactory.setMutualExclusive("Resilient2", "Resilient")
    TraitFactory.setMutualExclusive("ProneToIllness2", "ProneToIllness")
    TraitFactory.setMutualExclusive("ProneToIllness2", "Resilient")
    ProfessionFramework.TraitSwaps["Resilient2"] = "Resilient"
    ProfessionFramework.TraitSwaps["ProneToIllness2"] = "ProneToIllness"



    TraitFactory.addTrait("Lucky2", getText("UI_trait_lucky"), 0, getText("UI_trait_luckydesc"), true)
    TraitFactory.addTrait("Unlucky2", getText("UI_trait_unlucky"), 0, getText("UI_trait_unluckydesc"), true)
    TraitFactory.setMutualExclusive("Lucky2", "Unlucky")
    TraitFactory.setMutualExclusive("Lucky2", "Lucky")
    TraitFactory.setMutualExclusive("Unlucky2", "Unlucky")
    TraitFactory.setMutualExclusive("Unlucky2", "Lucky")
    ProfessionFramework.TraitSwaps["Lucky2"] = "Lucky"
    ProfessionFramework.TraitSwaps["Unlucky2"] = "Unlucky"


    TraitFactory.addTrait("Dextrous2", getText("UI_trait_Dexterous"), 0, getText("UI_trait_DexterousDesc"), true)
    TraitFactory.addTrait("AllThumbs2", getText("UI_trait_AllThumbs"), 0, getText("UI_trait_AllThumbsDesc"), true)
    TraitFactory.setMutualExclusive("Dextrous2", "Dextrous")
    TraitFactory.setMutualExclusive("Dextrous2", "AllThumbs")
    TraitFactory.setMutualExclusive("AllThumbs2", "Dextrous")
    TraitFactory.setMutualExclusive("AllThumbs2", "AllThumbs")
    ProfessionFramework.TraitSwaps["Dextrous2"] = "Dextrous"
    ProfessionFramework.TraitSwaps["AllThumbs2"] = "AllThumbs"


    TraitFactory.addTrait("FastHealer2", getText("UI_trait_FastHealer"), 0, getText("UI_trait_FastHealerDesc"), true)
    TraitFactory.addTrait("SlowHealer2", getText("UI_trait_SlowHealer"), 0, getText("UI_trait_SlowHealerDesc"), true)
    TraitFactory.setMutualExclusive("FastHealer2", "FastHealer")
    TraitFactory.setMutualExclusive("FastHealer2", "SlowHealer")
    TraitFactory.setMutualExclusive("SlowHealer2", "FastHealer")
    TraitFactory.setMutualExclusive("SlowHealer2", "SlowHealer")
    ProfessionFramework.TraitSwaps["FastHealer2"] = "FastHealer"
    ProfessionFramework.TraitSwaps["SlowHealer2"] = "SlowHealer"

    
    TraitFactory.addTrait("FastLearner2", getText("UI_trait_FastLearner"), 0, getText("UI_trait_FastLearnerDesc"), true)
    TraitFactory.addTrait("SlowLearner2", getText("UI_trait_SlowLearner"), 0, getText("UI_trait_SlowLearnerDesc"), true)
    TraitFactory.setMutualExclusive("FastLearner2", "FastLearner")
    TraitFactory.setMutualExclusive("FastLearner2", "SlowLearner")
    TraitFactory.setMutualExclusive("SlowLearner2", "FastLearner")
    TraitFactory.setMutualExclusive("SlowLearner2", "SlowLearner")
    ProfessionFramework.TraitSwaps["FastLearner2"] = "FastLearner"
    ProfessionFramework.TraitSwaps["SlowLearner2"] = "SlowLearner"


    TraitFactory.addTrait("FastReader2", getText("UI_trait_FastReader"), 0, getText("UI_trait_FastReaderDesc"), true)
    TraitFactory.addTrait("SlowReader2", getText("UI_trait_SlowReader"), 0, getText("UI_trait_SlowReaderDesc"), true)
    TraitFactory.addTrait("Illiterate2", getText("UI_trait_Illiterate"), 0, getText("UI_trait_IlliterateDesc"), true)
    TraitFactory.setMutualExclusive("FastReader2", "SlowReader")
    TraitFactory.setMutualExclusive("FastReader2", "FastReader")
    TraitFactory.setMutualExclusive("FastReader2", "Illiterate")
    TraitFactory.setMutualExclusive("SlowReader2", "SlowReader")
    TraitFactory.setMutualExclusive("SlowReader2", "FastReader")
    TraitFactory.setMutualExclusive("SlowReader2", "Illiterate")
    TraitFactory.setMutualExclusive("Illiterate2", "SlowReader")
    TraitFactory.setMutualExclusive("Illiterate2", "FastReader")
    TraitFactory.setMutualExclusive("Illiterate2", "Illiterate")
    ProfessionFramework.TraitSwaps["FastReader2"] = "FastReader"
    ProfessionFramework.TraitSwaps["SlowReader2"] = "SlowReader"
    ProfessionFramework.TraitSwaps["Illiterate2"] = "Illiterate"


    TraitFactory.addTrait("NeedsLessSleep2", getText("UI_trait_LessSleep"), 0, getText("UI_trait_LessSleepDesc"), true, not sleepOK)
    TraitFactory.addTrait("NeedsMoreSleep2", getText("UI_trait_MoreSleep"), 0, getText("UI_trait_MoreSleepDesc"), true, not sleepOK)
    TraitFactory.setMutualExclusive("NeedsLessSleep2", "NeedsMoreSleep")
    TraitFactory.setMutualExclusive("NeedsLessSleep2", "NeedsLessSleep")
    TraitFactory.setMutualExclusive("NeedsMoreSleep2", "NeedsMoreSleep")
    TraitFactory.setMutualExclusive("NeedsMoreSleep2", "NeedsLessSleep")
    ProfessionFramework.TraitSwaps["NeedsLessSleep2"] = "NeedsLessSleep"
    ProfessionFramework.TraitSwaps["NeedsMoreSleep2"] = "NeedsMoreSleep"


    TraitFactory.addTrait("Inconspicuous2", getText("UI_trait_Inconspicuous"), 0, getText("UI_trait_InconspicuousDesc"), true)
    TraitFactory.addTrait("Conspicuous2", getText("UI_trait_Conspicuous"), 0, getText("UI_trait_ConspicuousDesc"), true)
    TraitFactory.setMutualExclusive("Inconspicuous2", "Inconspicuous")
    TraitFactory.setMutualExclusive("Inconspicuous2", "Conspicuous")
    TraitFactory.setMutualExclusive("Conspicuous2", "Inconspicuous")
    TraitFactory.setMutualExclusive("Conspicuous2", "Conspicuous")
    ProfessionFramework.TraitSwaps["Inconspicuous2"] = "Inconspicuous"
    ProfessionFramework.TraitSwaps["Conspicuous2"] = "Conspicuous"

    
    TraitFactory.addTrait("Organized2", getText("UI_trait_Packmule"), 0, getText("UI_trait_PackmuleDesc"), true)
    TraitFactory.addTrait("Disorganized2", getText("UI_trait_Disorganized"), 0, getText("UI_trait_DisorganizedDesc"), true)
    TraitFactory.setMutualExclusive("Organized2", "Disorganized")
    TraitFactory.setMutualExclusive("Organized2", "Organized")
    TraitFactory.setMutualExclusive("Disorganized2", "Disorganized")
    TraitFactory.setMutualExclusive("Disorganized2", "Organized")
    ProfessionFramework.TraitSwaps["Organized2"] = "Organized"
    ProfessionFramework.TraitSwaps["Disorganized2"] = "Disorganized"


    TraitFactory.addTrait("LowThirst2", getText("UI_trait_LowThirst"), 0, getText("UI_trait_LowThirstDesc"), true)
    TraitFactory.addTrait("HighThirst2", getText("UI_trait_HighThirst"), 0, getText("UI_trait_HighThirstDesc"), true)
    TraitFactory.setMutualExclusive("LowThirst2", "HighThirst")
    TraitFactory.setMutualExclusive("LowThirst2", "LowThirst")
    TraitFactory.setMutualExclusive("HighThirst2", "HighThirst")
    TraitFactory.setMutualExclusive("HighThirst2", "LowThirst")
    ProfessionFramework.TraitSwaps["LowThirst2"] = "LowThirst"
    ProfessionFramework.TraitSwaps["HighThirst2"] = "HighThirst"


    TraitFactory.addTrait("WeakStomach2", getText("UI_trait_WeakStomach"), 0, getText("UI_trait_WeakStomachDesc"), true)
    TraitFactory.addTrait("IronGut2", getText("UI_trait_IronGut"), 0, getText("UI_trait_IronGutDesc"), true)
    TraitFactory.setMutualExclusive("IronGut2", "WeakStomach")
    TraitFactory.setMutualExclusive("IronGut2", "IronGut")
    TraitFactory.setMutualExclusive("WeakStomach2", "WeakStomach")
    TraitFactory.setMutualExclusive("WeakStomach2", "IronGut")
    ProfessionFramework.TraitSwaps["WeakStomach2"] = "WeakStomach"
    ProfessionFramework.TraitSwaps["IronGut2"] = "IronGut"

    
    TraitFactory.addTrait("Outdoorsman2", getText("UI_trait_outdoorsman"), 0, getText("UI_trait_outdoorsmandesc"), true)
    TraitFactory.addTrait("AdrenalineJunkie2", getText("UI_trait_AdrenalineJunkie"), 0, getText("UI_trait_AdrenalineJunkieDesc"), true)
    TraitFactory.addTrait("NightVision2", getText("UI_trait_NightVision"), 0, getText("UI_trait_NightVisionDesc"), true)
    TraitFactory.setMutualExclusive("Outdoorsman2", "Outdoorsman")
    TraitFactory.setMutualExclusive("AdrenalineJunkie2", "AdrenalineJunkie")
    TraitFactory.setMutualExclusive("NightVision2", "NightVision")
    ProfessionFramework.TraitSwaps["Outdoorsman2"] = "Outdoorsman"
    ProfessionFramework.TraitSwaps["AdrenalineJunkie2"] = "AdrenalineJunkie"
    ProfessionFramework.TraitSwaps["NightVision2"] = "NightVision"


    TraitFactory.addTrait("Hypercondriac2", getText("UI_trait_hypochon"), 0, getText("UI_trait_hypochondesc"), true)
    TraitFactory.addTrait("Agoraphobic2", getText("UI_trait_agoraphobic"), 0, getText("UI_trait_agoraphobicdesc"), true)
    TraitFactory.addTrait("Claustophobic2", getText("UI_trait_claustro"), 0, getText("UI_trait_claustrodesc"), true)
    TraitFactory.addTrait("Hemophobic2", getText("UI_trait_Hemophobic"), 0, getText("UI_trait_HemophobicDesc"), true)
    TraitFactory.setMutualExclusive("Hypercondriac2", "Hypercondriac")
    TraitFactory.setMutualExclusive("Agoraphobic2", "Agoraphobic")
    TraitFactory.setMutualExclusive("Claustophobic2", "Claustophobic")
    TraitFactory.setMutualExclusive("Hemophobic2", "Hemophobic")
    ProfessionFramework.TraitSwaps["Hypercondriac2"] = "Hypercondriac"
    ProfessionFramework.TraitSwaps["Agoraphobic2"] = "Agoraphobic"
    ProfessionFramework.TraitSwaps["Claustophobic2"] = "Claustophobic"
    ProfessionFramework.TraitSwaps["Hemophobic2"] = "Hemophobic"



    TraitFactory.addTrait("Insomniac2", getText("UI_trait_Insomniac"), 0, getText("UI_trait_InsomniacDesc"), true, not sleepOK)
    TraitFactory.addTrait("Pacifist2", getText("UI_trait_Pacifist"), 0, getText("UI_trait_PacifistDesc"), true)
    TraitFactory.addTrait("Smoker2", getText("UI_trait_Smoker"), 0, getText("UI_trait_SmokerDesc"), true)
    TraitFactory.addTrait("Asthmatic2", getText("UI_trait_Asthmatic"), 0, getText("UI_trait_AsthmaticDesc"), true)
    TraitFactory.setMutualExclusive("Insomniac2", "Insomniac")
    TraitFactory.setMutualExclusive("Pacifist2", "Pacifist")
    TraitFactory.setMutualExclusive("Smoker2", "Smoker")
    TraitFactory.setMutualExclusive("Asthmatic2", "Asthmatic")
    ProfessionFramework.TraitSwaps["Insomniac2"] = "Insomniac"
    ProfessionFramework.TraitSwaps["Pacifist2"] = "Pacifist"
    ProfessionFramework.TraitSwaps["Smoker2"] = "Smoker"
    ProfessionFramework.TraitSwaps["Asthmatic2"] = "Asthmatic"

    TraitFactory.sortList()

    for trait, _ in pairs(ProfessionFramework.TraitSwaps) do
        BaseGameCharacterDetails.SetTraitDescription(TraitFactory.getTrait(trait))
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
            print("ProfessionFramework: Adjusting Profession: "..ptype)
            this:setName((details.name or this:getName()))
            this:setCost((details.cost or this:getCost()))
            this:setIconPath((details.icon or this:getIconPath()))
        else
            print("ProfessionFramework: Adding Profession: "..ptype)
            this = ProfessionFactory.addProfession(ptype, (details.name or "Unknown"), (details.icon or ""), (details.cost or 0))
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

