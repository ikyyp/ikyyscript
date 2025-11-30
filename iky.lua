-- Fisch Auto Farm Script dengan UI
-- Fitur: UI Toggle, Instant Cast, Auto Reel, Fast Catch

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Pengaturan
local Config = {
    AutoFish = false,
    InstantCast = false,
    AutoReel = false,
    AutoShake = false,
    FastReel = false
}

-- Buat ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FischAutoFarmUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Frame utama
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Corner untuk frame
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🎣 Fisch Auto Farm"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

local CloseBtnCorner = Instance.new("UICorner")
CloseBtnCorner.CornerRadius = UDim.new(0, 6)
CloseBtnCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Container untuk buttons
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -20, 1, -60)
Container.Position = UDim2.new(0, 10, 0, 50)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

-- Fungsi untuk membuat toggle button
local function CreateToggle(name, position, configKey)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 45)
    ToggleFrame.Position = position
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = Container
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -70, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 50, 0, 30)
    ToggleBtn.Position = UDim2.new(1, -60, 0.5, -15)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.TextSize = 12
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Parent = ToggleFrame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
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
    
    return ToggleFrame
end

-- Buat toggles
CreateToggle("Auto Fish", UDim2.new(0, 0, 0, 0), "AutoFish")
CreateToggle("Instant Cast", UDim2.new(0, 0, 0, 55), "InstantCast")
CreateToggle("Auto Reel", UDim2.new(0, 0, 0, 110), "AutoReel")
CreateToggle("Auto Shake", UDim2.new(0, 0, 0, 165), "AutoShake")
CreateToggle("Fast Reel", UDim2.new(0, 0, 0, 220), "FastReel")

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 1, -35)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Idle"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = Container

-- Fungsi untuk update status
local function UpdateStatus(text)
    StatusLabel.Text = "Status: " .. text
end

-- Fungsi untuk mendapatkan FishingRod
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

-- Fungsi Instant Cast
local function InstantCast()
    local rod = getRod()
    if not rod then return false end
    
    if rod.Parent == Player.Backpack then
        Player.Character.Humanoid:EquipTool(rod)
        wait(0.1)
    end
    
    local events = rod:FindFirstChild("events")
    if events then
        local cast = events:FindFirstChild("cast")
        if cast then
            cast:FireServer(100, 1)
            UpdateStatus("Casting...")
            return true
        end
    end
    return false
end

-- Fungsi Auto Reel
local function AutoReel()
    local reel = PlayerGui:FindFirstChild("reel")
    
    if reel and reel.Enabled then
        local rod = getRod()
        if rod then
            local events = rod:FindFirstChild("events")
            if events then
                local reelfinished = events:FindFirstChild("reelfinished")
                if reelfinished then
                    UpdateStatus("Reeling...")
                    if Config.FastReel then
                        reelfinished:FireServer(100, true)
                    else
                        reelfinished:FireServer(100, true)
                    end
                    return true
                end
            end
        end
    end
    return false
end

-- Fungsi Auto Shake
local function AutoShake()
    local shakeUI = PlayerGui:FindFirstChild("shakeui")
    
    if shakeUI and shakeUI.Enabled then
        local rod = getRod()
        if rod then
            local events = rod:FindFirstChild("events")
            if events then
                local shake = events:FindFirstChild("shake")
                if shake then
                    UpdateStatus("Shaking...")
                    for i = 1, 15 do
                        shake:FireServer()
                        wait(0.03)
                    end
                    return true
                end
            end
        end
    end
    return false
end

-- Loop utama
spawn(function()
    UpdateStatus("Ready!")
    while wait(0.1) do
        if Config.AutoFish then
            pcall(function()
                local reel = PlayerGui:FindFirstChild("reel")
                local shakeui = PlayerGui:FindFirstChild("shakeui")
                
                if Config.AutoShake and shakeui and shakeui.Enabled then
                    AutoShake()
                elseif Config.AutoReel and reel and reel.Enabled then
                    AutoReel()
                elseif Config.InstantCast then
                    if not (reel and reel.Enabled) and not (shakeui and shakeui.Enabled) then
                        InstantCast()
                        wait(0.5)
                    end
                end
            end)
        else
            UpdateStatus("Idle")
        end
    end
end)

-- Notifikasi
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Fisch Auto Farm",
    Text = "UI berhasil dimuat! Drag untuk memindahkan.",
    Duration = 5
})

print("Fisch Auto Farm UI loaded!")
