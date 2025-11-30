-- Fisch Panel UI - ikyy beta (Complete & Organized)
-- With delay settings, +/- buttons, organized sections

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Config
local Config = {
    InstantFish = false,
    NoAnimation = false,
    AutoFish = false,
    FishDelay = 0.1,
    WalkSpeed = 16,
    JumpPower = 50
}

local isMinimized = false

-- Buat ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FischPanelIkyy"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Main Panel
local Panel = Instance.new("Frame")
Panel.Name = "MainPanel"
Panel.Size = UDim2.new(0, 400, 0, 700)
Panel.Position = UDim2.new(0.5, -200, 0.5, -350)
Panel.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Panel.BorderSizePixel = 0
Panel.Active = true
Panel.Parent = ScreenGui

local PanelCorner = Instance.new("UICorner")
PanelCorner.CornerRadius = UDim.new(0, 12)
PanelCorner.Parent = Panel

local PanelStroke = Instance.new("UIStroke")
PanelStroke.Color = Color3.fromRGB(100, 200, 255)
PanelStroke.Thickness = 2
PanelStroke.Parent = Panel

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 55)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Header.BorderSizePixel = 0
Header.Active = true
Header.Parent = Panel

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

-- Make header draggable
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    Panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Panel.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🎣 FISCH PANEL - IKYY"
Title.TextColor3 = Color3.fromRGB(100, 200, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Minimize Button
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 38, 0, 38)
MinimizeBtn.Position = UDim2.new(1, -90, 0, 8.5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 60)
MinimizeBtn.Text = "─"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 20
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = Header

local MinBtnCorner = Instance.new("UICorner")
MinBtnCorner.CornerRadius = UDim.new(0, 8)
MinBtnCorner.Parent = MinimizeBtn

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 38, 0, 38)
CloseBtn.Position = UDim2.new(1, -48, 0, 8.5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

local CloseBtnCorner = Instance.new("UICorner")
CloseBtnCorner.CornerRadius = UDim.new(0, 8)
CloseBtnCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Content Container
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, 0, 1, -55)
Content.Position = UDim2.new(0, 0, 0, 55)
Content.BackgroundTransparency = 1
Content.Parent = Panel

-- ScrollingFrame
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -20)
ScrollFrame.Position = UDim2.new(0, 10, 0, 10)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 200, 255)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1100)
ScrollFrame.Parent = Content

-- Minimize functionality
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        Panel:TweenSize(UDim2.new(0, 400, 0, 55), "Out", "Quad", 0.3, true)
        MinimizeBtn.Text = "+"
        Content.Visible = false
    else
        Panel:TweenSize(UDim2.new(0, 400, 0, 700), "Out", "Quad", 0.3, true)
        MinimizeBtn.Text = "─"
        Content.Visible = true
    end
end)

local currentY = 0

-- Function untuk section header
local function CreateSection(title)
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(1, 0, 0, 40)
    Section.Position = UDim2.new(0, 0, 0, currentY)
    Section.BackgroundTransparency = 1
    Section.Parent = ScrollFrame
    
    local SectionTitle = Instance.new("TextLabel")
    SectionTitle.Size = UDim2.new(1, -10, 1, 0)
    SectionTitle.Position = UDim2.new(0, 5, 0, 0)
    SectionTitle.BackgroundTransparency = 1
    SectionTitle.Text = title
    SectionTitle.TextColor3 = Color3.fromRGB(100, 200, 255)
    SectionTitle.TextSize = 16
    SectionTitle.Font = Enum.Font.GothamBold
    SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    SectionTitle.TextYAlignment = Enum.TextYAlignment.Bottom
    SectionTitle.Parent = Section
    
    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(1, 0, 0, 2)
    Line.Position = UDim2.new(0, 0, 1, -2)
    Line.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    Line.BorderSizePixel = 0
    Line.Parent = Section
    
    local LineCorner = Instance.new("UICorner")
    LineCorner.CornerRadius = UDim.new(1, 0)
    LineCorner.Parent = Line
    
    currentY = currentY + 50
end

-- SERVER INFO SECTION
CreateSection("📊 SERVER INFORMATION")

local ServerInfo = Instance.new("Frame")
ServerInfo.Size = UDim2.new(1, 0, 0, 130)
ServerInfo.Position = UDim2.new(0, 0, 0, currentY)
ServerInfo.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
ServerInfo.BorderSizePixel = 0
ServerInfo.Parent = ScrollFrame

local ServerInfoCorner = Instance.new("UICorner")
ServerInfoCorner.CornerRadius = UDim.new(0, 10)
ServerInfoCorner.Parent = ServerInfo

local ServerInfoStroke = Instance.new("UIStroke")
ServerInfoStroke.Color = Color3.fromRGB(50, 50, 60)
ServerInfoStroke.Thickness = 1
ServerInfoStroke.Parent = ServerInfo

local PlayerCount = Instance.new("TextLabel")
PlayerCount.Size = UDim2.new(1, -20, 0, 30)
PlayerCount.Position = UDim2.new(0, 10, 0, 10)
PlayerCount.BackgroundTransparency = 1
PlayerCount.Text = "👥 Players: 0/0"
PlayerCount.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerCount.TextSize = 14
PlayerCount.Font = Enum.Font.GothamSemibold
PlayerCount.TextXAlignment = Enum.TextXAlignment.Left
PlayerCount.Parent = ServerInfo

local ServerID = Instance.new("TextLabel")
ServerID.Size = UDim2.new(1, -20, 0, 30)
ServerID.Position = UDim2.new(0, 10, 0, 45)
ServerID.BackgroundTransparency = 1
ServerID.Text = "🔗 Job ID: Loading..."
ServerID.TextColor3 = Color3.fromRGB(200, 200, 200)
ServerID.TextSize = 12
ServerID.Font = Enum.Font.Gotham
ServerID.TextXAlignment = Enum.TextXAlignment.Left
ServerID.Parent = ServerInfo

local ServerRegion = Instance.new("TextLabel")
ServerRegion.Size = UDim2.new(1, -20, 0, 30)
ServerRegion.Position = UDim2.new(0, 10, 0, 75)
ServerRegion.BackgroundTransparency = 1
ServerRegion.Text = "🌍 Region: Unknown"
ServerRegion.TextColor3 = Color3.fromRGB(200, 200, 200)
ServerRegion.TextSize = 12
ServerRegion.Font = Enum.Font.Gotham
ServerRegion.TextXAlignment = Enum.TextXAlignment.Left
ServerRegion.Parent = ServerInfo

local Ping = Instance.new("TextLabel")
Ping.Size = UDim2.new(1, -20, 0, 30)
Ping.Position = UDim2.new(0, 10, 0, 105)
Ping.BackgroundTransparency = 1
Ping.Text = "📶 Ping: 0ms"
Ping.TextColor3 = Color3.fromRGB(150, 255, 150)
Ping.TextSize = 13
Ping.Font = Enum.Font.GothamSemibold
Ping.TextXAlignment = Enum.TextXAlignment.Left
Ping.Parent = ServerInfo

currentY = currentY + 140

-- FISHING SECTION
CreateSection("🎣 FISHING FEATURES")

-- Function untuk toggle
local function CreateToggle(name, description, configKey)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 75)
    ToggleFrame.Position = UDim2.new(0, 0, 0, currentY)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = ScrollFrame
    
    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 10)
    FrameCorner.Parent = ToggleFrame
    
    local FrameStroke = Instance.new("UIStroke")
    FrameStroke.Color = Color3.fromRGB(50, 50, 60)
    FrameStroke.Thickness = 1
    FrameStroke.Parent = ToggleFrame
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -80, 0, 25)
    NameLabel.Position = UDim2.new(0, 12, 0, 10)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameLabel.TextSize = 14
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = ToggleFrame
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -80, 0, 35)
    DescLabel.Position = UDim2.new(0, 12, 0, 35)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = description
    DescLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    DescLabel.TextSize = 11
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.TextWrapped = true
    DescLabel.Parent = ToggleFrame
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 60, 0, 32)
    ToggleBtn.Position = UDim2.new(1, -72, 0.5, -16)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.TextSize = 12
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Parent = ToggleFrame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = ToggleBtn
    
    ToggleBtn.MouseButton1Click:Connect(function()
        Config[configKey] = not Config[configKey]
        if Config[configKey] then
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 255, 60)
            ToggleBtn.Text = "ON"
        else
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            ToggleBtn.Text = "OFF"
        end
    end)
    
    currentY = currentY + 85
end

-- Function untuk slider dengan +/- buttons
local function CreateAdjuster(name, description, min, max, default, step, configKey)
    local AdjusterFrame = Instance.new("Frame")
    AdjusterFrame.Size = UDim2.new(1, 0, 0, 90)
    AdjusterFrame.Position = UDim2.new(0, 0, 0, currentY)
    AdjusterFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    AdjusterFrame.BorderSizePixel = 0
    AdjusterFrame.Parent = ScrollFrame
    
    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 10)
    FrameCorner.Parent = AdjusterFrame
    
    local FrameStroke = Instance.new("UIStroke")
    FrameStroke.Color = Color3.fromRGB(50, 50, 60)
    FrameStroke.Thickness = 1
    FrameStroke.Parent = AdjusterFrame
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -20, 0, 25)
    NameLabel.Position = UDim2.new(0, 12, 0, 8)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameLabel.TextSize = 14
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = AdjusterFrame
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -20, 0, 20)
    DescLabel.Position = UDim2.new(0, 12, 0, 32)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = description
    DescLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    DescLabel.TextSize = 11
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = AdjusterFrame
    
    -- Value display
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0, 80, 0, 32)
    ValueLabel.Position = UDim2.new(0.5, -40, 0, 55)
    ValueLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    ValueLabel.TextSize = 16
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Parent = AdjusterFrame
    
    local ValueCorner = Instance.new("UICorner")
    ValueCorner.CornerRadius = UDim.new(0, 8)
    ValueCorner.Parent = ValueLabel
    
    -- Minus button
    local MinusBtn = Instance.new("TextButton")
    MinusBtn.Size = UDim2.new(0, 35, 0, 32)
    MinusBtn.Position = UDim2.new(0, 12, 0, 55)
    MinusBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    MinusBtn.Text = "<"
    MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinusBtn.TextSize = 18
    MinusBtn.Font = Enum.Font.GothamBold
    MinusBtn.Parent = AdjusterFrame
    
    local MinusCorner = Instance.new("UICorner")
    MinusCorner.CornerRadius = UDim.new(0, 8)
    MinusCorner.Parent = MinusBtn
    
    -- Plus button
    local PlusBtn = Instance.new("TextButton")
    PlusBtn.Size = UDim2.new(0, 35, 0, 32)
    PlusBtn.Position = UDim2.new(1, -47, 0, 55)
    PlusBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
    PlusBtn.Text = ">"
    PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    PlusBtn.TextSize = 18
    PlusBtn.Font = Enum.Font.GothamBold
    PlusBtn.Parent = AdjusterFrame
    
    local PlusCorner = Instance.new("UICorner")
    PlusCorner.CornerRadius = UDim.new(0, 8)
    PlusCorner.Parent = PlusBtn
    
    MinusBtn.MouseButton1Click:Connect(function()
        local current = Config[configKey]
        local newValue = math.max(min, current - step)
        Config[configKey] = newValue
        ValueLabel.Text = tostring(newValue)
    end)
    
    PlusBtn.MouseButton1Click:Connect(function()
        local current = Config[configKey]
        local newValue = math.min(max, current + step)
        Config[configKey] = newValue
        ValueLabel.Text = tostring(newValue)
    end)
    
    currentY = currentY + 100
end

CreateToggle("⚡ Instant Fish", "Langsung dapat ikan tanpa delay casting", "InstantFish")
CreateToggle("🚫 No Animation", "Matikan semua animasi fishing untuk performa", "NoAnimation")
CreateToggle("🔄 Auto Fish", "Otomatis fishing loop terus menerus", "AutoFish")
CreateAdjuster("⏱️ Fish Delay", "Delay antara setiap cast (detik)", 0.1, 5, 0.1, 0.1, "FishDelay")

-- CHARACTER SECTION
CreateSection("🏃 CHARACTER SETTINGS")

CreateAdjuster("🏃 Walk Speed", "Kecepatan berjalan karakter", 16, 200, 16, 4, "WalkSpeed")
CreateAdjuster("🦘 Jump Power", "Tinggi lompatan karakter", 50, 200, 50, 5, "JumpPower")

-- Note Section
local NoteFrame = Instance.new("Frame")
NoteFrame.Size = UDim2.new(1, 0, 0, 80)
NoteFrame.Position = UDim2.new(0, 0, 0, currentY)
NoteFrame.BackgroundColor3 = Color3.fromRGB(30, 120, 200)
NoteFrame.BorderSizePixel = 0
NoteFrame.Parent = ScrollFrame

local NoteCorner = Instance.new("UICorner")
NoteCorner.CornerRadius = UDim.new(0, 10)
NoteCorner.Parent = NoteFrame

local NoteGradient = Instance.new("UIGradient")
NoteGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 100, 200))
}
NoteGradient.Rotation = 45
NoteGradient.Parent = NoteFrame

local NoteIcon = Instance.new("TextLabel")
NoteIcon.Size = UDim2.new(0, 40, 0, 40)
NoteIcon.Position = UDim2.new(0, 10, 0.5, -20)
NoteIcon.BackgroundTransparency = 1
NoteIcon.Text = "💙"
NoteIcon.TextSize = 28
NoteIcon.Parent = NoteFrame

local NoteText = Instance.new("TextLabel")
NoteText.Size = UDim2.new(1, -60, 1, -20)
NoteText.Position = UDim2.new(0, 55, 0, 10)
NoteText.BackgroundTransparency = 1
NoteText.Text = "Terimakasih udah gunain\nscript ikyy beta ❤️"
NoteText.TextColor3 = Color3.fromRGB(255, 255, 255)
NoteText.TextSize = 14
NoteText.Font = Enum.Font.GothamBold
NoteText.TextXAlignment = Enum.TextXAlignment.Left
NoteText.TextYAlignment = Enum.TextYAlignment.Center
NoteText.Parent = NoteFrame

-- Update Server Info
spawn(function()
    while task.wait(1) do
        pcall(function()
            PlayerCount.Text = "👥 Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers
            
            local jobId = game.JobId
            if jobId and jobId ~= "" then
                ServerID.Text = "🔗 Job ID: " .. jobId:sub(1, 20) .. "..."
            end
            
            local region = game:GetService("LocalizationService").RobloxLocaleId
            ServerRegion.Text = "🌍 Region: " .. region:upper()
            
            local stats = game:GetService("Stats")
            local ping = stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
            local pingNum = tonumber(ping:match("%d+")) or 0
            Ping.Text = "📶 Ping: " .. math.floor(pingNum) .. "ms"
            
            if pingNum < 100 then
                Ping.TextColor3 = Color3.fromRGB(150, 255, 150)
            elseif pingNum < 200 then
                Ping.TextColor3 = Color3.fromRGB(255, 255, 150)
            else
                Ping.TextColor3 = Color3.fromRGB(255, 150, 150)
            end
        end)
    end
end)

-- Apply Speed and Jump
RunService.Heartbeat:Connect(function()
    pcall(function()
        local char = Player.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = Config.WalkSpeed
                humanoid.JumpPower = Config.JumpPower
            end
        end
    end)
end)

-- No Animation
RunService.Heartbeat:Connect(function()
    if Config.NoAnimation then
        pcall(function()
            local char = Player.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid:FindFirstChild("Animator") then
                    for _, track in pairs(humanoid.Animator:GetPlayingAnimationTracks()) do
                        track:Stop()
                    end
                end
            end
        end)
    end
end)

-- Fishing Functions
local function getRod()
    if Player.Character then
        for _, v in pairs(Player.Character:GetChildren()) do
            if v:IsA("Tool") and v:FindFirstChild("events") then
                return v
            end
        end
    end
    for _, v in pairs(Player.Backpack:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("events") then
            return v
        end
    end
    return nil
end

local function equipRod(rod)
    if rod and rod.Parent == Player.Backpack then
        Player.Character.Humanoid:EquipTool(rod)
        task.wait(0.3)
        return true
    end
    return rod and rod.Parent == Player.Character
end

local isFishing = false

local function InstantFish()
    if isFishing then return end
    isFishing = true
    
    task.spawn(function()
        pcall(function()
            local rod = getRod()
            if not rod then 
                isFishing = false
                return 
            end
            
         
