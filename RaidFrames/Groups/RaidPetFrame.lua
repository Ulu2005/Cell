local _, Cell = ...
local L = Cell.L
local F = Cell.funcs
local B = Cell.bFuncs
local P = Cell.pixelPerfectFuncs

local raidPetFrame = CreateFrame("Frame", "CellRaidPetFrame", Cell.frames.mainFrame, "SecureHandlerAttributeTemplate")
Cell.frames.raidPetFrame = raidPetFrame

-------------------------------------------------
-- anchor
-------------------------------------------------
local anchorFrame = CreateFrame("Frame", "CellRaidPetAnchorFrame", raidPetFrame, "BackdropTemplate")
Cell.frames.raidPetFrameAnchor = anchorFrame
anchorFrame:SetPoint("TOPLEFT", UIParent, "CENTER")
anchorFrame:SetMovable(true)
anchorFrame:SetClampedToScreen(true)
-- Cell:StylizeFrame(anchorFrame, {1, 0, 0, 0.4})

local hoverFrame = CreateFrame("Frame", nil, raidPetFrame)
hoverFrame:SetPoint("TOP", anchorFrame, 0, 1)
hoverFrame:SetPoint("BOTTOM", anchorFrame, 0, -1)
hoverFrame:SetPoint("LEFT", anchorFrame, -1, 0)
hoverFrame:SetPoint("RIGHT", anchorFrame, 1, 0)

local dumb = Cell:CreateButton(anchorFrame, nil, "accent", {20, 10}, false, true)
dumb:Hide()
dumb:SetFrameStrata("MEDIUM")
dumb:SetAllPoints(anchorFrame)
dumb:SetScript("OnDragStart", function()
    anchorFrame:StartMoving()
    anchorFrame:SetUserPlaced(false)
end)
dumb:SetScript("OnDragStop", function()
    anchorFrame:StopMovingOrSizing()
    P:SavePosition(anchorFrame, Cell.vars.currentLayoutTable["pet"]["position"])
end)
dumb:HookScript("OnEnter", function()
    hoverFrame:GetScript("OnEnter")(hoverFrame)
    CellTooltip:SetOwner(dumb, "ANCHOR_NONE")
    CellTooltip:SetPoint(tooltipPoint, dumb, tooltipRelativePoint, tooltipX, tooltipY)
    CellTooltip:AddLine(L["Raid Pets"])
    CellTooltip:Show()
end)
dumb:HookScript("OnLeave", function()
    hoverFrame:GetScript("OnLeave")(hoverFrame)
    CellTooltip:Hide()
end)

function raidPetFrame:UpdateAnchor()
    local show
    if Cell.vars.currentLayoutTable["pet"]["raidEnabled"] then
        show = Cell.unitButtons.raidpet[1]:IsShown()
    end
    
    hoverFrame:EnableMouse(show)
    if show then
        dumb:Show()
        if CellDB["general"]["fadeOut"] then
            if hoverFrame:IsMouseOver() then
                anchorFrame.fadeIn:Play()
            else
                anchorFrame.fadeOut:GetScript("OnFinished")(anchorFrame.fadeOut)
            end
        end
    else
        dumb:Hide()
    end
end

-------------------------------------------------
-- fadeIn & fadeOut
-------------------------------------------------
local fadingIn, fadedIn, fadingOut, fadedOut
anchorFrame.fadeIn = anchorFrame:CreateAnimationGroup()
anchorFrame.fadeIn.alpha = anchorFrame.fadeIn:CreateAnimation("alpha")
anchorFrame.fadeIn.alpha:SetFromAlpha(0)
anchorFrame.fadeIn.alpha:SetToAlpha(1)
anchorFrame.fadeIn.alpha:SetDuration(0.5)
anchorFrame.fadeIn.alpha:SetSmoothing("OUT")
anchorFrame.fadeIn:SetScript("OnPlay", function()
    anchorFrame.fadeOut:Finish()
    fadingIn = true
end)
anchorFrame.fadeIn:SetScript("OnFinished", function()
    fadingIn = false
    fadingOut = false
    fadedIn = true
    fadedOut = false
    anchorFrame:SetAlpha(1)

    if CellDB["general"]["fadeOut"] and not hoverFrame:IsMouseOver() then
        anchorFrame.fadeOut:Play()
    end
end)

anchorFrame.fadeOut = anchorFrame:CreateAnimationGroup()
anchorFrame.fadeOut.alpha = anchorFrame.fadeOut:CreateAnimation("alpha")
anchorFrame.fadeOut.alpha:SetFromAlpha(1)
anchorFrame.fadeOut.alpha:SetToAlpha(0)
anchorFrame.fadeOut.alpha:SetDuration(0.5)
anchorFrame.fadeOut.alpha:SetSmoothing("OUT")
anchorFrame.fadeOut:SetScript("OnPlay", function()
    anchorFrame.fadeIn:Finish()
    fadingOut = true
end)
anchorFrame.fadeOut:SetScript("OnFinished", function()
    fadingIn = false
    fadingOut = false
    fadedIn = false
    fadedOut = true
    anchorFrame:SetAlpha(0)

    if hoverFrame:IsMouseOver() then
        anchorFrame.fadeIn:Play()
    end
end)

hoverFrame:SetScript("OnEnter", function()
    if not CellDB["general"]["fadeOut"] then return end
    if not (fadingIn or fadedIn) then
        anchorFrame.fadeIn:Play()
    end
end)
hoverFrame:SetScript("OnLeave", function()
    if not CellDB["general"]["fadeOut"] then return end
    if hoverFrame:IsMouseOver() then return end
    if not (fadingOut or fadedOut) then
        anchorFrame.fadeOut:Play()
    end
end)

-------------------------------------------------
-- header
-------------------------------------------------
local header = CreateFrame("Frame", "CellRaidPetFrameHeader", raidPetFrame, "SecureGroupPetHeaderTemplate")
header:SetAllPoints(raidPetFrame)

header:SetAttribute("initialConfigFunction", [[
    --! button for pet/vehicle only, toggleForVehicle MUST be false
    self:SetAttribute("toggleForVehicle", false)

    -- RegisterUnitWatch(self)
    
    -- local header = self:GetParent()
    -- self:SetWidth(header:GetAttribute("buttonWidth") or 66)
    -- self:SetHeight(header:GetAttribute("buttonHeight") or 46)
]])

function header:UpdateButtonUnits(bName, unit)
    if not unit then return end
    Cell.unitButtons.raidpet.units[unit] = _G[bName]
    _G[bName].isRaidPet = true
end

header:SetAttribute("_initialAttributeNames", "refreshUnitChange")
header:SetAttribute("_initialAttribute-refreshUnitChange", [[
    self:GetParent():CallMethod("UpdateButtonUnits", self:GetName(), self:GetAttribute("unit"))
]])
    
header:SetAttribute("template", "CellUnitButtonTemplate")
header:SetAttribute("point", "TOP")
header:SetAttribute("columnAnchorPoint", "LEFT")
header:SetAttribute("unitsPerColumn", 5)

if Cell.isRetail then
    header:SetAttribute("maxColumns", 4)
    --! make needButtons == 20
    header:SetAttribute("startingIndex", -19)
else
    header:SetAttribute("maxColumns", 5)
    --! make needButtons == 25
    header:SetAttribute("startingIndex", -24)
end
header:Show()
header:SetAttribute("startingIndex", 1)

for i, b in ipairs({header:GetChildren()}) do
    Cell.unitButtons.raidpet[i] = b
    -- b.type = "pet" -- layout setup
end

-- update mover
header[1]:HookScript("OnShow", function()
    raidPetFrame:UpdateAnchor()
end)
header[1]:HookScript("OnHide", function()
    raidPetFrame:UpdateAnchor()
end)

-------------------------------------------------
-- functions
-------------------------------------------------
local function UpdatePosition()
    raidPetFrame:ClearAllPoints()
    -- NOTE: detach from spotlightPreviewAnchor
    P:LoadPosition(anchorFrame, Cell.vars.currentLayoutTable["pet"]["position"])

    local anchor
    if Cell.vars.currentLayoutTable["pet"]["sameArrangementAsMain"] then
        anchor = Cell.vars.currentLayoutTable["main"]["anchor"]
    else
        anchor = Cell.vars.currentLayoutTable["pet"]["anchor"]
    end
    
    if CellDB["general"]["menuPosition"] == "top_bottom" then
        P:Size(anchorFrame, 20, 10)
        if anchor == "BOTTOMLEFT" then
            raidPetFrame:SetPoint("BOTTOMLEFT", anchorFrame, "TOPLEFT", 0, 4)
            tooltipPoint, tooltipRelativePoint, tooltipX, tooltipY = "TOPLEFT", "BOTTOMLEFT", 0, -3
        elseif anchor == "BOTTOMRIGHT" then
            raidPetFrame:SetPoint("BOTTOMRIGHT", anchorFrame, "TOPRIGHT", 0, 4)
            tooltipPoint, tooltipRelativePoint, tooltipX, tooltipY = "TOPRIGHT", "BOTTOMRIGHT", 0, -3
        elseif anchor == "TOPLEFT" then
            raidPetFrame:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -4)
            tooltipPoint, tooltipRelativePoint, tooltipX, tooltipY = "BOTTOMLEFT", "TOPLEFT", 0, 3
        elseif anchor == "TOPRIGHT" then
            raidPetFrame:SetPoint("TOPRIGHT", anchorFrame, "BOTTOMRIGHT", 0, -4)
            tooltipPoint, tooltipRelativePoint, tooltipX, tooltipY = "BOTTOMRIGHT", "TOPRIGHT", 0, 3
        end
    else
        P:Size(anchorFrame, 10, 20)
        if anchor == "BOTTOMLEFT" then
            raidPetFrame:SetPoint("BOTTOMLEFT", anchorFrame, "BOTTOMRIGHT", 4, 0)
            tooltipPoint, tooltipRelativePoint, tooltipX, tooltipY = "BOTTOMRIGHT", "BOTTOMLEFT", -3, 0
        elseif anchor == "BOTTOMRIGHT" then
            raidPetFrame:SetPoint("BOTTOMRIGHT", anchorFrame, "BOTTOMLEFT", -4, 0)
            tooltipPoint, tooltipRelativePoint, tooltipX, tooltipY = "BOTTOMLEFT", "BOTTOMRIGHT", 3, 0
        elseif anchor == "TOPLEFT" then
            raidPetFrame:SetPoint("TOPLEFT", anchorFrame, "TOPRIGHT", 4, 0)
            tooltipPoint, tooltipRelativePoint, tooltipX, tooltipY = "TOPRIGHT", "TOPLEFT", -3, 0
        elseif anchor == "TOPRIGHT" then
            raidPetFrame:SetPoint("TOPRIGHT", anchorFrame, "TOPLEFT", -4, 0)
            tooltipPoint, tooltipRelativePoint, tooltipX, tooltipY = "TOPLEFT", "TOPRIGHT", 3, 0
        end
    end

    raidPetFrame:UpdateAnchor()
end

local function UpdateMenu(which)
    if not which or which == "lock" then
        if CellDB["general"]["locked"] then
            dumb:RegisterForDrag()
        else
            dumb:RegisterForDrag("LeftButton")
        end
    end

    if not which or which == "fadeOut" then
        if CellDB["general"]["fadeOut"] then
            anchorFrame.fadeOut:Play()
        else
            anchorFrame.fadeIn:Play()
        end
    end

    if which == "position" then
        UpdatePosition()
    end
end
Cell:RegisterCallback("UpdateMenu", "RaidPetFrame_UpdateMenu", UpdateMenu)

local init, previousLayout
local function RaidPetFrame_UpdateLayout(layout, which)
    if Cell.vars.groupType ~= "raid" and init then return end
    init = true
    
    if previousLayout == layout and not which then return end
    previousLayout = layout

    layout = CellDB["layouts"][layout]

    if not which or strfind(which, "size$") or strfind(which, "power$") or which == "barOrientation" then
        local width, height, powerSize
        
        if layout["pet"]["sameSizeAsMain"] then
            width, height = unpack(layout["main"]["size"])
            powerSize = layout["main"]["powerSize"]
        else
            width, height = unpack(layout["pet"]["size"])
            powerSize = layout["pet"]["powerSize"]
        end

        P:Size(raidPetFrame, width, height)

        header:SetAttribute("buttonWidth", P:Scale(width))
        header:SetAttribute("buttonHeight", P:Scale(height))

        for i, b in ipairs({header:GetChildren()}) do
            if not which or strfind(which, "size$") then
                P:Size(b, width, height)
            end

            -- NOTE: SetOrientation BEFORE SetPowerSize
            if not which or which == "barOrientation" then
                B:SetOrientation(b, layout["barOrientation"][1], layout["barOrientation"][2])
            end
           
            if not which or strfind(which, "power$") or which == "barOrientation" then
                B:SetPowerSize(b, powerSize)
            end
        end
    end

    if not which or strfind(which, "arrangement$") then
        local orientation, anchor, spacingX, spacingY
        if layout["pet"]["sameArrangementAsMain"] then
            orientation = layout["main"]["orientation"]
            anchor = layout["main"]["anchor"]
            spacingX = layout["main"]["spacingX"]
            spacingY = layout["main"]["spacingY"]
        else
            orientation = layout["pet"]["orientation"]
            anchor = layout["pet"]["anchor"]
            spacingX = layout["pet"]["spacingX"]
            spacingY = layout["pet"]["spacingY"]
        end

        local point, anchorPoint, unitSpacing, headerPoint, headerColumnAnchorPoint
        if orientation == "vertical" then
            -- anchor
            if anchor == "BOTTOMLEFT" then
                point, anchorPoint = "BOTTOMLEFT", "TOPLEFT"
                headerPoint, headerColumnAnchorPoint = "BOTTOM", "LEFT"
                unitSpacing = spacingY
            elseif anchor == "BOTTOMRIGHT" then
                point, anchorPoint = "BOTTOMRIGHT", "TOPRIGHT"
                headerPoint, headerColumnAnchorPoint = "BOTTOM", "RIGHT"
                unitSpacing = spacingY
            elseif anchor == "TOPLEFT" then
                point, anchorPoint = "TOPLEFT", "BOTTOMLEFT"
                headerPoint, headerColumnAnchorPoint = "TOP", "LEFT"
                unitSpacing = -spacingY
            elseif anchor == "TOPRIGHT" then
                point, anchorPoint = "TOPRIGHT", "BOTTOMRIGHT"
                headerPoint, headerColumnAnchorPoint = "TOP", "RIGHT"
                unitSpacing = -spacingY
            end

            header:SetAttribute("columnSpacing", spacingX)
            header:SetAttribute("xOffset", 0)
            header:SetAttribute("yOffset", unitSpacing)
        else
            -- anchor
            if anchor == "BOTTOMLEFT" then
                point, anchorPoint = "BOTTOMLEFT", "BOTTOMRIGHT"
                headerPoint, headerColumnAnchorPoint = "LEFT", "BOTTOM"
                unitSpacing = spacingX
            elseif anchor == "BOTTOMRIGHT" then
                point, anchorPoint = "BOTTOMRIGHT", "BOTTOMLEFT"
                headerPoint, headerColumnAnchorPoint = "RIGHT", "BOTTOM"
                unitSpacing = -spacingX
            elseif anchor == "TOPLEFT" then
                point, anchorPoint = "TOPLEFT", "TOPRIGHT"
                headerPoint, headerColumnAnchorPoint = "LEFT", "TOP"
                unitSpacing = spacingX
            elseif anchor == "TOPRIGHT" then
                point, anchorPoint = "TOPRIGHT", "TOPLEFT"
                headerPoint, headerColumnAnchorPoint = "RIGHT", "TOP"
                unitSpacing = -spacingX
            end

            header:SetAttribute("columnSpacing", spacingY)
            header:SetAttribute("xOffset", unitSpacing)
            header:SetAttribute("yOffset", 0)
        end
        
        -- header:ClearAllPoints()
        -- header:SetPoint(point)
        header:SetAttribute("point", headerPoint)
        header:SetAttribute("columnAnchorPoint", headerColumnAnchorPoint)

        --! force update unitbutton's point
        for i, b in ipairs({header:GetChildren()}) do
            b:ClearAllPoints()
        end
        header:SetAttribute("unitsPerColumn", 5)
        header:SetAttribute("maxColumns", 8)
    end
    
    if not which or strfind(which, "arrangement$") then
        UpdatePosition()
    end

    if not which or which == "pet" then
        if layout["pet"]["raidEnabled"] and Cell.vars.inBattleground ~= 5 then
            header:SetAttribute("showRaid", true)
            RegisterAttributeDriver(raidPetFrame, "state-visibility", "[group:raid] show; [group:party] hide; hide")
        else
            header:SetAttribute("showRaid", false)
            UnregisterAttributeDriver(raidPetFrame, "state-visibility")
            raidPetFrame:Hide()
        end
    end
end
Cell:RegisterCallback("UpdateLayout", "RaidPetFrame_UpdateLayout", RaidPetFrame_UpdateLayout)