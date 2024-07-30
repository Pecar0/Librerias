local Functions = {}

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

function Functions.IncreaseWalkSpeed()
    local character = player.Character or player.CharacterAdded:Wait()
    character.Humanoid.WalkSpeed = character.Humanoid.WalkSpeed == 120 and 16 or 120
end

function Functions.KillAll()
    local players = game.Players:GetPlayers()
    for _, targetPlayer in ipairs(players) do
        if targetPlayer ~= player then
            -- Lógica para matar al jugador objetivo
            targetPlayer.Character:BreakJoints()
        end
    end
end

function Functions.KillAllV2(stateTable)
    if stateTable["Kill All v2"] then
        -- Lógica para activar Kill All v2
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
            wait(1) -- Esperar 1 segundo antes de teleportar de nuevo
        end
    else
        -- Lógica para desactivar Kill All v2
        print("Kill All v2 desactivado")
    end
end

function Functions.RainbowBody()
    local character = player.Character or player.CharacterAdded:Wait()
    local colors = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 127, 0), Color3.fromRGB(255, 255, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255), Color3.fromRGB(75, 0, 130), Color3.fromRGB(148, 0, 211)}
    local index = 1

    while true do
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.BrickColor = BrickColor.new(colors[index])
                part.Material = Enum.Material.Neon
            end
        end
        index = index % #colors + 1
        wait(0.5)
    end
end

function Functions.AutoClicker()
    while true do
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            mouse1click()
        end
        wait(0.1)
    end
end

function Functions.AutoPetBug()
    local remote = game:GetService("ReplicatedStorage"):WaitForChild("PetRemote")
    while true do
        remote:FireServer("AutoPet")
        wait(1)
    end
end

return Functions
