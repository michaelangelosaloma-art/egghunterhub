-- Egg Hunter Hub | Chilli-inspired UI prototype
-- For testing in your own Roblox Studio project.
-- UI controls are demonstrations, not game exploit functions.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("EggHunterHub")
if old then old:Destroy() end

local function new(class, props, parent)
    local obj = Instance.new(class)
    for key, value in pairs(props) do
        obj[key] = value
    end
    obj.Parent = parent
    return obj
end

local red = Color3.fromRGB(230, 25, 35)
local dark = Color3.fromRGB(18, 20, 23)
local panel = Color3.fromRGB(30, 32, 36)
local white = Color3.fromRGB(245, 245, 245)

local gui = new("ScreenGui", {
    Name = "EggHunterHub",
    ResetOnSpawn = false,
    DisplayOrder = 100,
}, playerGui)

local main = new("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(560, 460),
    Position = UDim2.new(0.5, -280, 0.5, -230),
    BackgroundColor3 = dark,
    BackgroundTransparency = 0.12,
    BorderSizePixel = 0,
}, gui)
new("UICorner", {CornerRadius = UDim.new(0, 8)}, main)
new("UIStroke", {Color = Color3.fromRGB(95, 95, 95), Thickness = 1.5}, main)

local header = new("Frame", {
    Size = UDim2.new(1, 0, 0, 54),
    BackgroundColor3 = red,
    BorderSizePixel = 0,
}, main)
new("UICorner", {CornerRadius = UDim.new(0, 8)}, header)
new("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 75, 75)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(165, 0, 10)),
    }),
    Rotation = 90,
}, header)

new("TextLabel", {
    Size = UDim2.new(1, -60, 1, 0),
    Position = UDim2.fromOffset(18, 0),
    BackgroundTransparency = 1,
    Text = "Egg Hunter Hub",
    TextColor3 = white,
    Font = Enum.Font.GothamBold,
    TextSize = 25,
    TextXAlignment = Enum.TextXAlignment.Left,
}, header)

local close = new("TextButton", {
    Size = UDim2.fromOffset(36, 34),
    Position = UDim2.new(1, -44, 0, 10),
    BackgroundColor3 = Color3.fromRGB(125, 0, 8),
    Text = "X",
    TextColor3 = white,
    Font = Enum.Font.GothamBold,
    TextSize = 20,
}, header)
new("UICorner", {CornerRadius = UDim.new(0, 5)}, close)
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local categories = {"Farm", "Player", "Predictor", "Progress", "Server", "Misc", "Auto Hop"}
local activeCategory = "Farm"
local featureButtons = {}
local enabled = {}

local left = new("Frame", {
    Position = UDim2.fromOffset(10, 66),
    Size = UDim2.fromOffset(112, 320),
    BackgroundTransparency = 1,
}, main)
new("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, left)

local center = new("Frame", {
    Position = UDim2.fromOffset(132, 66),
    Size = UDim2.fromOffset(294, 320),
    BackgroundColor3 = Color3.fromRGB(12, 14, 16),
    BackgroundTransparency = 0.12,
    BorderSizePixel = 0,
}, main)
new("UICorner", {CornerRadius = UDim.new(0, 6)}, center)

local searchBox = new("TextBox", {
    Position = UDim2.fromOffset(8, 8),
    Size = UDim2.new(1, -16, 0, 32),
    BackgroundColor3 = panel,
    Text = "",
    PlaceholderText = "Search features...",
    PlaceholderColor3 = Color3.fromRGB(170, 170, 170),
    TextColor3 = white,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    ClearTextOnFocus = false,
}, center)
new("UICorner", {CornerRadius = UDim.new(0, 5)}, searchBox)

local scroll = new("ScrollingFrame", {
    Position = UDim2.fromOffset(7, 48),
    Size = UDim2.new(1, -14, 1, -55),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, center)
new("UIListLayout", {
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, scroll)

local function refreshFeatures()
    local query = searchBox.Text:lower()
    for _, item in ipairs(featureButtons) do
        item.row.Visible = item.category == activeCategory
            and item.name:lower():find(query, 1, true) ~= nil
    end
end

for _, name in ipairs(categories) do
    local button = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = name == activeCategory and red or Color3.fromRGB(70, 25, 29),
        Text = name,
        TextColor3 = white,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
    }, left)
    new("UICorner", {CornerRadius = UDim.new(0, 5)}, button)

    button.MouseButton1Click:Connect(function()
        activeCategory = name
        for _, child in ipairs(left:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = child.Text == activeCategory
                    and red or Color3.fromRGB(70, 25, 29)
            end
        end
        refreshFeatures()
    end)
end

local featureData = {
    {"Farm", "Nearest Egg Finder"},
    {"Farm", "Egg Markers"},
    {"Farm", "Auto-Steal Demo"},
    {"Farm", "Auto Place Demo"},
    {"Farm", "Auto Hatch Demo"},
    {"Player", "Walk Speed UI"},
    {"Player", "Jump Settings UI"},
    {"Predictor", "Event Tracker"},
    {"Progress", "Progress Display"},
    {"Server", "Server Info Display"},
    {"Misc", "Show Notifications"},
    {"Auto Hop", "Auto Hop Demo"},
}

for index, data in ipairs(featureData) do
    local category, name = data[1], data[2]
    local row = new("Frame", {
        Name = name,
        Size = UDim2.new(1, -2, 0, 38),
        BackgroundColor3 = panel,
        BorderSizePixel = 0,
        LayoutOrder = index,
    }, scroll)
    new("UICorner", {CornerRadius = UDim.new(0, 5)}, row)

    new("TextLabel", {
        Position = UDim2.fromOffset(9, 0),
        Size = UDim2.new(1, -64, 1, 0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = white,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, row)

    local toggle = new("TextButton", {
        Size = UDim2.fromOffset(42, 22),
        Position = UDim2.new(1, -49, 0.5, -11),
        BackgroundColor3 = Color3.fromRGB(70, 70, 75),
        Text = "",
        AutoButtonColor = false,
    }, row)
    new("UICorner", {CornerRadius = UDim.new(1, 0)}, toggle)

    local knob = new("Frame", {
        Size = UDim2.fromOffset(16, 16),
        Position = UDim2.fromOffset(3, 3),
        BackgroundColor3 = white,
        BorderSizePixel = 0,
    }, toggle)
    new("UICorner", {CornerRadius = UDim.new(1, 0)}, knob)

    enabled[name] = false
    toggle.MouseButton1Click:Connect(function()
        enabled[name] = not enabled[name]
        local on = enabled[name]
        toggle.BackgroundColor3 = on and red or Color3.fromRGB(70, 70, 75)
        knob.Position = on and UDim2.new(1, -19, 0, 3) or UDim2.fromOffset(3, 3)
    end)

    table.insert(featureButtons, {name = name, category = category, row = row})
end

searchBox:GetPropertyChangedSignal("Text"):Connect(refreshFeatures)

local right = new("Frame", {
    Position = UDim2.fromOffset(435, 75),
    Size = UDim2.fromOffset(115, 250),
    BackgroundTransparency = 1,
}, main)

for i, name in ipairs({"Admin Abuse", "Discord", "Quick & Keys", "Settings", "Config"}) do
    local button = new("TextButton", {
        Position = UDim2.fromOffset(0, (i - 1) * 44),
        Size = UDim2.new(1, 0, 0, 37),
        BackgroundColor3 = red,
        Text = name,
        TextColor3 = white,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
    }, right)
    new("UICorner", {CornerRadius = UDim.new(0, 5)}, button)

    button.MouseButton1Click:Connect(function()
        activeCategory = "Misc"
        for _, child in ipairs(left:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = child.Text == activeCategory
                    and red or Color3.fromRGB(70, 25, 29)
            end
        end
        searchBox.Text = ""
        refreshFeatures()
    end)
end

new("TextLabel", {
    Position = UDim2.new(0, 10, 1, -34),
    Size = UDim2.new(1, -20, 0, 25),
    BackgroundTransparency = 1,
    Text = "UI Prototype | Toggles are visual demonstrations",
    TextColor3 = Color3.fromRGB(185, 185, 185),
    Font = Enum.Font.Gotham,
    TextSize = 10,
}, main)

-- Drag window using its header
local dragging, dragStart, startPosition = false, nil, nil
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

refreshFeatures()
