local Library = {}
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- Crear un botón con animaciones
function Library:CreateButton(name, parent, callback, stateTable)
    local button = Instance.new("TextButton", parent)
    button.Size = UDim2.new(1, -20, 0, 50)
    button.Text = name
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.BorderSizePixel = 0
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true

    local buttonCorner = Instance.new("UICorner", button)
    buttonCorner.CornerRadius = UDim.new(0, 10)

    local stateIndicator = Instance.new("TextLabel", button)
    stateIndicator.Size = UDim2.new(0, 20, 1, 0)
    stateIndicator.Position = UDim2.new(1, -20, 0, 0)
    stateIndicator.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    stateIndicator.BorderSizePixel = 0
    stateIndicator.Text = ""

    stateTable[name] = false

    button.MouseButton1Click:Connect(function()
        stateTable[name] = not stateTable[name]
        stateIndicator.BackgroundColor3 = stateTable[name] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        callback()
        -- Animación
        local tween = TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(50, 255, 50)})
        tween:Play()
        tween.Completed:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end)
    end)

    return button
end

-- Crear un cuadro de texto con animaciones
function Library:CreateTextBox(name, parent, placeholderText, callback)
    local textBox = Instance.new("TextBox", parent)
    textBox.Size = UDim2.new(1, -20, 0, 50)
    textBox.Text = placeholderText
    textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    textBox.BorderSizePixel = 0
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.TextScaled = true
    textBox.ClearTextOnFocus = false

    local textBoxCorner = Instance.new("UICorner", textBox)
    textBoxCorner.CornerRadius = UDim.new(0, 10)

    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(textBox.Text)
        end
    end)

    return textBox
end

-- Crear un slider con animaciones
function Library:CreateSlider(name, parent, minValue, maxValue, initialValue, callback)
    local sliderFrame = Instance.new("Frame", parent)
    sliderFrame.Size = UDim2.new(1, -20, 0, 30)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

    local sliderBar = Instance.new("Frame", sliderFrame)
    sliderBar.Size = UDim2.new(1, -20, 0, 10)
    sliderBar.Position = UDim2.new(0, 10, 0, 10)
    sliderBar.BackgroundColor3 = Color3.fromRGB(70, 70, 70)

    local sliderHandle = Instance.new("Frame", sliderBar)
    sliderHandle.Size = UDim2.new(0, 20, 1, 0)
    sliderHandle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

    local UIS = game:GetService("UserInputService")
    local dragging = false

    local function updateSlider(input)
        if dragging then
            local mousePosition = UIS:GetMouseLocation()
            local barPosition = sliderBar.AbsolutePosition.X
            local barSize = sliderBar.AbsoluteSize.X
            local newValue = math.clamp((mousePosition.X - barPosition) / barSize, 0, 1)
            sliderHandle.Position = UDim2.new(newValue, -10, 0, 0)
            callback(math.floor(minValue + newValue * (maxValue - minValue)))
        end
    end

    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    sliderBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UIS.InputChanged:Connect(updateSlider)

    return sliderFrame
end

return Library
