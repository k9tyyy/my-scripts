-- K9TYGROUP Script for Xeno
-- AutoDeath Money Transfer System
-- Currency: 5000 per death/reset

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

-- Colors
local Colors = {
    Background = Color3.fromRGB(20, 20, 25),
    Secondary = Color3.fromRGB(30, 30, 35),
    Accent = Color3.fromRGB(88, 101, 242),
    AccentHover = Color3.fromRGB(110, 122, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(160, 160, 170),
    Success = Color3.fromRGB(46, 204, 113),
    Danger = Color3.fromRGB(231, 76, 60),
    Warning = Color3.fromRGB(241, 196, 15),
    Border = Color3.fromRGB(50, 50, 60)
}

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "K9TYGROUP_AutoDeath"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 500)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -250)
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Colors.Secondary
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -80, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "K9TYGROUP"
TitleText.TextColor3 = Colors.Text
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local SubtitleText = Instance.new("TextLabel")
SubtitleText.Size = UDim2.new(1, -80, 0, 15)
SubtitleText.Position = UDim2.new(0, 15, 0, 25)
SubtitleText.BackgroundTransparency = 1
SubtitleText.Text = "AutoDeath Transfer System"
SubtitleText.TextColor3 = Colors.TextSecondary
SubtitleText.Font = Enum.Font.Gotham
SubtitleText.TextSize = 11
SubtitleText.TextXAlignment = Enum.TextXAlignment.Left
SubtitleText.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -65, 0, 8)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Colors.Text
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = TitleBar

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeButton

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 8)
CloseButton.BackgroundColor3 = Colors.Danger
CloseButton.BorderSizePixel = 0
CloseButton.Text = "✕"
CloseButton.TextColor3 = Colors.Text
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Player Selection Section
local PlayerSection = Instance.new("Frame")
PlayerSection.Size = UDim2.new(1, -30, 0, 80)
PlayerSection.Position = UDim2.new(0, 15, 0, 55)
PlayerSection.BackgroundColor3 = Colors.Secondary
PlayerSection.BorderSizePixel = 0
PlayerSection.Parent = MainFrame

local PlayerSectionCorner = Instance.new("UICorner")
PlayerSectionCorner.CornerRadius = UDim.new(0, 8)
PlayerSectionCorner.Parent = PlayerSection

local PlayerLabel = Instance.new("TextLabel")
PlayerLabel.Size = UDim2.new(1, -20, 0, 20)
PlayerLabel.Position = UDim2.new(0, 10, 0, 8)
PlayerLabel.BackgroundTransparency = 1
PlayerLabel.Text = "🎯 Выберите игрока"
PlayerLabel.TextColor3 = Colors.Text
PlayerLabel.Font = Enum.Font.GothamBold
PlayerLabel.TextSize = 12
PlayerLabel.TextXAlignment = Enum.TextXAlignment.Left
PlayerLabel.Parent = PlayerSection

local PlayerDropdown = Instance.new("TextButton")
PlayerDropdown.Size = UDim2.new(1, -20, 0, 35)
PlayerDropdown.Position = UDim2.new(0, 10, 0, 33)
PlayerDropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
PlayerDropdown.BorderSizePixel = 0
PlayerDropdown.Text = "Нажмите для выбора..."
PlayerDropdown.TextColor3 = Colors.TextSecondary
PlayerDropdown.Font = Enum.Font.Gotham
PlayerDropdown.TextSize = 13
PlayerDropdown.Parent = PlayerSection

local DropdownCorner = Instance.new("UICorner")
DropdownCorner.CornerRadius = UDim.new(0, 6)
DropdownCorner.Parent = PlayerDropdown

local ArrowIndicator = Instance.new("TextLabel")
ArrowIndicator.Size = UDim2.new(0, 20, 0, 20)
ArrowIndicator.Position = UDim2.new(1, -25, 0, 7)
ArrowIndicator.BackgroundTransparency = 1
ArrowIndicator.Text = "▼"
ArrowIndicator.TextColor3 = Colors.TextSecondary
ArrowIndicator.Font = Enum.Font.GothamBold
ArrowIndicator.TextSize = 10
ArrowIndicator.Parent = PlayerDropdown

-- Player List Container
local PlayerListContainer = Instance.new("Frame")
PlayerListContainer.Size = UDim2.new(1, -30, 0, 0)
PlayerListContainer.Position = UDim2.new(0, 15, 0, 140)
PlayerListContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
PlayerListContainer.BorderSizePixel = 0
PlayerListContainer.Visible = false
PlayerListContainer.ZIndex = 20
PlayerListContainer.ClipsDescendants = true
PlayerListContainer.Parent = MainFrame

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 8)
ListCorner.Parent = PlayerListContainer

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1, 0, 1, 0)
PlayerList.Position = UDim2.new(0, 0, 0, 0)
PlayerList.BackgroundTransparency = 1
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 4
PlayerList.ScrollBarImageColor3 = Colors.Accent
PlayerList.ZIndex = 21
PlayerList.Parent = PlayerListContainer

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = PlayerList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 4)

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingLeft = UDim.new(0, 8)
UIPadding.PaddingRight = UDim.new(0, 8)
UIPadding.PaddingTop = UDim.new(0, 8)
UIPadding.PaddingBottom = UDim.new(0, 8)
UIPadding.Parent = PlayerList

-- Money Section
local MoneySection = Instance.new("Frame")
MoneySection.Size = UDim2.new(1, -30, 0, 90)
MoneySection.Position = UDim2.new(0, 15, 0, 145)
MoneySection.BackgroundColor3 = Colors.Secondary
MoneySection.BorderSizePixel = 0
MoneySection.Parent = MainFrame

local MoneySectionCorner = Instance.new("UICorner")
MoneySectionCorner.CornerRadius = UDim.new(0, 8)
MoneySectionCorner.Parent = MoneySection

local MoneyLabel = Instance.new("TextLabel")
MoneyLabel.Size = UDim2.new(1, -20, 0, 20)
MoneyLabel.Position = UDim2.new(0, 10, 0, 8)
MoneyLabel.BackgroundTransparency = 1
MoneyLabel.Text = "💰 Сумма для передачи"
MoneyLabel.TextColor3 = Colors.Text
MoneyLabel.Font = Enum.Font.GothamBold
MoneyLabel.TextSize = 12
MoneyLabel.TextXAlignment = Enum.TextXAlignment.Left
MoneyLabel.Parent = MoneySection

local MoneyInputContainer = Instance.new("Frame")
MoneyInputContainer.Size = UDim2.new(1, -20, 0, 35)
MoneyInputContainer.Position = UDim2.new(0, 10, 0, 33)
MoneyInputContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
MoneyInputContainer.BorderSizePixel = 0
MoneyInputContainer.Parent = MoneySection

local MoneyInputCorner = Instance.new("UICorner")
MoneyInputCorner.CornerRadius = UDim.new(0, 6)
MoneyInputCorner.Parent = MoneyInputContainer

local MoneyInput = Instance.new("TextBox")
MoneyInput.Size = UDim2.new(1, -20, 1, 0)
MoneyInput.Position = UDim2.new(0, 10, 0, 0)
MoneyInput.BackgroundTransparency = 1
MoneyInput.BorderSizePixel = 0
MoneyInput.Text = "50000"
MoneyInput.TextColor3 = Colors.Text
MoneyInput.Font = Enum.Font.GothamBold
MoneyInput.TextSize = 14
MoneyInput.Parent = MoneyInputContainer

local CurrencyLabel = Instance.new("TextLabel")
CurrencyLabel.Size = UDim2.new(1, -20, 0, 15)
CurrencyLabel.Position = UDim2.new(0, 10, 0, 72)
CurrencyLabel.BackgroundTransparency = 1
CurrencyLabel.Text = "1 смерть = 5,000 валюты"
CurrencyLabel.TextColor3 = Colors.TextSecondary
CurrencyLabel.Font = Enum.Font.Gotham
CurrencyLabel.TextSize = 10
CurrencyLabel.TextXAlignment = Enum.TextXAlignment.Left
CurrencyLabel.Parent = MoneySection

-- Stats Section
local StatsSection = Instance.new("Frame")
StatsSection.Size = UDim2.new(1, -30, 0, 80)
StatsSection.Position = UDim2.new(0, 15, 0, 245)
StatsSection.BackgroundColor3 = Colors.Secondary
StatsSection.BorderSizePixel = 0
StatsSection.Parent = MainFrame

local StatsSectionCorner = Instance.new("UICorner")
StatsSectionCorner.CornerRadius = UDim.new(0, 8)
StatsSectionCorner.Parent = StatsSection

local DeathsLabel = Instance.new("TextLabel")
DeathsLabel.Size = UDim2.new(0.6, -10, 0, 30)
DeathsLabel.Position = UDim2.new(0, 10, 0, 10)
DeathsLabel.BackgroundTransparency = 1
DeathsLabel.Text = "Смертей нужно: 10"
DeathsLabel.TextColor3 = Colors.Warning
DeathsLabel.Font = Enum.Font.GothamBold
DeathsLabel.TextSize = 12
DeathsLabel.TextXAlignment = Enum.TextXAlignment.Left
DeathsLabel.Parent = StatsSection

local ProgressLabel = Instance.new("TextLabel")
ProgressLabel.Size = UDim2.new(0.4, -10, 0, 30)
ProgressLabel.Position = UDim2.new(0.6, 0, 0, 10)
ProgressLabel.BackgroundTransparency = 1
ProgressLabel.Text = "0/0"
ProgressLabel.TextColor3 = Colors.Success
ProgressLabel.Font = Enum.Font.GothamBold
ProgressLabel.TextSize = 12
ProgressLabel.TextXAlignment = Enum.TextXAlignment.Right
ProgressLabel.Parent = StatsSection

local ProgressBarBackground = Instance.new("Frame")
ProgressBarBackground.Size = UDim2.new(1, -20, 0, 8)
ProgressBarBackground.Position = UDim2.new(0, 10, 0, 45)
ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
ProgressBarBackground.BorderSizePixel = 0
ProgressBarBackground.Parent = StatsSection

local ProgressBarCorner = Instance.new("UICorner")
ProgressBarCorner.CornerRadius = UDim.new(0, 4)
ProgressBarCorner.Parent = ProgressBarBackground

local ProgressBarFill = Instance.new("Frame")
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.BackgroundColor3 = Colors.Accent
ProgressBarFill.BorderSizePixel = 0
ProgressBarFill.Parent = ProgressBarBackground

local ProgressBarFillCorner = Instance.new("UICorner")
ProgressBarFillCorner.CornerRadius = UDim.new(0, 4)
ProgressBarFillCorner.Parent = ProgressBarFill

-- Buttons Section
local ButtonsSection = Instance.new("Frame")
ButtonsSection.Size = UDim2.new(1, -30, 0, 100)
ButtonsSection.Position = UDim2.new(0, 15, 0, 335)
ButtonsSection.BackgroundColor3 = Colors.Secondary
ButtonsSection.BorderSizePixel = 0
ButtonsSection.Parent = MainFrame

local ButtonsSectionCorner = Instance.new("UICorner")
ButtonsSectionCorner.CornerRadius = UDim.new(0, 8)
ButtonsSectionCorner.Parent = ButtonsSection

local StartButton = Instance.new("TextButton")
StartButton.Size = UDim2.new(1, -20, 0, 40)
StartButton.Position = UDim2.new(0, 10, 0, 10)
StartButton.BackgroundColor3 = Colors.Success
StartButton.BorderSizePixel = 0
StartButton.Text = "▶ СТАРТ"
StartButton.TextColor3 = Colors.Text
StartButton.Font = Enum.Font.GothamBold
StartButton.TextSize = 14
StartButton.Parent = ButtonsSection

local StartCorner = Instance.new("UICorner")
StartCorner.CornerRadius = UDim.new(0, 6)
StartCorner.Parent = StartButton

local StopButton = Instance.new("TextButton")
StopButton.Size = UDim2.new(1, -20, 0, 40)
StopButton.Position = UDim2.new(0, 10, 0, 55)
StopButton.BackgroundColor3 = Colors.Danger
StopButton.BorderSizePixel = 0
StopButton.Text = "⏹ СТОП"
StopButton.TextColor3 = Colors.Text
StopButton.Font = Enum.Font.GothamBold
StopButton.TextSize = 14
StopButton.Parent = ButtonsSection

local StopCorner = Instance.new("UICorner")
StopCorner.CornerRadius = UDim.new(0, 6)
StopCorner.Parent = StopButton

-- Minimized state
local MinimizedFrame = Instance.new("Frame")
MinimizedFrame.Size = UDim2.new(0, 200, 0, 40)
MinimizedFrame.Position = UDim2.new(0, 10, 0.5, -20)
MinimizedFrame.BackgroundColor3 = Colors.Background
MinimizedFrame.BorderSizePixel = 0
MinimizedFrame.Visible = false
MinimizedFrame.Parent = ScreenGui

local MinimizedCorner = Instance.new("UICorner")
MinimizedCorner.CornerRadius = UDim.new(0, 8)
MinimizedCorner.Parent = MinimizedFrame

local RestoreButton = Instance.new("TextButton")
RestoreButton.Size = UDim2.new(1, -40, 1, 0)
RestoreButton.Position = UDim2.new(0, 10, 0, 0)
RestoreButton.BackgroundTransparency = 1
RestoreButton.Text = "K9TYGROUP ⚡"
RestoreButton.TextColor3 = Colors.Accent
RestoreButton.Font = Enum.Font.GothamBold
RestoreButton.TextSize = 14
RestoreButton.Parent = MinimizedFrame

-- Variables
local selectedPlayer = nil
local isRunning = false
local totalDeaths = 0
local currentDeaths = 0
local isDeathProcessed = false

-- Functions
local function UpdateProgressBar()
    local progress = 0
    if totalDeaths > 0 then
        progress = math.min(currentDeaths / totalDeaths, 1)
    end
    ProgressBarFill.Size = UDim2.new(progress, 0, 1, 0)
end

local function UpdateDeathsCalculation()
    local moneyAmount = tonumber(MoneyInput.Text) or 50000
    totalDeaths = math.ceil(moneyAmount / 5000)
    DeathsLabel.Text = "Смертей нужно: " .. totalDeaths
    ProgressLabel.Text = currentDeaths .. "/" .. totalDeaths
    UpdateProgressBar()
end

local function RefreshPlayerList()
    for _, child in pairs(PlayerList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local players = Players:GetPlayers()
    local totalHeight = 0
    
    for _, player in pairs(players) do
        if player ~= LocalPlayer then
            local PlayerButton = Instance.new("TextButton")
            PlayerButton.Size = UDim2.new(1, -4, 0, 30)
            PlayerButton.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
            PlayerButton.BorderSizePixel = 0
            PlayerButton.Text = "👤  " .. player.Name
            PlayerButton.TextColor3 = Colors.Text
            PlayerButton.Font = Enum.Font.Gotham
            PlayerButton.TextSize = 12
            PlayerButton.ZIndex = 22
            PlayerButton.Parent = PlayerList
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 4)
            ButtonCorner.Parent = PlayerButton
            
            PlayerButton.MouseEnter:Connect(function()
                PlayerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            end)
            
            PlayerButton.MouseLeave:Connect(function()
                PlayerButton.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
            end)
            
            PlayerButton.MouseButton1Click:Connect(function()
                selectedPlayer = player
                PlayerDropdown.Text = "👤  " .. player.Name
                PlayerListContainer.Visible = false
            end)
            
            totalHeight += 34
        end
    end
    
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 10)
end

local function FastTeleportToPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return false end
    
    local character = LocalPlayer.Character
    if not character then return false end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local targetRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if not humanoidRootPart or not targetRootPart then return false end
    
    local targetPosition = targetRootPart.Position
    
    pcall(function()
        humanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0))
    end)
    
    wait(0.2)
    
    local distance = (humanoidRootPart.Position - targetRootPart.Position).Magnitude
    if distance > 5 then
        pcall(function()
            humanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0))
        end)
        wait(0.2)
    end
    
    return true
end

local function KillCharacter()
    local character = LocalPlayer.Character
    if not character then return false end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return false end
    
    pcall(function()
        humanoid.Health = 0
    end)
    
    wait(0.1)
    
    if character and character.Parent and humanoid.Health > 0 then
        pcall(function()
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                humanoidRootPart.CFrame = humanoidRootPart.CFrame + Vector3.new(0, -500, 0)
            end
        end)
    end
    
    wait(0.2)
    
    if character and character.Parent and humanoid.Health > 0 then
        pcall(function()
            character:BreakJoints()
        end)
    end
    
    return true
end

local function DeathLoop()
    while isRunning do
        if not selectedPlayer then
            isRunning = false
            StartButton.Text = "▶ СТАРТ"
            StartButton.BackgroundColor3 = Colors.Success
            return
        end
        
        if currentDeaths >= totalDeaths then
            isRunning = false
            StartButton.Text = "▶ СТАРТ"
            StartButton.BackgroundColor3 = Colors.Success
            return
        end
        
        if selectedPlayer.Parent == nil then
            isRunning = false
            StartButton.Text = "▶ СТАРТ"
            StartButton.BackgroundColor3 = Colors.Success
            return
        end
        
        local waitTime = 0
        while not LocalPlayer.Character and waitTime < 10 and isRunning do
            wait(0.1)
            waitTime += 0.1
        end
        
        if not isRunning then return end
        
        waitTime = 0
        while waitTime < 3 and isRunning do
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") then
                break
            end
            wait(0.1)
            waitTime += 0.1
        end
        
        if not isRunning then return end
        
        local teleportSuccess = FastTeleportToPlayer(selectedPlayer)
        if not teleportSuccess then
            wait(0.5)
            continue
        end
        
        wait(0.3)
        
        isDeathProcessed = false
        KillCharacter()
        
        local deathWait = 0
        while deathWait < 3 and isRunning do
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Humanoid") or LocalPlayer.Character:FindFirstChild("Humanoid").Health <= 0 then
                isDeathProcessed = true
                break
            end
            wait(0.1)
            deathWait += 0.1
        end
        
        if isDeathProcessed then
            currentDeaths += 1
            UpdateDeathsCalculation()
        end
        
        local respawnWait = 0
        while respawnWait < 10 and isRunning do
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid.Health > 0 then
                    break
                end
            end
            wait(0.1)
            respawnWait += 0.1
        end
        
        if not LocalPlayer.Character and isRunning then
            pcall(function()
                LocalPlayer:LoadCharacter()
            end)
            wait(2)
        end
        
        wait(0.5)
    end
end

-- Event Handlers
PlayerDropdown.MouseButton1Click:Connect(function()
    RefreshPlayerList()
    PlayerListContainer.Visible = not PlayerListContainer.Visible
    if PlayerListContainer.Visible then
        PlayerListContainer.Size = UDim2.new(1, -30, 0, math.min(#Players:GetPlayers() * 34, 150))
    end
end)

MoneyInput.FocusLost:Connect(UpdateDeathsCalculation)
MoneyInput:GetPropertyChangedSignal("Text"):Connect(UpdateDeathsCalculation)

StartButton.MouseButton1Click:Connect(function()
    if not selectedPlayer then
        PlayerDropdown.Text = "Выберите игрока!"
        wait(1)
        PlayerDropdown.Text = selectedPlayer and "👤  " .. selectedPlayer.Name or "Нажмите для выбора..."
        return
    end
    
    if not isRunning then
        isRunning = true
        currentDeaths = 0
        UpdateDeathsCalculation()
        StartButton.Text = "⏳ РАБОТАЕТ..."
        StartButton.BackgroundColor3 = Colors.Warning
        coroutine.wrap(DeathLoop)()
    end
end)

StopButton.MouseButton1Click:Connect(function()
    isRunning = false
    StartButton.Text = "▶ СТАРТ"
    StartButton.BackgroundColor3 = Colors.Success
end)

CloseButton.MouseButton1Click:Connect(function()
    isRunning = false
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MinimizedFrame.Visible = true
end)

RestoreButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MinimizedFrame.Visible = false
end)

-- Hover effects
StartButton.MouseEnter:Connect(function()
    if not isRunning then
        StartButton.BackgroundColor3 = Color3.fromRGB(58, 214, 125)
    end
end)

StartButton.MouseLeave:Connect(function()
    if not isRunning then
        StartButton.BackgroundColor3 = Colors.Success
    end
end)

StopButton.MouseEnter:Connect(function()
    StopButton.BackgroundColor3 = Color3.fromRGB(241, 90, 75)
end)

StopButton.MouseLeave:Connect(function()
    StopButton.BackgroundColor3 = Colors.Danger
end)

CloseButton.MouseEnter:Connect(function()
    CloseButton.BackgroundColor3 = Color3.fromRGB(241, 90, 75)
end)

CloseButton.MouseLeave:Connect(function()
    CloseButton.BackgroundColor3 = Colors.Danger
end)

MinimizeButton.MouseEnter:Connect(function()
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
end)

MinimizeButton.MouseLeave:Connect(function()
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
end)

-- Draggable
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Auto-refresh player list
Players.PlayerAdded:Connect(RefreshPlayerList)
Players.PlayerRemoving:Connect(RefreshPlayerList)

-- Initial update
UpdateDeathsCalculation()
RefreshPlayerList()