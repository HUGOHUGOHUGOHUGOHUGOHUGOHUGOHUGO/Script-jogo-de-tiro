local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Criando a GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 200)
Frame.Position = UDim2.new(0.5, -125, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Parent = ScreenGui

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 180, 0, 40)
ToggleButton.Position = UDim2.new(0.5, -90, 0.05, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
ToggleButton.Text = "Ativar Contorno"
ToggleButton.Parent = Frame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 50, 0, 30)
CloseButton.Position = UDim2.new(1, -60, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Text = "X"
CloseButton.Parent = Frame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 200, 0, 20)
SpeedLabel.Position = UDim2.new(0.5, -100, 0.3, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Velocidade: 16"
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.Parent = Frame

local SpeedSlider = Instance.new("TextBox")
SpeedSlider.Size = UDim2.new(0, 180, 0, 30)
SpeedSlider.Position = UDim2.new(0.5, -90, 0.4, 0)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
SpeedSlider.Text = "16"
SpeedSlider.Parent = Frame

local JumpLabel = Instance.new("TextLabel")
JumpLabel.Size = UDim2.new(0, 200, 0, 20)
JumpLabel.Position = UDim2.new(0.5, -100, 0.55, 0)
JumpLabel.BackgroundTransparency = 1
JumpLabel.Text = "Poder do Pulo: 50"
JumpLabel.TextColor3 = Color3.new(1, 1, 1)
JumpLabel.Parent = Frame

local JumpSlider = Instance.new("TextBox")
JumpSlider.Size = UDim2.new(0, 180, 0, 30)
JumpSlider.Position = UDim2.new(0.5, -90, 0.65, 0)
JumpSlider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
JumpSlider.Text = "50"
JumpSlider.Parent = Frame

local isActive = false
local highlights = {}

-- Função para adicionar o efeito aos jogadores
local function applyEffect(player)
    if player ~= LocalPlayer then
        local character = player.Character
        if character and not highlights[player] then
            local highlight = Instance.new("Highlight")
            highlight.Parent = character
            highlight.FillColor = Color3.fromRGB(128, 0, 128) -- Roxo
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlights[player] = highlight

            -- Tornar o jogador visível através das paredes
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = 0.5
                end
            end
        end
    end
end

-- Função para remover o efeito
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

-- Ativar/desativar contorno
ToggleButton.MouseButton1Click:Connect(function()
    isActive = not isActive
    if isActive then
        ToggleButton.Text = "Desativar Contorno"
        for _, player in ipairs(Players:GetPlayers()) do
            applyEffect(player)
        end
        Players.PlayerAdded:Connect(applyEffect)
    else
        ToggleButton.Text = "Ativar Contorno"
        removeEffect()
    end
end)

-- Fechar a GUI
CloseButton.MouseButton1Click:Connect(function()
    Frame.Visible = false
end)

-- Atualizar velocidade
SpeedSlider.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newSpeed = tonumber(SpeedSlider.Text)
        if newSpeed and newSpeed > 0 then
            LocalPlayer.Character.Humanoid.WalkSpeed = newSpeed
            SpeedLabel.Text = "Velocidade: " .. newSpeed
        else
            SpeedSlider.Text = "16" -- Valor padrão
        end
    end
end)

-- Atualizar poder do pulo
JumpSlider.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newJump = tonumber(JumpSlider.Text)
        if newJump and newJump > 0 then
            LocalPlayer.Character.Humanoid.JumpPower = newJump
            JumpLabel.Text = "Poder do Pulo: " .. newJump
        else
            JumpSlider.Text = "50" -- Valor padrão
        end
    end
end)
