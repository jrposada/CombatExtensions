CE_CONTROLS = {}

---comment
---@param config any
---@return unknown
function CE_CONTROLS.Label(config)
    local name = config.name
    local parent = config.parent
    local dims = config.dims
    local anchor = config.anchor
    local font = config.font
    local color = config.color
    local align = config.align
    local text = config.text
    local hidden = config.hiddenda

    --Validate arguments
    if (name == nil or name == "") then return nil end
    if (#anchor ~= 5) then return nil end

    font = (font == nil) and "ZoFontGame" or font
    color = (color ~= nil and #color == 4) and color or { 1, 1, 1, 1 }
    align = (align ~= nil and #align == 2) and align or { 0, 0 }
    hidden = hidden ~= nil and hidden or false

    --Create the label
    local label = _G[name] or CreateControl(name, parent or GuiRoot, CT_LABEL)

    if dims then label:SetDimensions(dims[1], dims[2]) end
    label:ClearAnchors()
    label:SetAnchor(anchor[1], anchor[2], anchor[3], anchor[4], anchor[5])
    label:SetFont(font)
    ---@diagnostic disable-next-line: deprecated
    label:SetColor(unpack(color))
    label:SetHorizontalAlignment(align[1])
    label:SetVerticalAlignment(align[2])
    label:SetText(text)
    label:SetHidden(hidden)

    label:SetDrawTier(2)

    return label
end
