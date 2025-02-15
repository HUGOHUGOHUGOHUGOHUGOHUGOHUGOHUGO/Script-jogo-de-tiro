local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Criando a ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Frame principal do menu (usando escala para se ajustar à tela)
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.9, 0, 0.8, 0)         -- 90% da largura e 80% da altura da tela
Frame.Position = UDim2.new(0.05, 0, 0.1, 0)     -- centralizado com margem
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Parent = ScreenGui

-- Botão para fechar o menu
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.15, 0, 0.08, 0)
CloseButton.Position = UDim2.new(0.83, 0, 0.02, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Text = "X"
CloseButton.Parent = Frame

-- Botão para ativar/desativar o efeito "Carro Roxo"
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.6, 0, 0.1, 0)
ToggleButton.Position = UDim2.new(0.2, 0, 0.12, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
ToggleButton.Text = "Carro Roxo"
ToggleButton.Parent = Frame

-- Label e TextBox para Velocidade
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.9, 0, 0.05, 0)
SpeedLabel.Position = UDim2.new(0.05, 0, 0.25, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Velocidade: 16"
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.Parent = Frame

local SpeedSlider = Instance.new("TextBox")
SpeedSlider.Size = UDim2.new(0.9, 0, 0.07, 0)
SpeedSlider.Position = UDim2.new(0.05, 0, 0.31, 0)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
SpeedSlider.Text = "16"
SpeedSlider.Parent = Frame

-- Label e TextBox para Poder do Pulo
local JumpLabel = Instance.new("TextLabel")
JumpLabel.Size = UDim2.new(0.9, 0, 0.05, 0)
JumpLabel.Position = UDim2.new(0.05, 0, 0.40, 0)
JumpLabel.BackgroundTransparency = 1
JumpLabel.Text = "Poder do Pulo: 50"
JumpLabel.TextColor3 = Color3.new(1, 1, 1)
JumpLabel.Parent = Frame

local JumpSlider = Instance.new("TextBox")
JumpSlider.Size = UDim2.new(0.9, 0, 0.07, 0)
JumpSlider.Position = UDim2.new(0.05, 0, 0.46, 0)
JumpSlider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
JumpSlider.Text = "50"
JumpSlider.Parent = Frame

-- Label e TextBox para Tamanho (escala do personagem)
local SizeLabel = Instance.new("TextLabel")
SizeLabel.Size = UDim2.new(0.9, 0, 0.05, 0)
SizeLabel.Position = UDim2.new(0.05, 0, 0.55, 0)
SizeLabel.BackgroundTransparency = 1
SizeLabel.Text = "Tamanho: 1"
SizeLabel.TextColor3 = Color3.new(1, 1, 1)
SizeLabel.Parent = Frame

local SizeSlider = Instance.new("TextBox")
SizeSlider.Size = UDim2.new(0.9, 0, 0.07, 0)
SizeSlider.Position = UDim2.new(0.05, 0, 0.61, 0)
SizeSlider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
SizeSlider.Text = "1"
SizeSlider.Parent = Frame

-- Label e TextBox para Gravidade
local GravityLabel = Instance.new("TextLabel")
GravityLabel.Size = UDim2.new(0.9, 0, 0.05, 0)
GravityLabel.Position = UDim2.new(0.05, 0, 0.70, 0)
GravityLabel.BackgroundTransparency = 1
GravityLabel.Text = "Gravidade: 196.2"
GravityLabel.TextColor3 = Color3.new(1, 1, 1)
GravityLabel.Parent = Frame

local GravitySlider = Instance.new("TextBox")
GravitySlider.Size = UDim2.new(0.9, 0, 0.07, 0)
GravitySlider.Position = UDim2.new(0.05, 0, 0.76, 0)
GravitySlider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
GravitySlider.Text = "196.2"
GravitySlider.Parent = Frame

--------------------------------------------------------------------
-- Variáveis de controle e tabela para tamanho original do personagem

local isActive = false
local highlights = {}
local originalSizes = {}

local function storeOriginalSizes(character)
    originalSizes = {}
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            originalSizes[part] = part.Size
        end
    end
end

if LocalPlayer.Character then
    storeOriginalSizes(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    storeOriginalSizes(character)
end)

--------------------------------------------------------------------
-- Funções para o efeito "Carro Roxo"

local function applyEffect(player)
    if player ~= LocalPlayer then
        local character = player.Character
        if character and not highlights[player] then
            local highlight = Instance.new("Highlight")
            highlight.Parent = character
            highlight.FillColor = Color3.fromRGB(128, 0, 128) -- Roxo
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlights[player] = highlight
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = 0.5
                end
            end
        end
    end
end

local function removeEffect()
    for _, highlight in pairs(highlights) do
        if highlight then
            highlight:Destroy()
        end
    end
    highlights = {}
    for _, player in ipairs(Players:GetPlayers()) do
        local character = player.Character
        if character then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = 0
                end
            end
        end
    end
end

--------------------------------------------------------------------
-- Eventos dos botões e caixas de texto

ToggleButton.MouseButton1Click:Connect(function()
    isActive = not isActive
    if isActive then
        ToggleButton.Text = "Desativar Carro Roxo"
        for _, player in ipairs(Players:GetPlayers()) do
            applyEffect(player)
        end
        Players.PlayerAdded:Connect(applyEffect)
    else
        ToggleButton.Text = "Carro Roxo"
        removeEffect()
    end
end)

SpeedSlider.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newSpeed = tonumber(SpeedSlider.Text)
        if newSpeed and newSpeed > 0 then
            local character = LocalPlayer.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = newSpeed
            end
            SpeedLabel.Text = "Velocidade: " .. newSpeed
        else
            SpeedSlider.Text = "16"
        end
    end
end)

JumpSlider.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newJump = tonumber(JumpSlider.Text)
        if newJump and newJump > 0 then
            local character = LocalPlayer.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = newJump
            end
            JumpLabel.Text = "Poder do Pulo: " .. newJump
        else
            JumpSlider.Text = "50"
        end
    end
end)

SizeSlider.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newScale = tonumber(SizeSlider.Text)
        if newScale and newScale > 0 then
            local character = LocalPlayer.Character
            for part, origSize in pairs(originalSizes) do
                if part and part.Parent then
                    part.Size = origSize * newScale
                end
            end
            SizeLabel.Text = "Tamanho: " .. newScale
        else
            SizeSlider.Text = "1"
        end
    end
end)

GravitySlider.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newGravity = tonumber(GravitySlider.Text)
        if newGravity then
            Workspace.Gravity = newGravity
            GravityLabel.Text = "Gravidade: " .. newGravity
        else
            GravitySlider.Text = "196.2"
        end
    end
end)

--------------------------------------------------------------------
-- Botão para reabrir o menu (quando fechado)
local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0.25, 0, 0.1, 0)
OpenButton.Position = UDim2.new(0.02, 0, 0.45, 0)
OpenButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
OpenButton.Text = "Abrir Menu"
OpenButton.Parent = ScreenGui
OpenButton.Visible = false

CloseButton.MouseButton1Click:Connect(function()
    Frame.Visible = false
    OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
    Frame.Visible = true
    OpenButton.Visible = false
end)
