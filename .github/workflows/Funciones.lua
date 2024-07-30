local Functions = {}

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

function Functions.IncreaseWalkSpeed()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = humanoid.WalkSpeed == 120 and 16 or 120
    end
end

function Functions.KillAll()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end

    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local players = game.Players:GetPlayers()

    for _, targetPlayer in ipairs(players) do
        if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetRootPart = targetPlayer.Character.HumanoidRootPart
            
            -- Teletransportar al jugador objetivo frente al jugador local
            local offset = humanoidRootPart.CFrame.LookVector * 10 -- Ajusta la distancia según sea necesario
            targetRootPart.CFrame = humanoidRootPart.CFrame + offset
            
            -- Desactivar la física para mantener la posición fija
            targetRootPart.Anchored = true
        end
    end
end

function Functions.KillAllV2(stateTable)
    if stateTable["Kill All v2"] then
        local function teleportBehind(targetPlayer)
            local character = player.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            local targetRootPart = targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart and targetRootPart then
                rootPart.CFrame = targetRootPart.CFrame * CFrame.new(0, 0, 5)
            end
        end

        while stateTable["Kill All v2"] do
            local players = game.Players:GetPlayers()
            for _, targetPlayer in ipairs(players) do
                if targetPlayer ~= player then
                    teleportBehind(targetPlayer)
                end
            end
            wait(1) -- Esperar 1 segundo antes de teleportar de nuevo
        end
    else
        print("Kill All v2 desactivado")
    end
end

function Functions.RainbowBody(stateTable)
    local character = player.Character
    if not character then return end

    -- Desactivar la visibilidad del personaje
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.Health = 0 -- Hace al jugador invisible
    end

    -- Limpiar los objetos del personaje que se usan para efectos
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            -- Establecer la transparencia del cuerpo
            part.Transparency = 1
            
            -- Crear una apariencia de arcoíris con partículas
            local rainbowTrail = Instance.new("ParticleEmitter", part)
            rainbowTrail.Color = ColorSequence.new({Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 127, 0), Color3.fromRGB(255, 255, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255), Color3.fromRGB(75, 0, 130), Color3.fromRGB(148, 0, 211)})
            rainbowTrail.LightEmission = 1
            rainbowTrail.Size = NumberSequence.new(1, 0)
            rainbowTrail.Lifetime = NumberRange.new(1, 2)
            rainbowTrail.Rate = 100
        end
    end

    -- Añadir efectos de iluminación
    local light = Instance.new("PointLight", character:FindFirstChildOfClass("HumanoidRootPart"))
    light.Color = Color3.fromRGB(255, 255, 255)
    light.Brightness = 2
    light.Range = 20

    -- Establecer el estado del efecto
    stateTable["RainbowBody"] = not stateTable["RainbowBody"]
end

function Functions.AutoClicker(stateTable)
    local autoClick = stateTable["AutoClicker"]
    local clickConnection

    local function startAutoClick()
        if autoClick then
            clickConnection = game:GetService("RunService").RenderStepped:Connect(function()
                mouse1click()
                wait(0.01) -- Velocidad de clic
            end)
        end
    end

    local function stopAutoClick()
        if clickConnection then
            clickConnection:Disconnect()
        end
    end

    stateTable["AutoClicker"] = not autoClick
    if stateTable["AutoClicker"] then
        startAutoClick()
    else
        stopAutoClick()
    end
end

function Functions.AutoPetBug(stateTable)
    local character = player.Character
    if not character then return end
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Teletransportar a la ubicación deseada
    humanoidRootPart.CFrame = CFrame.new(-677.4024658203125, 14.215564727783203, -206.73135375976562)
    
    -- Asegurarse de que el personaje no esté anclado
    character.HumanoidRootPart.Anchored = false
    
    -- Encontrar el segundo objeto en el inventario (Backpack)
    local tools = player.Backpack:GetChildren()
    local secondTool = tools[2] -- Asumimos que el segundo objeto es la herramienta deseada
    if secondTool and secondTool:IsA("Tool") then
        character.Humanoid:EquipTool(secondTool)
    end

    local autoClick = stateTable["AutoPetBug"]
    local clickConnection

    local function startAutoClick()
        if autoClick then
            clickConnection = game:GetService("RunService").RenderStepped:Connect(function()
                if secondTool then
                    secondTool:Activate()
                end
            end)
        end
    end

    local function stopAutoClick()
        if clickConnection then
            clickConnection:Disconnect()
        end
    end

    stateTable["AutoPetBug"] = not autoClick
    if stateTable["AutoPetBug"] then
        startAutoClick()
    else
        stopAutoClick()
    end
end

return Functions
