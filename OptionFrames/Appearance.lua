local _, Cell = ...
local L = Cell.L
local F = Cell.funcs
local LPP = LibStub:GetLibrary("LibPixelPerfect")

local appearanceTab = Cell:CreateFrame("CellOptionsFrame_AppearanceTab", Cell.frames.optionsFrame, nil, nil, true)
Cell.frames.appearanceTab = appearanceTab
appearanceTab:SetAllPoints(Cell.frames.optionsFrame)
appearanceTab:Hide()

-------------------------------------------------
-- texture
-------------------------------------------------
local textureText = Cell:CreateSeparator(L["Texture"], appearanceTab, 188)
textureText:SetPoint("TOPLEFT", 5, -5)

local textureDropdown = Cell:CreateDropdown(appearanceTab, 150, "texture")
textureDropdown:SetPoint("TOPLEFT", textureText, "BOTTOMLEFT", 5, -12)

local function CheckTextures()
    local items = {}
    local textures, textureNames
    local defaultTexture, defaultTextureName = "Interface\\AddOns\\Cell\\Media\\statusbar.tga", "Cell ".._G.DEFAULT
    
    local LSM = LibStub("LibSharedMedia-3.0", true)
    if LSM then
        textures, textureNames = F:Copy(LSM:HashTable("statusbar")), F:Copy(LSM:List("statusbar"))
        -- insert default texture
        tinsert(textureNames, 1, defaultTextureName)
        textures[defaultTextureName] = defaultTexture

        for _, name in pairs(textureNames) do
            tinsert(items, {
                ["text"] = name,
                ["texture"] = textures[name],
                ["onClick"] = function()
                    CellDB["appearance"]["texture"] = name
                    Cell:Fire("UpdateAppearance", "texture")
                end,
            })
        end
    else
        textureNames = {defaultTextureName}
        textures = {[defaultTextureName] = defaultTexture}

        tinsert(items, {
            ["text"] = defaultTextureName,
            ["texture"] = defaultTexture,
            ["onClick"] = function()
                CellDB["appearance"]["texture"] = defaultTextureName
                Cell:Fire("UpdateAppearance", "texture")
            end,
        })
    end
    textureDropdown:SetItems(items)

    -- validation
    if textures[CellDB["appearance"]["texture"]] then
        textureDropdown:SetSelected(CellDB["appearance"]["texture"], textures[CellDB["appearance"]["texture"]])
    else
        textureDropdown:SetSelected(defaultTextureName, defaultTexture)
    end
end


-------------------------------------------------
-- scale
-------------------------------------------------
local scaleText = Cell:CreateSeparator(L["Scale"], appearanceTab, 188)
scaleText:SetPoint("TOPLEFT", 203, -5)

local scaleDropdown = Cell:CreateDropdown(appearanceTab, 150)
scaleDropdown:SetPoint("TOPLEFT", scaleText, "BOTTOMLEFT", 5, -12)

local scales = {
    [1] = "100%",
    [1.5] = "150%",
    [2] = "200%",
    [2.5] = "250%",
    [3] = "300%",
}

do
    local indices = {1, 1.5, 2, 2.5, 3}
    local items = {}
    for _, value in pairs(indices) do
        table.insert(items, {
            ["text"] = scales[value],
            ["onClick"] = function()
                CellDB["appearance"]["scale"] = value
                Cell:Fire("UpdateAppearance", "scale")
            end,
        })
    end
    scaleDropdown:SetItems(items)
end

-------------------------------------------------
-- font
-------------------------------------------------
local fontText = Cell:CreateSeparator(L["Font"], appearanceTab, 188)
fontText:SetPoint("TOPLEFT", 5, -90)

-- drop down
local fontDropdown = Cell:CreateDropdown(appearanceTab, 150, "font")
fontDropdown:SetPoint("TOPLEFT", fontText, "BOTTOMLEFT", 5, -12)

local function CheckFonts()
    local items, fonts, defaultFontName, defaultFont = F:GetFontItems()

    for _, item in pairs(items) do
        item["onClick"] = function()
            CellDB["appearance"]["font"] = item["text"]
            Cell:Fire("UpdateAppearance", "font")
        end
    end

    fontDropdown:SetItems(items)
    
    -- validation
    if fonts[CellDB["appearance"]["font"]] then
        fontDropdown:SetSelected(CellDB["appearance"]["font"], fonts[CellDB["appearance"]["font"]])
    else
        fontDropdown:SetSelected(defaultFontName, defaultFont)
    end
end

-------------------------------------------------
-- font outline
-------------------------------------------------
local fontOutlineText = Cell:CreateSeparator(L["Font Outline"], appearanceTab, 188)
fontOutlineText:SetPoint("TOPLEFT", 203, -90)

-- drop down
local fontOutlineDropdown = Cell:CreateDropdown(appearanceTab, 150)
fontOutlineDropdown:SetPoint("TOPLEFT", fontOutlineText, "BOTTOMLEFT", 5, -12)
fontOutlineDropdown:SetItems({
    {
        ["text"] = L["Shadow"],
        ["onClick"] = function()
            CellDB["appearance"]["outline"] = "Shadow"
            Cell:Fire("UpdateAppearance", "font")
        end,
    },
    {
        ["text"] = L["Outline"],
        ["onClick"] = function()
            CellDB["appearance"]["outline"] = "Outline"
            Cell:Fire("UpdateAppearance", "font")
        end,
    },
    {
        ["text"] = L["Monochrome Outline"],
        ["onClick"] = function()
            CellDB["appearance"]["outline"] = "Monochrome Outline"
            Cell:Fire("UpdateAppearance", "font")
        end,
    },
})

-------------------------------------------------
-- functions
-------------------------------------------------
local loaded
local function ShowTab(tab)
    if tab == "appearance" then
        appearanceTab:Show()
        if loaded then return end
        loaded = true

        -- load data
        CheckTextures()
        scaleDropdown:SetSelected(scales[CellDB["appearance"]["scale"]])
        CheckFonts()
        fontOutlineDropdown:SetSelected(L[CellDB["appearance"]["outline"]])
    else
        appearanceTab:Hide()
    end
end
Cell:RegisterCallback("ShowOptionsTab", "AppearanceTab_ShowTab", ShowTab)

-------------------------------------------------
-- update appearance
-------------------------------------------------
local function UpdateAppearance(which)
    F:Debug("|cff7f7fffUpdateAppearance:|r "..(which or "all"))
    
    if not which or which == "font" or which == "texture" then
        F:UpdateFont()
        local tex = F:GetBarTexture()

        F:IterateAllUnitButtons(function(b)
            -- font width
            if not which or which == "font" then
                b:GetScript("OnSizeChanged")(b)
            end
            -- texture
            if not which or which == "texture" then
                b.func.SetTexture(tex)
            end
        end)
    end

    -- scale
    if not which or which == "scale" then
        Cell.frames.mainFrame:SetScale(CellDB["appearance"]["scale"])
        CellTooltip:SetScale(LPP:GetPixelPerfectScale() * CellDB["appearance"]["scale"])
        CellScanningTooltip:SetScale(LPP:GetPixelPerfectScale() * CellDB["appearance"]["scale"])
    end
end
Cell:RegisterCallback("UpdateAppearance", "UpdateAppearance", UpdateAppearance)