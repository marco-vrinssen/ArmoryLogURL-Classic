StaticPopupDialogs["PLAYER_LINK_URL"] = {
    text = "Copy and paste this URL into your browser.",
    button1 = "Close",
    OnAccept = function() end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnShow = function(self, data)
        self.editBox:SetText(data.PlayerURL)
        self.editBox:HighlightText()
        self.editBox:SetFocus()
        self.editBox:SetScript("OnKeyDown", function(_, key)
            if key == "ESCAPE" then
                self:Hide()
            elseif IsModifierKeyDown() and key == "C" then
                self:Hide()
            end
        end)
    end,
    hasEditBox = true
}

local WarcraftLogsURL = "https://vanilla.warcraftlogs.com/character/"
local ClassicArmoryURL = "https://classic-armory.org/character/"
local AOTCArmoryURL = "https://sod.aotc.gg/character/"
local AtlasforgeArmoryURL = "https://atlasforge.gg/wow-classic/armory/"
local ServerRegions = {'us', 'kr', 'eu', 'tw', 'cn'}

local function ClassicArmoryLink(self)
    local RealmSlug = GetRealmName():gsub("[%p%c]", ""):gsub("[%s]", "-"):lower()
    local CurrentRegion = ServerRegions[GetCurrentRegion()]
    local DropdownMenu = _G["UIDROPDOWNMENU_INIT_MENU"]
    local PlayerURL = ClassicArmoryURL .. CurrentRegion .. '/vanilla/' .. RealmSlug .. '/' .. DropdownMenu.name:lower()
    local PopupDataFill = {PlayerURL = PlayerURL}
    StaticPopup_Show("PLAYER_LINK_URL", "", "", PopupDataFill)
end

local function WarcraftLogsLink(self)
    local RealmSlug = GetRealmName():gsub("[%p%c]", ""):gsub("[%s]", "-"):lower()
    local CurrentRegion = ServerRegions[GetCurrentRegion()]
    local DropdownMenu = _G["UIDROPDOWNMENU_INIT_MENU"]
    local PlayerURL = WarcraftLogsURL .. CurrentRegion .. '/' .. RealmSlug .. '/' .. DropdownMenu.name:lower()
    local PopupDataFill = {PlayerURL = PlayerURL}
    StaticPopup_Show("PLAYER_LINK_URL", "", "", PopupDataFill)
end

local function AOTCLink(self)
    local RealmSlug = GetRealmName():gsub("[%p%c]", ""):gsub("[%s]", "-"):lower()
    local CurrentRegion = ServerRegions[GetCurrentRegion()]
    local DropdownMenu = _G["UIDROPDOWNMENU_INIT_MENU"]
    local PlayerURL = AOTCArmoryURL .. CurrentRegion .. '/' .. RealmSlug .. '/' .. DropdownMenu.name:lower()
    local PopupDataFill = {PlayerURL = PlayerURL}
    StaticPopup_Show("PLAYER_LINK_URL", "", "", PopupDataFill)
end

local function AtlasforgeLink(self)
    local RealmSlug = GetRealmName():gsub("[%p%c]", ""):gsub("[%s]", "-"):lower()
    local CurrentRegion = ServerRegions[GetCurrentRegion()]
    local DropdownMenu = _G["UIDROPDOWNMENU_INIT_MENU"]
    local PlayerURL = AtlasforgeArmoryURL .. CurrentRegion .. '/' .. RealmSlug .. '/' .. DropdownMenu.name:lower()
    local PopupDataFill = {PlayerURL = PlayerURL}
    StaticPopup_Show("PLAYER_LINK_URL", "", "", PopupDataFill)
end

local function MenuItemAdd(text, func, value)
    local MenuItem = UIDropDownMenu_CreateInfo()

    MenuItem.text = text
    MenuItem.owner = which
    MenuItem.notCheckable = 1
    MenuItem.func = func
    MenuItem.colorCode = "|cffFFD100"
    MenuItem.value = value

    UIDropDownMenu_AddButton(MenuItem)
end

hooksecurefunc("UnitPopup_ShowMenu", function()
    if (UIDROPDOWNMENU_MENU_LEVEL > 1) then
        return
    end
    MenuItemAdd("Atlasforge Armory", AtlasforgeLink, "AtlasforgeLink")
    MenuItemAdd("Classic Armory", ClassicArmoryLink, "ClassicArmoryLink")
    MenuItemAdd("AOTC Armory", AOTCLink, "AOTCArmoryLink")
    MenuItemAdd("Warcraft Logs", WarcraftLogsLink, "WarcraftlogsLink")
end)