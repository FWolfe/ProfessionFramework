--[[- Enables all *special* traits as profession traits.

Many traits such as Brave, Lucky, Speed Demon, etc have effects that are hardcoded in various places through PZ's lua
and java files, and normal methods of making "Profession versions" (can't be picked and cost 0 points) will not properly work,
as the trait name will not match.

This script solves the problem by using the `swap` flag on the profession version of the trait, thus replacing it with
the normal non-profession version when the character is made. This way traits with hardcoded effects function normally.

All these profession traits have identical names to the non-profession version, but prefixed with a '2' (ie: Brave2,
SpeedDemon2, etc)

@script 3ProfessionTraits
@author Fenris_Wolf
@release 1.2
@copyright 2018

]]

local addTrait = ProfessionFramework.addTrait

addTrait("SpeedDemon2", {
    name = "UI_trait_SpeedDemon",
    description = "UI_trait_SpeedDemonDesc",
    profession = true,
    exclude = {"SpeedDemon", "SundayDriver"},
    swap = "SpeedDemon",
})
addTrait("SundayDriver2", {
    name = "UI_trait_SundayDriver",
    description = "UI_trait_SundayDriverDesc",
    profession = true,
    exclude = {"SpeedDemon", "SundayDriver"},
    swap = "SundayDriver",
})

addTrait("BaseballPlayer2", {
    name = "UI_trait_PlaysBaseball",
    description = "UI_trait_PlaysBaseballDesc",
    profession = true,
    exclude = {"BaseballPlayer"},
    swap = "BaseballPlayer",
})


addTrait("Brave2", {
    name = "UI_trait_brave",
    description = "UI_trait_bravedesc",
    profession = true,
    exclude = {"Brave", "Cowardly"},
    swap = "Brave",
})

addTrait("Cowardly2", {
    name = "UI_trait_cowardly",
    description = "UI_trait_cowardlydesc",
    profession = true,
    exclude = {"Brave", "Cowardly"},
    swap = "Cowardly",
})

addTrait("Clumsy2", {
    name = "UI_trait_clumsy",
    description = "UI_trait_clumsydesc",
    profession = true,
    exclude = {"Graceful", "Clumsy"},
    swap = "Clumsy",
})

addTrait("Graceful2", {
    name = "UI_trait_graceful",
    description = "UI_trait_gracefuldesc",
    profession = true,
    exclude = {"Graceful", "Clumsy"},
    swap = "Graceful",
})

addTrait("ShortSighted2", {
    name = "UI_trait_shortsigh",
    description = "UI_trait_shortsighdesc",
    profession = true,
    exclude = {"EagleEyed", "ShortSighted"},
    swap = "ShortSighted",
})

addTrait("EagleEyed2", {
    name = "UI_trait_eagleeyed",
    description = "UI_trait_eagleeyeddesc",
    profession = true,
    exclude = {"EagleEyed", "ShortSighted"},
    swap = "EagleEyed",
})

addTrait("HardOfHearing2", {
    name = "UI_trait_hardhear",
    description = "UI_trait_hardheardesc",
    profession = true,
    exclude = {"KeenHearing", "HardOfHearing", "Deaf"},
    swap = "HardOfHearing",
})

addTrait("Deaf2", {
    name = "UI_trait_deaf",
    description = "UI_trait_deafdesc",
    profession = true,
    exclude = {"HardOfHearing", "KeenHearing", "Deaf"},
    swap = "Deaf",
})

addTrait("KeenHearing2", {
    name = "UI_trait_keenhearing",
    description = "UI_trait_keenhearingdesc",
    profession = true,
    exclude = {"KeenHearing", "HardOfHearing", "Deaf"},
    swap = "KeenHearing",
})

addTrait("HeartyAppitite2", {
    name = "UI_trait_heartyappetite",
    description = "UI_trait_heartyappetitedesc",
    profession = true,
    exclude = {"LightEater", "HeartyAppitite"},
    swap = "HeartyAppitite",
})

addTrait("LightEater2", {
    name = "UI_trait_lighteater",
    description = "UI_trait_lighteaterdesc",
    profession = true,
    exclude = {"LightEater", "HeartyAppitite"},
    swap = "LightEater",
})

addTrait("ThickSkinned2", {
    name = "UI_trait_thickskinned",
    description = "UI_trait_thickskinneddesc",
    profession = true,
    exclude = {"Thinskinned", "ThickSkinned"},
    swap = "ThickSkinned",
})

addTrait("Thinskinned2", {
    name = "UI_trait_ThinSkinned",
    description = "UI_trait_ThinSkinnedDesc",
    profession = true,
    exclude = {"Thinskinned", "ThickSkinned"},
    swap = "Thinskinned",
})

addTrait("Resilient2", {
    name = "UI_trait_resilient",
    description = "UI_trait_resilientdesc",
    profession = true,
    exclude = {"ProneToIllness", "Resilient"},
    swap = "Resilient",
})

addTrait("ProneToIllness2", {
    name = "UI_trait_pronetoillness",
    description = "UI_trait_pronetoillnessdesc",
    profession = true,
    exclude = {"ProneToIllness", "Resilient"},
    swap = "ProneToIllness",
})

addTrait("Lucky2", {
    name = "UI_trait_lucky",
    description = "UI_trait_luckydesc",
    profession = true,
    exclude = {"Unlucky", "Lucky"},
    swap = "Lucky",
})

addTrait("Unlucky2", {
    name = "UI_trait_unlucky",
    description = "UI_trait_unluckydesc",
    profession = true,
    exclude = {"Unlucky", "Lucky"},
    swap = "Unlucky",
})

addTrait("Dextrous2", {
    name = "UI_trait_Dexterous",
    description = "UI_trait_DexterousDesc",
    profession = true,
    exclude = {"Dextrous", "AllThumbs"},
    swap = "Dextrous",
})

addTrait("AllThumbs2", {
    name = "UI_trait_AllThumbs",
    description = "UI_trait_AllThumbsDesc",
    profession = true,
    exclude = {"Dextrous", "AllThumbs"},
    swap = "AllThumbs",
})

addTrait("FastHealer2", {
    name = "UI_trait_FastHealer",
    description = "UI_trait_FastHealerDesc",
    profession = true,
    exclude = {"FastHealer", "SlowHealer"},
    swap = "FastHealer",
})

addTrait("SlowHealer2", {
    name = "UI_trait_SlowHealer",
    description = "UI_trait_SlowHealerDesc",
    profession = true,
    exclude = {"FastHealer", "SlowHealer"},
    swap = "SlowHealer",
})

addTrait("FastLearner2", {
    name = "UI_trait_FastLearner",
    description = "UI_trait_FastLearnerDesc",
    profession = true,
    exclude = {"FastLearner", "SlowLearner"},
    swap = "FastLearner",
})

addTrait("SlowLearner2", {
    name = "UI_trait_SlowLearner",
    description = "UI_trait_SlowLearnerDesc",
    profession = true,
    exclude = {"FastLearner", "SlowLearner"},
    swap = "SlowLearner",
})

addTrait("FastReader2", {
    name = "UI_trait_FastReader",
    description = "UI_trait_FastReaderDesc",
    profession = true,
    exclude = {"SlowReader", "FastReader", "Illiterate"},
    swap = "FastReader",
})

addTrait("SlowReader2", {
    name = "UI_trait_SlowReader",
    description = "UI_trait_SlowReaderDesc",
    profession = true,
    exclude = {"SlowReader", "FastReader", "Illiterate"},
    swap = "SlowReader",
})

addTrait("Illiterate2", {
    name = "UI_trait_Illiterate",
    description = "UI_trait_IlliterateDesc",
    profession = true,
    exclude = {"SlowReader", "FastReader", "Illiterate"},
    swap = "Illiterate",
})

addTrait("NeedsLessSleep2", {
    name = "UI_trait_LessSleep",
    description = "UI_trait_LessSleepDesc",
    profession = true,
    exclude = {"NeedsMoreSleep", "NeedsLessSleep"},
    swap = "NeedsLessSleep",
    requiresSleepEnabled = true,
})

addTrait("NeedsMoreSleep2", {
    name = "UI_trait_MoreSleep",
    description = "UI_trait_MoreSleepDesc",
    profession = true,
    exclude = {"NeedsMoreSleep", "NeedsLessSleep"},
    swap = "NeedsMoreSleep",
    requiresSleepEnabled = true,
})

addTrait("Inconspicuous2", {
    name = "UI_trait_Inconspicuous",
    description = "UI_trait_InconspicuousDesc",
    profession = true,
    exclude = {"Inconspicuous", "Conspicuous"},
    swap = "Inconspicuous",
})

addTrait("Conspicuous2", {
    name = "UI_trait_Conspicuous",
    description = "UI_trait_ConspicuousDesc",
    profession = true,
    exclude = {"Inconspicuous", "Conspicuous"},
    swap = "Conspicuous",
})

addTrait("Organized2", {
    name = "UI_trait_Packmule",
    description = "UI_trait_PackmuleDesc",
    profession = true,
    exclude = {"Disorganized", "Organized"},
    swap = "Organized",
})

addTrait("Disorganized2", {
    name = "UI_trait_Disorganized",
    description = "UI_trait_DisorganizedDesc",
    profession = true,
    exclude = {"Disorganized", "Organized"},
    swap = "Disorganized",
})

addTrait("LowThirst2", {
    name = "UI_trait_LowThirst",
    description = "UI_trait_LowThirstDesc",
    profession = true,
    exclude = {"HighThirst", "LowThirst"},
    swap = "LowThirst",
})

addTrait("HighThirst2", {
    name = "UI_trait_HighThirst",
    description = "UI_trait_HighThirstDesc",
    profession = true,
    exclude = {"HighThirst", "LowThirst"},
    swap = "HighThirst",
})

addTrait("WeakStomach2", {
    name = "UI_trait_WeakStomach",
    description = "UI_trait_WeakStomachDesc",
    profession = true,
    exclude = {"WeakStomach", "IronGut"},
    swap = "WeakStomach",
})

addTrait("IronGut2", {
    name = "UI_trait_IronGut",
    description = "UI_trait_IronGutDesc",
    profession = true,
    exclude = {"WeakStomach", "IronGut"},
    swap = "IronGut",
})

addTrait("Outdoorsman2", {
    name = "UI_trait_outdoorsman",
    description = "UI_trait_outdoorsmandesc",
    profession = true,
    exclude = {"Outdoorsman"},
    swap = "Outdoorsman",
})

addTrait("AdrenalineJunkie2", {
    name = "UI_trait_AdrenalineJunkie",
    description = "UI_trait_AdrenalineJunkieDesc",
    profession = true,
    exclude = {"AdrenalineJunkie"},
    swap = "AdrenalineJunkie",
})

addTrait("NightVision2", {
    name = "UI_trait_NightVision",
    description = "UI_trait_NightVisionDesc",
    profession = true,
    exclude = {"NightVision"},
    swap = "NightVision",
})
--[[

addTrait("Hypercondriac2", {
    name = "UI_trait_hypochon",
    description = "UI_trait_hypochondesc",
    profession = true,
    exclude = {"Hypercondriac"},
    swap = "Hypercondriac",
})
]]

addTrait("Agoraphobic2", {
    name = "UI_trait_agoraphobic",
    description = "UI_trait_agoraphobicdesc",
    profession = true,
    exclude = {"Agoraphobic"},
    swap = "Agoraphobic",
})

addTrait("Claustophobic2", {
    name = "UI_trait_claustro",
    description = "UI_trait_claustrodesc",
    profession = true,
    exclude = {"Claustophobic"},
    swap = "Claustophobic",
})

addTrait("Hemophobic2", {
    name = "UI_trait_Hemophobic",
    description = "UI_trait_HemophobicDesc",
    profession = true,
    exclude = {"Hemophobic"},
    swap = "Hemophobic",
})

addTrait("Insomniac2", {
    name = "UI_trait_Insomniac",
    description = "UI_trait_InsomniacDesc",
    profession = true,
    exclude = {"Insomniac"},
    swap = "Insomniac",
    requiresSleepEnabled = true,
})

addTrait("Pacifist2", {
    name = "UI_trait_Pacifist",
    description = "UI_trait_PacifistDesc",
    profession = true,
    exclude = {"Pacifist"},
    swap = "Pacifist",
})

addTrait("Smoker2", {
    name = "UI_trait_Smoker",
    description = "UI_trait_SmokerDesc",
    profession = true,
    exclude = {"Smoker"},
    swap = "Smoker",
})

addTrait("Asthmatic2", {
    name = "UI_trait_Asthmatic",
    description = "UI_trait_AsthmaticDesc",
    profession = true,
    exclude = {"Asthmatic"},
    swap = "Asthmatic",
})

addTrait("Herbalist2", {
    name = "UI_trait_Herbalist",
    description = "UI_trait_HerbalistDesc",
    profession = true,
    recipes = {"Herbalist"},
    exclude = {"Herbalist"},
    swap = "Herbalist",
})


addTrait("Handy2", {
    name = "UI_trait_handy",
    description = "UI_trait_handydesc",
    profession = true,
    exclude = {"Handy"},
    swap = "Handy",
})

addTrait("Jogger2", {
    name = "UI_trait_Jogger",
    description = "UI_trait_JoggerDesc",
    profession = true,
    exclude = {"Jogger"},
    swap = "Jogger",
})
