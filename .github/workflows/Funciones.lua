-- Funciones

local Functions = {}

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

function Functions.IncreaseWalkSpeed()
    local character = player.Character or player.CharacterAdded:Wait()
    character.Humanoid.WalkSpeed = character.Humanoid.WalkSpeed == 120 and 16 or 120
    Functions:Notify("Walk Speed " .. (character.Humanoid.WalkSpeed == 120 and "Increased" or "Reset"))
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
            local offset = humanoidRootPart.CFrame.LookVector * 10
            targetRootPart.CFrame = humanoidRootPart.CFrame + offset
            
            -- Desactivar la física para mantener la posición fija
            targetRootPart.Anchored = true
        end
    end
    Functions:Notify("All players teleported")
end

function Functions.RainbowBody(stateTable)
    local character = player.Character
    if not character then return end

    -- Desactivar la visibilidad del personaje
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.Health = 0
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

function Functions.AutoPetBug(stateTable)
    local humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-677.4024658203125, 14.215564727783203, -206.73135375976562)
    player.Character.HumanoidRootPart.Anchored = true
    wait(1)
    player.Character.HumanoidRootPart.Anchored = false

    local tool = player.Backpack:FindFirstChildOfClass("Tool")
    if tool then
        player.Character.Humanoid:EquipTool(tool)
    end

    local autoClick = true
    local clickConnection

    local function startAutoClick()
        if autoClick then
            clickConnection = game:GetService("RunService").RenderStepped:Connect(function()
                if tool then
                    tool:Activate()
                end
            end)
        end
    end

    local function stopAutoClick()
        if clickConnection then
            clickConnection:Disconnect()
        end
    end

    autoClick = not autoClick
    if autoClick then
        startAutoClick()
    else
        stopAutoClick()
    end

    Functions:Notify("Auto Pet Bug " .. (autoClick and "Started" or "Stopped"))
end

function Functions.AutoClicker(stateTable)
    local autoClick = true
    local clickConnection

    local function startAutoClick()
        if autoClick then
            clickConnection = game:GetService("RunService").RenderStepped:Connect(function()
                mouse1click()
            end)
        end
    end

    local function stopAutoClick()
        if clickConnection then
            clickConnection:Disconnect()
        end
    end

    autoClick = not autoClick
    if autoClick then
        startAutoClick()
    else
        stopAutoClick()
    end

    Functions:Notify("Auto Clicker " .. (autoClick and "Started" or "Stopped"))
end

function Functions:Notify(message)
    local player = game.Players.LocalPlayer
    local notification = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    local frame = Instance.new("Frame", notification)
    frame.Size = UDim2.new(0, 200, 0, 50)
    frame.Position = UDim2.new(0.5, -100, 0, 20)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0

    local textLabel = Instance.new("TextLabel", frame)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = message
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 18
    textLabel.TextStrokeTransparency = 0.5

    -- Animación de aparición
    frame.Position = UDim2.new(0.5, -100, 0, -60)
    local tween = TweenService:Create(frame, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -100, 0, 20)})
    tween:Play()

    -- Desaparecer después de un tiempo
    wait(3)
    local tweenOut = TweenService:Create(frame, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -100, 0, -60)})
    tweenOut:Play()
    tweenOut.Completed:Connect(function()
        notification:Destroy()
    end)
end

return Functions
