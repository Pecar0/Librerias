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
    local players = game.Players:GetPlayers()
    for _, targetPlayer in ipairs(players) do
        if targetPlayer ~= player then
            local character = targetPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
            end
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

function Functions.RainbowBody()
    local character = player.Character or player.CharacterAdded:Wait()
    local colors = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 127, 0), Color3.fromRGB(255, 255, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255), Color3.fromRGB(75, 0, 130), Color3.fromRGB(148, 0, 211)}
    local index = 1

    -- Hacer el cuerpo del jugador invisible
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.Material = Enum.Material.SmoothPlastic
            part.BrickColor = BrickColor.new(Color3.fromRGB(0, 0, 0))
            part.Transparency = 1
        end
    end

    -- Crear efectos de trazos de colores
    while true do
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                -- Crear una nueva parte para el trazo arcoíris
                local tracePart = Instance.new("Part")
                tracePart.Size = part.Size
                tracePart.Position = part.Position
                tracePart.Anchored = true
                tracePart.CanCollide = false
                tracePart.Material = Enum.Material.Neon
                tracePart.BrickColor = BrickColor.new(colors[index])
                tracePart.Transparency = 0.5
                tracePart.CFrame = part.CFrame
                tracePart.Parent = workspace

                -- Crear una animación para el trazo
                local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true)
                local goal = {Color = colors[index]}
                local tween = TweenService:Create(tracePart, tweenInfo, goal)
                tween:Play()
            end
        end
        index = index % #colors + 1
        wait(0.5)
    end
end

function Functions.AutoClicker()
    local tool = player.Backpack:FindFirstChildOfClass("Tool")
    if not tool then
        return -- No hay herramienta, salir de la función
    end

    while true do
        if tool then
            -- Activar la herramienta automáticamente
            tool:Activate()
        end
        wait(0.1) -- Esperar un breve período antes de hacer clic nuevamente
    end
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

    local autoClick = false
    local clickConnection

    local function startAutoClick()
        if autoClick then
            clickConnection = RunService.RenderStepped:Connect(function()
                tool:Activate()
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
end

return Functions
