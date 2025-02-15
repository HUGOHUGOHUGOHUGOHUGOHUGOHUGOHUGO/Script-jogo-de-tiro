local Players = game:GetService("Players")

-- Função que cria a Tool (bloco arma)
local function criarArma()
    local tool = Instance.new("Tool")
    tool.Name = "BlocoArma"
    tool.RequiresHandle = true  -- Define que a Tool precisa de um Handle

    -- Criação do Handle (o bloco que representa a arma)
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(4, 4, 4)  -- Ajuste o tamanho conforme necessário
    handle.BrickColor = BrickColor.new("Really red")
    handle.Material = Enum.Material.Metal
    handle.TopSurface = Enum.SurfaceType.Smooth
    handle.BottomSurface = Enum.SurfaceType.Smooth
    handle.Parent = tool

    -- Evento de ataque ao ativar a ferramenta
    tool.Activated:Connect(function()
        print("Ataque com o BlocoArma!")
        -- Aqui você pode adicionar animações ou efeitos especiais
    end)

    -- Variável para evitar múltiplos danos consecutivos
    local debounce = {}

    -- Evento que aplica dano quando a arma toca um personagem
    handle.Touched:Connect(function(hit)
        local character = hit.Parent
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        
        -- Evita dano no próprio dono da arma
        if humanoid and character ~= tool.Parent then
            if not debounce[humanoid] or tick() - debounce[humanoid] > 1 then
                humanoid:TakeDamage(20)  -- Ajuste o dano conforme necessário
                debounce[humanoid] = tick()
            end
        end
    end)

    return tool
end

-- Função para dar a arma ao jogador
local function darArma(jogador)
    if jogador and jogador.Character then
        local mochila = jogador:FindFirstChild("Backpack")
        if mochila then
            -- Remove a arma anterior (caso já tenha) para evitar duplicação
            local armaExistente = mochila:FindFirstChild("BlocoArma")
            if armaExistente then
                armaExistente:Destroy()
            end
            
            -- Adiciona a nova arma ao jogador
            local novaArma = criarArma()
            novaArma.Parent = mochila
        end
    end
end

-- Quando um jogador entra no jogo, recebe a arma automaticamente
Players.PlayerAdded:Connect(function(jogador)
    jogador.CharacterAdded:Connect(function()
        darArma(jogador)
    end)
end)
