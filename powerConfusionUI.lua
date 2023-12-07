local targetInfoText = nil;

local function createClassSpecList(parentFrame)
    local yPos = -100
    for class, specs in pairs(ClassAbilities) do
        for spec, ability in pairs(specs) do
            local text = class .. " - " .. spec .. ": " .. ability.name .. " (ID: " .. ability.id .. ")"
            local fs = parentFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
            fs:SetPoint("TOPLEFT", 10, yPos)
            fs:SetText(text)
            yPos = yPos - 20
        end
    end
end

local function updateTargetInfoUI()
    if TargetName and TargetClass and TargetSpec then
        local specName = select(2, GetSpecializationInfoByID(TargetSpec))
        targetInfoText:SetText("Target: " .. TargetName.. "".. TargetClass .. " - " .. specName)
    else
        targetInfoText:SetText("No target selected.")
    end
end

local function setTargetInfo()
    if UnitExists("target") then

        local name, server = UnitName("target")
        local targetName = name;
        if server then
            name = name .. "-" .. server
        end
        TargetName = targetName

        local _, class = UnitClass("target")
        TargetClass = class
        TargetSpec = GetSpecializationInfo(GetSpecialization(), nil, nil, nil, UnitSex("target"))
        updateTargetInfoUI()
    else
        targetInfoText:SetText("No target selected.")
    end
end


UIFrame = CreateFrame("Frame", "PowerConfusionUI", UIParent)
UIFrame:SetSize(300, 400) -- Width, Height
UIFrame:SetPoint("CENTER") -- Position on the screen
UIFrame:SetMovable(true)
UIFrame:EnableMouse(true)
UIFrame:RegisterForDrag("LeftButton")
UIFrame:SetScript("OnDragStart", UIFrame.StartMoving)
UIFrame:SetScript("OnDragStop", UIFrame.StopMovingOrSizing)
-- Create the button
local button = CreateFrame("Button", nil, UIFrame, "GameMenuButtonTemplate")
button:SetSize(100, 30)
button:SetPoint("TOP", UIFrame, "TOP", 0, 0)
button:SetText("Set Target")
button:SetNormalFontObject("GameFontNormal")
button:SetHighlightFontObject("GameFontHighlight")

targetInfoText = UIFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
targetInfoText:SetPoint("TOP", button, "BOTTOM", 0, -10)
targetInfoText:SetText("No target selected.")


-- Set script for button click
button:SetScript("OnClick", function()
    setTargetInfo()
end)

-- Create the list of class abilities
createClassSpecList(UIFrame)

UIFrame:Hide()