local explorerGui = Instance.new("ScreenGui")
explorerGui.Name = "SigmaExplorerV8"
explorerGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local explorerFrame = Instance.new("Frame")
explorerFrame.Size = UDim2.new(0.3, 0, 0.6, 0)
explorerFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
explorerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
explorerFrame.BackgroundTransparency = 0.5
explorerFrame.BorderSizePixel = 2
explorerFrame.BorderColor3 = Color3.new(1, 1, 1)
explorerFrame.Active = true
explorerFrame.Draggable = true
explorerFrame.Parent = explorerGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "Sigma Explorer V8"
titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.FredokaOne
titleLabel.TextScaled = true
titleLabel.Parent = explorerFrame

local explorerContent = Instance.new("ScrollingFrame")
explorerContent.Size = UDim2.new(1, 0, 0.9, 0)
explorerContent.Position = UDim2.new(0, 0, 0.1, 0)
explorerContent.CanvasSize = UDim2.new(0, 0, 10, 0)
explorerContent.ScrollBarThickness = 10
explorerContent.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
explorerContent.BorderSizePixel = 0
explorerContent.Parent = explorerFrame

local function highlightObject(obj)
    if obj:FindFirstChild("Highlight") then
        obj.Highlight:Destroy()
    end

    local highlight = Instance.new("Highlight")
    highlight.Adornee = obj
    highlight.FillColor = Color3.new(1, 0, 0)
    highlight.OutlineColor = Color3.new(0, 0, 0)
    highlight.Parent = obj

    if obj:IsA("BasePart") then
        obj.Transparency = 0.5
    end

    wait(2)
    highlight:Destroy()
    if obj:IsA("BasePart") then
        obj.Transparency = 0
    end
end

local function listGameObjects()
    local yOffset = 0
    for _, obj in pairs(game:GetDescendants()) do
        local objectLabel = Instance.new("TextButton")
        objectLabel.Size = UDim2.new(1, 0, 0, 30)
        objectLabel.Position = UDim2.new(0, 0, 0, yOffset)
        objectLabel.Text = obj.Name .. " (" .. obj.ClassName .. ")"
        objectLabel.TextColor3 = Color3.new(1, 1, 1)
        objectLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        objectLabel.BorderSizePixel = 0
        objectLabel.Font = Enum.Font.SourceSans
        objectLabel.TextScaled = true
        objectLabel.Parent = explorerContent

        objectLabel.MouseButton1Click:Connect(function()
            highlightObject(obj)
        end)

        yOffset = yOffset + 30
    end
    explorerContent.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

listGameObjects()
