local lastSoundTime = 0

local function checkForSpellUse()
    local _, eventType, _, _, _, _, _, _, _, _, _, spellId = CombatLogGetCurrentEventInfo()

    if eventType == "SPELL_CAST_SUCCESS" then
        for i = 1, GetNumGroupMembers() do
            local unit = "party" .. i
            local unitName, unitServer = UnitName(unit)
            if unitServer then
                unitName = unitName .. "-" .. unitServer
            end

            local _, class = UnitClass(unit)
            local spec = GetSpecializationInfo(GetSpecialization(), nil, nil, nil, UnitSex(unit))
            local ability = ClassAbilities[class] and ClassAbilities[class][spec]

            if ability and spellId == ability.id then
                local currentTime = GetTime()
                if currentTime - lastSoundTime >= 60 then -- 1 minute lock
                    PlaySoundFile("Interface\\AddOns\\PowerConfusion\\sound\\power_infusion.mp3") 
                    lastSoundTime = currentTime
                end
            end
        end
    end
end

local eventHandler = CreateFrame("Frame")
eventHandler:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
eventHandler:SetScript("OnEvent", function(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        checkForSpellUse()
    end
end)