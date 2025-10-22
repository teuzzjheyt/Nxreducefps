-- BRAINROT PARA 4 ITENS ESPECÍFICOS
local enabled = false
local player = game.Players.LocalPlayer

-- Variável para controlar a mensagem atual
local currentMessageGUI = nil
local isAnimating = false
local lastToggleTime = 0

-- Função para mostrar mensagem flutuante na tela com animação
local function showMessage(text)
    -- Verifica se pode criar nova mensagem
    if isAnimating then
        return false
    end
    
    isAnimating = true
    
    -- Remove mensagem anterior se existir
    if currentMessageGUI and currentMessageGUI.Parent then
        currentMessageGUI:Destroy()
        currentMessageGUI = nil
    end
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "MessageGUI"
    gui.Parent = player:WaitForChild("PlayerGui")
    currentMessageGUI = gui
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 300, 0, 50)
    label.Position = UDim2.new(0.5, 0, 0.3, -60) -- Centralizado horizontalmente
    label.AnchorPoint = Vector2.new(0.5, 0.5) -- Âncora no centro
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 24
    label.TextStrokeTransparency = 0.8
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextTransparency = 1 -- Começa invisível
    label.TextXAlignment = Enum.TextXAlignment.Center -- Texto centralizado
    label.TextYAlignment = Enum.TextYAlignment.Center -- Texto centralizado verticalmente
    label.Parent = gui
    
    -- Variável para controlar a animação RGB
    local rgbRunning = true
    
    -- Animação RGB no texto
    task.spawn(function()
        local hue = 0
        while rgbRunning and label and label.Parent do
            local color = Color3.fromHSV(hue, 1, 1)
            label.TextColor3 = color
            hue = (hue + 0.08) % 1
            task.wait(0.02)
        end
    end)
    
    -- Animação de entrada (fade in)
    local tweenIn = game:GetService("TweenService"):Create(label, TweenInfo.new(0.3), {
        TextTransparency = 0
    })
    
    tweenIn:Play()
    
    -- Timer para animação de saída
    local animationEndTime = os.time() + 2 -- 2 segundos no total
    
    task.spawn(function()
        tweenIn.Completed:Wait()
        
        -- Espera o tempo restante
        local timeLeft = animationEndTime - os.time()
        if timeLeft > 0 then
            task.wait(timeLeft)
        end
        
        -- Animação de saída (fade out)
        if label and label.Parent then
            rgbRunning = false
            local tweenOut = game:GetService("TweenService"):Create(label, TweenInfo.new(0.3), {
                TextTransparency = 1
            })
            tweenOut:Play()
            tweenOut.Completed:Wait()
        end
        
        -- Limpeza final
        if gui and gui.Parent then
            gui:Destroy()
        end
        if currentMessageGUI == gui then
            currentMessageGUI = nil
        end
        isAnimating = false
    end)
    
    return true
end

-- Função para alternar com debounce
local function toggleBrainrot()
    local currentTime = os.time()
    
    -- Debounce de 0.5 segundos
    if currentTime - lastToggleTime < 0.5 then
        return
    end
    
    lastToggleTime = currentTime
    enabled = not enabled
    
    if enabled then
        showMessage("FPS DEVOUR ATIVADO")
    else
        showMessage("FPS DEVOUR DESATIVADO")
    end
    print(enabled and "Brainrot ativado (4 Slaps)" or "Brainrot desativado")
end

-- Keybind Q
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Q then
        toggleBrainrot()
    end
end)

-- Lista de slaps para equipar
local slapNames = {
    "Dark Matter Slap",
    "Flame Slap", 
    "Galaxy Slap",
    "Glitched Slap"
}

-- Função para manter todos os slaps equipados
local function maintainAllSlaps()
    local char = player.Character
    local backpack = player:FindFirstChild("Backpack")
    
    if not char or not backpack then return end

    -- Verificar cada slap e garantir que permaneça no character
    for _, slapName in ipairs(slapNames) do
        local slap = backpack:FindFirstChild(slapName)
        if slap then
            pcall(function()
                slap.Parent = char
            end)
        else
            slap = char:FindFirstChild(slapName)
            if slap then
                pcall(function()
                    if slap.Parent ~= char then
                        slap.Parent = char
                    end
                end)
            end
        end
    end
end

-- Loop principal
task.spawn(function()
    while true do
        if enabled then
            maintainAllSlaps()
            task.wait(0.05)
        else
            task.wait(0.2)
        end
    end
end)

-- Reconectar quando o personagem morrer
player.CharacterAdded:Connect(function()
    task.wait(2)
end)

corrija agora ao inves segurar toda faz com que vai trocando todas entre os tapas
