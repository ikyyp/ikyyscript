-- Fisch Panel UI - ikyy beta
-- Complete with Speed, Jump, and All Features

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Config
local Config = {
    InstantFish = false,
    NoAnimation = false,
    AutoFish = false,
    WalkSpeed = 16,
    JumpPower = 50
}

-- Buat ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FischPanelIkyy"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Main Panel
local Panel = Instance.new("Frame")
Panel.Name = "MainPanel"
Panel.Size = UDim2.new(0, 380, 0, 600)
Panel.Position = UDim2.new(0.5, -190, 0.5, -300)
Panel.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Panel.BorderSizePixel = 0
Panel.Active = true
Panel.Draggable = true
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
Header.Parent = Panel

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🎣 FISCH PANEL - IKYY"
Title.TextColor3 = Color3.fromRGB(100, 200, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

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

-- ScrollingFrame untuk konten
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -75)
ScrollFrame.Position = UDim2.new(0, 10, 0, 65)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 200, 255)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 880)
ScrollFrame.Parent = Panel

-- Server Info Section
local ServerInfo = Instance.new("Frame")
ServerInfo.Size = UDim2.new(1, 0, 0, 130)
ServerInfo.Position = UDim2.new(0, 0, 0, 0)
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

local InfoTitle = Instance.new("TextLabel")
InfoTitle.Size = UDim2.new(1, -20, 0, 30)
InfoTitle.Position = UDim2.new(0, 10, 0, 5)
InfoTitle.BackgroundTransparency = 1
InfoTitle.Text = "📊 SERVER INFO"
InfoTitle.TextColor3 = Color3.fromRGB(100, 200, 255)
InfoTitle.TextSize = 15
InfoTitle.Font = Enum.Font.GothamBold
InfoTitle.TextXAlignment = Enum.TextXAlignment.Left
InfoTitle.Parent = ServerInfo

local PlayerCount = Instance.new("TextLabel")
PlayerCount.Size = UDim2.new(1, -20, 0, 25)
PlayerCount.Position = UDim2.new(0, 10, 0, 40)
PlayerCount.BackgroundTransparency = 1
PlayerCount.Text = "👥 Players: 0/0"
PlayerCount.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerCount.TextSize = 13
PlayerCount.Font = Enum.Font.Gotham
PlayerCount.TextXAlignment = Enum.TextXAlignment.Left
PlayerCount.Parent = ServerInfo

local ServerID = Instance.new("TextLabel")
ServerID.Size = UDim2.new(1, -20, 0, 25)
ServerID.Position = UDim2.new(0, 10, 0, 68)
ServerID.BackgroundTransparency = 1
ServerID.Text = "🔗 Job ID: Loading..."
ServerID.TextColor3 = Color3.fromRGB(200, 200, 200)
ServerID.TextSize = 11
ServerID.Font = Enum.Font.Gotham
ServerID.TextXAlignment = Enum.TextXAlignment.Left
ServerID.Parent = ServerInfo

local Ping = Instance.new("TextLabel")
Ping.Size = UDim2.new(1, -20, 0, 25)
Ping.Position = UDim2.new(0, 10, 0, 96)
Ping.BackgroundTransparency = 1
Ping.Text = "📶 Ping: 0ms"
Ping.TextColor3 = Color3.fromRGB(150, 255, 150)
Ping.TextSize = 13
Ping.Font = Enum.Font.Gotham
Ping.TextXAlignment = Enum.TextXAlignment.Left
Ping.Parent = ServerInfo

-- Function untuk membuat toggle
local currentY = 140
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

-- Function untuk membuat slider
local function CreateSlider(name, description, min, max, default, configKey)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 90)
    SliderFrame.Position = UDim2.new(0, 0, 0, currentY)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = ScrollFrame
    
    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 10)
    FrameCorner.Parent = SliderFrame
    
    local FrameStroke = Instance.new("UIStroke")
    FrameStroke.Color = Color3.fromRGB(50, 50, 60)
    FrameStroke.Thickness = 1
    FrameStroke.Parent = SliderFrame
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -80, 0, 25)
    NameLabel.Position = UDim2.new(0, 12, 0, 8)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameLabel.TextSize = 14
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = SliderFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0, 60, 0, 25)
    ValueLabel.Position = UDim2.new(1, -72, 0, 8)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    ValueLabel.TextSize = 13
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Parent = SliderFrame
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -20, 0, 20)
    DescLabel.Position = UDim2.new(0, 12, 0, 32)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = description
    DescLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    DescLabel.TextSize = 11
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = SliderFrame
    
    local SliderBack = Instance.new("Frame")
    SliderBack.Size = UDim2.new(1, -24, 0, 8)
    SliderBack.Position = UDim2.new(0, 12, 0, 62)
    SliderBack.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    SliderBack.BorderSizePixel = 0
    SliderBack.Parent = SliderFrame
    
    local SliderBackCorner = Instance.new("UICorner")
    SliderBackCorner.CornerRadius = UDim.new(1, 0)
    SliderBackCorner.Parent = SliderBack
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBack
    
    local SliderFillCorner = Instance.new("UICorner")
    SliderFillCorner.CornerRadius = UDim.new(1, 0)
    SliderFillCorner.Parent = SliderFill
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(1, 0, 1, 0)
    SliderButton.BackgroundTransparency = 1
    SliderButton.Text = ""
    SliderButton.Parent = SliderBack
    
    local dragging = false
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
            SliderFill.Size = UDim2.new(pos, 0, 1, 0)
            local value = math.floor(min + (max - min) * pos)
            ValueLabel.Text = tostring(value)
            Config[configKey] = value
        end
    end)
    
    currentY = currentY + 100
end

-- Create Toggles
CreateToggle("⚡ Instant Fish", "Langsung dapat ikan tanpa delay casting", "InstantFish")
CreateToggle("🚫 No Animation", "Matikan semua animasi fishing untuk performa", "NoAnimation")
CreateToggle("🔄 Auto Fish", "Otomatis fishing loop terus menerus", "AutoFish")

-- Create Sliders
CreateSlider("🏃 Walk Speed", "Atur kecepatan berjalan karakter", 16, 200, 16, "WalkSpeed")
CreateSlider("🦘 Jump Power", "Atur tinggi lompatan karakter", 50, 200, 50, "JumpPower")

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
    while wait(1) do
        pcall(function()
            local currentPlayers = #Players:GetPlayers()
            local maxPlayers = Players.MaxPlayers
            PlayerCount.Text = "👥 Players: " .. currentPlayers .. "/" .. maxPlayers
            
            local jobId = game.JobId
            if jobId and jobId ~= "" then
                ServerID.Text = "🔗 Job ID: " .. jobId:sub(1, 25) .. "..."
            end
            
            local ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
            Ping.Text = "📶 Ping: " .. ping .. "ms"
            
            if ping < 100 then
                Ping.TextColor3 = Color3.fromRGB(150, 255, 150)
            elseif ping < 200 then
                Ping.TextColor3 = Color3.fromRGB(255, 255, 150)
            else
                Ping.TextColor3 = Color3.fromRGB(255, 150, 150)
            end
        end)
    end
end)

-- Get Rod Function
local function getRod()
    local char = Player.Character
    if not char then return nil end
    
    for _, tool in pairs(char:GetChildren()) do
        if tool:IsA("Tool") and (tool.Name:lower():find("rod") or tool.Name:lower():find("fishing")) then
            return tool
        end
    end
    
    for _, tool in pairs(Player.Backpack:GetChildren()) do
        if tool:IsA("Tool") and (tool.Name:lower():find("rod") or tool.Name:lower():find("fishing")) then
            return tool
        end
    end
    
    return nil
end

-- Apply Speed and Jump
spawn(function()
    while wait(0.1) do
        pcall(function()
            local char = Player.Character
            if char then
                local humanoid = char:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = Config.WalkSpeed
                    humanoid.JumpPower = Config.JumpPower
                end
            end
        end)
    end
end)

-- No Animation Function
spawn(function()
    while wait(0.1) do
        if Config.NoAnimation then
            pcall(function()
                local char = Player.Character
                if char then
                    local humanoid = char:FindFirstChild("Humanoid")
                    if humanoid then
                        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                            if track.Name:lower():find("fish") or 
                               track.Name:lower():find("cast") or 
                               track.Name:lower():find("reel") then
                                track:Stop()
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Instant Fish Function
local function DoInstantFish()
    pcall(function()
        local rod = getRod()
        if not rod then return end
        
        -- Equip rod
        if rod.Parent == Player.Backpack then
            Player.Character.Humanoid:EquipTool(rod)
            wait(0.05)
        end
        
        local events = rod:FindFirstChild("events")
        if not events then return end
        
        -- Cast
        local cast = events:FindFirstChild("cast")
        if cast then
            cast:FireServer(100, 1)
        end
        
        wait(0.15)
        
        -- Auto Reel
        local reel = PlayerGui:FindFirstChild("reel")
        if reel and reel.Enabled then
            local reelfinished = events:FindFirstChild("reelfinished")
            if reelfinished then
                reelfinished:FireServer(100, true)
            end
        end
        
        -- Auto Shake
        local shakeui = PlayerGui:FindFirstChild("shakeui")
        if shakeui and shakeui.Enabled then
            local shake = events:FindFirstChild("shake")
            if shake then
                for i = 1, 25 do
                    shake:FireServer()
                    wait(0.02)
                end
            end
        end
    end)
end

-- Manual Instant Fish
spawn(function()
    while wait(0.1) do
        if Config.InstantFish and not Config.AutoFish then
            DoInstantFish()
        end
    end
end)

-- Auto Fish Loop
spawn(function()
    while wait(0.6) do
        if Config.AutoFish then
            DoInstantFish()
        end
    end
end)

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🎣 Fisch Panel - ikyy",
    Text = "Script berhasil dimuat! Selamat fishing!",
    Duration = 5
})

print("=================================")
print("Fisch Panel by ikyy - Loaded!")
print("Terimakasih udah pakai script ini")
print("=================================")
