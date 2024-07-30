-- Librerías

local Library = {}

function Library:CreateButton(name, parent, callback, stateTable)
    local button = Instance.new("TextButton", parent)
    button.Size = UDim2.new(1, -20, 0, 50)
    button.Text = name
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.BorderSizePixel = 0
    button.TextColor3 = Color3.fromRGB(255, 255, 255)

    local buttonCorner = Instance.new("UICorner", button)
    buttonCorner.CornerRadius = UDim.new(0, 10)

    local stateIndicator = Instance.new("TextLabel", button)
    stateIndicator.Size = UDim2.new(0, 20, 1, 0)
    stateIndicator.Position = UDim2.new(1, -20, 0, 0)
    stateIndicator.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    stateIndicator.BorderSizePixel = 0
    stateIndicator.Text = ""

    local buttonTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    local buttonTween = TweenService:Create(button, buttonTweenInfo, {BackgroundColor3 = Color3.fromRGB(90, 90, 90)})

    button.MouseEnter:Connect(function()
        buttonTween:Play()
    end)

    button.MouseLeave:Connect(function()
        buttonTween:Reverse()
    end)

    stateTable[name] = false

    button.MouseButton1Click:Connect(function()
        stateTable[name] = not stateTable[name]
        stateIndicator.BackgroundColor3 = stateTable[name] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        callback(stateTable)
    end)

    return button
end

return Library
