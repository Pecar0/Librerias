-- Funciones
local Functions = {}
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UserInputService = game:GetService("UserInputService")

function Functions.IncreaseWalkSpeed(stateTable)
    local character = player.Character or player.CharacterAdded:Wait()
    character.Humanoid.WalkSpeed = character.Humanoid.WalkSpeed == 120 and 16 or 120
end

function Functions.KillAll(stateTable)
    local players = game.Players:GetPlayers()
    for _, targetPlayer in ipairs(players) do
        if targetPlayer ~= player then
            targetPlayer.Character:BreakJoints()
        end
    end
end

function Functions.KillAllV2(stateTable)
    if stateTable["Kill All v2"] then
        local function teleportBehind(targetPlayer)
            local character = player.Character
            local rootPart = character:WaitForChild("HumanoidRootPart")
            local targetRootPart = targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")

            if targetRootPart then
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
            wait(1)
        end
    else
        print("Kill All v2 desactivado")
    end
end

function Functions.RainbowBody(stateTable)
    local character = player.Character or player.CharacterAdded:Wait()
    local bodyParts = {}
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            table.insert(bodyParts, part)
            part.Material = Enum.Material.Neon
        end
    end

    local colors = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 127, 0), Color3.fromRGB(255, 255, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255), Color3.fromRGB(75, 0, 130), Color3.fromRGB(148, 0, 211)}
    local index = 1

    while true do
        for _, part in ipairs(bodyParts) do
            part.BrickColor = BrickColor.new(colors[index])
        end
        index = index % #colors + 1
        wait(0.5)
    end
end

function Functions.AutoClicker(stateTable)
    local autoClick = true
    local clickConnection

    local function startAutoClick()
        if autoClick then
            clickConnection = game:GetService("RunService").RenderStepped:Connect(function()
                if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                    mouse1click()
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
end

function Functions.AutoPetBug(stateTable)
    player.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-677.402, 14.216, -206.731)
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
end

return Functions
