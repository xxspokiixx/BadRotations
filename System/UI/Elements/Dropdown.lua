local DiesalGUI = LibStub("DiesalGUI-1.0")
local DiesalTools = LibStub("DiesalTools-1.0")

function br.ui:createDropdown(parent, text, itemlist, default, tooltip, tooltipDrop, hideCheckbox)

    -------------------------------
    ----Need to calculate Y Pos----
    -------------------------------
    local Y = -5
    for i=1, #parent.children do
        if parent.children[i].type ~= "Spinner" and parent.children[i].type ~= "Dropdown" then
            Y = Y - parent.children[i].frame:GetHeight()*1.2
        end
    end
    Y = DiesalTools.Round(Y)

    -------------------------------
    --------Create CheckBox--------
    -------------------------------
    checkBox = br.ui:createCheckbox(parent, text, tooltip)
    if hideCheckbox then
        checkBox:Disable()
        checkBox:ReleaseTextures()
    end
    -------------------------------

    -------------------------------
    --------Create Dropdown--------
    -------------------------------
    local newDropdown = DiesalGUI:Create('Dropdown')
    local default = default or 1
    parent:AddChild(newDropdown)
    
    newDropdown:SetParent(parent.content)
    newDropdown:SetPoint("TOPRIGHT", parent.content, "TOPRIGHT", -10, Y)
    newDropdown:SetHeight(12)
    newDropdown:SetList(itemlist)

    --------------
    ---BR Stuff---
    --------------
    -- Read from config or set default
    if br.data.settings[br.selectedSpec][br.selectedProfile][text.."Drop"] == nil then br.data.settings[br.selectedSpec][br.selectedProfile][text.."Drop"] = default end
    local value = br.data.settings[br.selectedSpec][br.selectedProfile][text.."Drop"]
    newDropdown:SetValue(value)

    ------------------
    ------Events------
    ------------------
    -- Event: OnValueChange
    newDropdown:SetEventListener('OnValueChanged', function(this, event, key, value, selection)
       br.data.settings[br.selectedSpec][br.selectedProfile][text.."Drop"]  = key
    end)
    -- Event: Tooltip
    if tooltip or tooltipDrop then
       local tooltip = tooltipDrop or tooltip
       newDropdown:SetEventListener("OnEnter", function(this, event)
           GameTooltip:SetOwner(Minimap, "ANCHOR_CURSOR", 50 , 50)
           GameTooltip:SetText(tooltip, 214/255, 25/255, 25/255)
           GameTooltip:Show()
       end)
       newDropdown:SetEventListener("OnLeave", function(this, event)
           GameTooltip:Hide()
       end)
    end

    ----------------------
    ------END Events------
    ----------------------
    newDropdown:ApplySettings()
    ----------------------------
    --------END Dropdown--------
    ----------------------------

    -- return newDropdown
end

function br.ui:createDropdownWithout(parent, text, itemlist, default, tooltip, tooltipDrop)
    return br.ui:createDropdown(parent, text, itemlist, default, tooltip, tooltipDrop, true)
end