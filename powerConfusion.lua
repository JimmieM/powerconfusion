ClassAbilities = {
    ["Warrior"] = {
        ["Fury"] = {name = "Recklessness", id = 1719},
        ["Arms"] = {name = "Avatar", id = 107574}
    },
    ["Warlock"] = {
        ["Demonology"] = {name = "Summon Demonic Tyrant", id = 265187},
    },
    ["Mage"] = {
        ["Fire"] = {name = "Combustion", id = 190319},
    },

    ["PRIEST"] = {
        ["Discipline"] = {name = "Power Infusion", id = 17},
    },

}


TargetName = nil
TargetClass = nil
TargetSpec = nil

UIFrame = nil;

function OpenUI()
    UIFrame:Show()
end

SLASH_TORMENT1 = '/pc'
SlashCmdList.TORMENT = function()
    if UIFrame:IsShown() then
        UIFrame:Hide()
    else
        OpenUI()
    end
end