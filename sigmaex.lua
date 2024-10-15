-- Sigma Explorer V8
-- This script creates a basic explorer tool for Roblox.

-- Creating the ScreenGui
local explorerGui = Instance.new("ScreenGui")
explorerGui.Name = "SigmaExplorerV8"
explorerGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main frame to hold the explorer contents
local explorerFrame = Instance.new("Frame")
explorerFrame.Size = UDim2.new(0.3, 0, 0.6, 0)
explorerFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
explorerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
explorerFrame.BackgroundTransparency = 0.5
explorerFrame.BorderSizePixel = 2
explorerFrame.BorderColor3 = Color3.new(1, 1, 1)
explorerFrame.Active = true  -- Makes the frame active for user input
explorerFrame.Draggable = true  -- Allows the frame to be dragged
explorerFrame.Parent = explorerGui

-- Title for the Explorer
local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "Sigma Explorer V8"
titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.FredokaOne
titleLabel.TextScaled = true
titleLabel.Parent = explorerFrame

-- ScrollingFrame for browsing game objects
local explorerContent = Instance.new("ScrollingFrame")
explorerContent.Size = UDim2.new(1, 0, 0.9, 0)
explorerContent.Position = UDim2.new(0, 0, 0.1, 0)
explorerContent.CanvasSize = UDim2.new(0, 0, 10, 0)  -- Large size to fit many objects
explorerContent.ScrollBarThickness = 10
explorerContent.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
explorerContent.BorderSizePixel = 0
explorerContent.Parent = explorerFrame

-- Function to highlight an object
local function highlightObject(obj)
    -- Remove existing highlights
    if obj:FindFirstChild("Highlight") then
        obj.Highlight:Destroy()
    end

    -- Create a new highlight
    local highlight = Instance.new("Highlight")
    highlight.Adornee = obj
    highlight.FillColor = Color3.new(1, 0, 0) -- Red highlight
    highlight.OutlineColor = Color3.new(0, 0, 0) -- Black outline
    highlight.Parent = obj

    -- Reset transparency after selection
    if obj:IsA("BasePart") then
        obj.Transparency = 0.5
    end

    -- Remove highlight after some time
    wait(2) -- Highlight lasts for 2 seconds
    highlight:Destroy()
    if obj:IsA("BasePart") then
        obj.Transparency = 0 -- Reset transparency
    end
end

-- Function to list objects in the game
local function listGameObjects()
    local yOffset = 0
    for _, obj in pairs(game:GetDescendants()) do
        local objectLabel = Instance.new("TextButton") -- Use TextButton for clickability
        objectLabel.Size = UDim2.new(1, 0, 0, 30)
        objectLabel.Position = UDim2.new(0, 0, 0, yOffset)
        objectLabel.Text = obj.Name .. " (" .. obj.ClassName .. ")"
        objectLabel.TextColor3 = Color3.new(1, 1, 1)
        objectLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        objectLabel.BorderSizePixel = 0
        objectLabel.Font = Enum.Font.SourceSans
        objectLabel.TextScaled = true
        objectLabel.Parent = explorerContent

        -- Connect click event to highlight the object
        objectLabel.MouseButton1Click:Connect(function()
            highlightObject(obj)
        end)

        yOffset = yOffset + 30
    end
    explorerContent.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

-- Call the function to list the game objects when the script runs
listGameObjects()
