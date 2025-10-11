-- BRAINROT PARA 2 ITENS ESPECÍFICOS
local enabled = false
local player = game.Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Name = "TutuFPSKillGUI"
gui.Parent = player:WaitForChild("PlayerGui")

-- Container com borda cinza
local container = Instance.new("Frame")
container.Size = UDim2.new(0, 204, 0, 34) -- espaço para borda
container.Position = UDim2.new(0, 20, 0, 20)
container.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- contorno cinza
container.BorderSizePixel = 0
container.Parent = gui

local uicContainer = Instance.new("UICorner")
uicContainer.CornerRadius = UDim.new(0, 10)
uicContainer.Parent = container

-- Barra fina principal dentro do container
local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 200, 0, 30)
bar.Position = UDim2.new(0, 2, 0, 2) -- deixa espaço para a borda
bar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
bar.BorderSizePixel = 0
bar.Parent = container

local uicBar = Instance.new("UICorner")
uicBar.CornerRadius = UDim.new(0, 8)
uicBar.Parent = bar

-- Texto do toggle
local label = Instance.new("TextLabel")
label.Size = UDim2.new(0.7, 0, 1, 0)
label.Position = UDim2.new(0, 10, 0, 0)
label.BackgroundTransparency = 1
label.Text = "Tutu FPS Kill"
label.Font = Enum.Font.Gotham
label.TextSize = 16
label.TextColor3 = Color3.fromRGB(255,255,255)
label.TextXAlignment = Enum.TextXAlignment.Left
label.Parent = bar

-- Toggle estilo switch
local toggle = Instance.new("Frame")
toggle.Size = UDim2.new(0, 40, 0, 20)
toggle.Position = UDim2.new(0.75, 0, 0.5, -10)
toggle.BackgroundColor3 = Color3.fromRGB(255,0,0) -- OFF vermelho
toggle.Parent = bar

local uicToggle = Instance.new("UICorner")
uicToggle.CornerRadius = UDim.new(0, 10)
uicToggle.Parent = toggle

-- Bolinha do switch
local circle = Instance.new("Frame")
circle.Size = UDim2.new(0, 18, 0, 18)
circle.Position = UDim2.new(0, 1, 0, 1)
circle.BackgroundColor3 = Color3.fromRGB(255,255,255)
circle.Parent = toggle
local uicCircle = Instance.new("UICorner")
uicCircle.CornerRadius = UDim.new(0, 9)
uicCircle.Parent = circle

-- Função para alternar
local function toggleBrainrot()
    enabled = not enabled
    if enabled then
        toggle.BackgroundColor3 = Color3.fromRGB(0,200,0) -- ON verde
        circle:TweenPosition(UDim2.new(1, -19, 0, 1), "Out", "Quad", 0.2, true)
    else
        toggle.BackgroundColor3 = Color3.fromRGB(255,0,0) -- OFF vermelho
        circle:TweenPosition(UDim2.new(0, 1, 0, 1), "Out", "Quad", 0.2, true)
    end
    print(enabled and "Brainrot ativado (Bat + Medusa)" or "Brainrot desativado")
end

-- Clicar no toggle
toggle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        toggleBrainrot()
    end
end)

-- Keybind Q
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Q then
        toggleBrainrot()
    end
end)

-- Função para alternar os 2 itens específicos
local function switchTwoItems()
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local backpack = player:FindFirstChild("Backpack")
    if not humanoid or not backpack then return end

    local item1 = backpack:FindFirstChild("Bat") or char:FindFirstChild("Bat")
    local item2 = backpack:FindFirstChild("Medusa's Head") or char:FindFirstChild("Medusa's Head")

    if item1 and item2 then
        humanoid:EquipTool(item1)
        task.wait(0.1)  -- Reduzido para 0.1
        humanoid:EquipTool(item2)
        task.wait(0.1)  -- Reduzido para 0.1
    end
end

-- Loop principal
task.spawn(function()
    while true do
        if enabled then
            switchTwoItems()
        end
        task.wait(0.05)
    end
end)
