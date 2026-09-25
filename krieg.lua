--// ============================================
--// KRIEG - UNIVERSAL FEATURE GUI v5
--// Dark Black + Purple | Free Resize | Keybind System
--// Speeds up to 1000
--// ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local existing = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("KriegGUI")
if existing then existing:Destroy() end

local Theme = {
	Background   = Color3.fromRGB(10, 8, 14),
	Panel        = Color3.fromRGB(18, 14, 24),
	PanelAlt     = Color3.fromRGB(24, 18, 32),
	Accent       = Color3.fromRGB(138, 43, 226),
	AccentDark   = Color3.fromRGB(90, 30, 150),
	AccentLight  = Color3.fromRGB(180, 120, 255),
	Text         = Color3.fromRGB(230, 220, 245),
	TextDim      = Color3.fromRGB(140, 120, 170),
	Stroke       = Color3.fromRGB(60, 40, 90),
	Danger       = Color3.fromRGB(200, 60, 90),
	Success      = Color3.fromRGB(120, 220, 150),
}

local State = {
	FlyEnabled = false,
	FlySpeed = 100,
	SpeedEnabled = false,
	SpeedValue = 30,
	NoClipEnabled = false,
	SavedSpawn = nil,
	ToggleKey = Enum.KeyCode.RightShift,
	FlyKey    = Enum.KeyCode.F,
	SpeedKey  = Enum.KeyCode.G,
	NoClipKey = Enum.KeyCode.H,
	ListeningFor = nil,
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KriegGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local BASE_W, BASE_H = 340, 500
local MIN_W, MIN_H = 260, 320
local MAX_W, MAX_H = 900, 1200

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, BASE_W, 0, BASE_H)
MainFrame.Position = UDim2.new(0.5, -BASE_W/2, 0.5, -BASE_H/2)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Theme.AccentDark
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

local TITLE_H = 44
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, TITLE_H)
TitleBar.BackgroundColor3 = Theme.Panel
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleCover = Instance.new("Frame")
TitleCover.Size = UDim2.new(1, 0, 0, 12)
TitleCover.Position = UDim2.new(0, 0, 1, -12)
TitleCover.BackgroundColor3 = Theme.Panel
TitleCover.BorderSizePixel = 0
TitleCover.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -100, 1, 0)
TitleLabel.Position = UDim2.new(0, 18, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "KRIEG"
TitleLabel.TextColor3 = Theme.AccentLight
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local TitleGlow = Instance.new("Frame")
TitleGlow.Size = UDim2.new(1, 0, 0, 1)
TitleGlow.Position = UDim2.new(0, 0, 1, -1)
TitleGlow.BackgroundColor3 = Theme.Accent
TitleGlow.BorderSizePixel = 0
TitleGlow.ZIndex = 2
TitleGlow.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 28, 0, 28)
CloseButton.Position = UDim2.new(1, -38, 0, 8)
CloseButton.BackgroundColor3 = Theme.PanelAlt
CloseButton.Text = "×"
CloseButton.TextColor3 = Theme.Text
CloseButton.TextSize = 22
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

CloseButton.MouseEnter:Connect(function() CloseButton.BackgroundColor3 = Theme.Danger end)
CloseButton.MouseLeave:Connect(function() CloseButton.BackgroundColor3 = Theme.PanelAlt end)
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local MinButton = Instance.new("TextButton")
MinButton.Size = UDim2.new(0, 28, 0, 28)
MinButton.Position = UDim2.new(1, -70, 0, 8)
MinButton.BackgroundColor3 = Theme.PanelAlt
MinButton.Text = "—"
MinButton.TextColor3 = Theme.Text
MinButton.TextSize = 16
MinButton.Font = Enum.Font.GothamBold
MinButton.BorderSizePixel = 0
MinButton.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinButton

MinButton.MouseEnter:Connect(function() MinButton.BackgroundColor3 = Theme.AccentDark end)
MinButton.MouseLeave:Connect(function() MinButton.BackgroundColor3 = Theme.PanelAlt end)

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, 0, 1, -TITLE_H)
Content.Position = UDim2.new(0, 0, 0, TITLE_H)
Content.BackgroundTransparency = 1
Content.ClipsDescendants = true
Content.Parent = MainFrame

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 1, -16)
Scroll.Position = UDim2.new(0, 10, 0, 8)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 5
Scroll.ScrollBarImageColor3 = Theme.Accent
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.Parent = Content

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 8)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = Scroll

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 6)
Padding.PaddingBottom = UDim.new(0, 12)
Padding.Parent = Scroll

local GRIP_SIZE = 10

local function makeGrip(anchorX, anchorY)
	local grip = Instance.new("TextButton")
	grip.BackgroundTransparency = 1
	grip.Text = ""
	grip.BorderSizePixel = 0
	grip.ZIndex = 10
	grip.AutoButtonColor = false
	grip.Parent = MainFrame

	if anchorX == 1 and anchorY == 1 then
		grip.Size = UDim2.new(0, 16, 0, 16)
		grip.Position = UDim2.new(1, -16, 1, -16)
	elseif anchorX == 1 and anchorY == 2 then
		grip.Size = UDim2.new(0, GRIP_SIZE, 1, -32)
		grip.Position = UDim2.new(1, -GRIP_SIZE, 0, 16)
	elseif anchorX == 2 and anchorY == 1 then
		grip.Size = UDim2.new(1, -32, 0, GRIP_SIZE)
		grip.Position = UDim2.new(0, 16, 1, -GRIP_SIZE)
	end
	return grip
end

local GripBR = makeGrip(1, 1)
local GripR  = makeGrip(1, 2)
local GripB  = makeGrip(2, 1)

local CornerIndicator = Instance.new("TextLabel")
CornerIndicator.Size = UDim2.new(0, 16, 0, 16)
CornerIndicator.Position = UDim2.new(1, -18, 1, -18)
CornerIndicator.BackgroundColor3 = Theme.AccentDark
CornerIndicator.Text = "◢"
CornerIndicator.TextColor3 = Theme.AccentLight
CornerIndicator.TextSize = 12
CornerIndicator.Font = Enum.Font.GothamBold
CornerIndicator.BorderSizePixel = 0
CornerIndicator.ZIndex = 11
CornerIndicator.Parent = MainFrame

local CICorner = Instance.new("UICorner")
CICorner.CornerRadius = UDim.new(0, 4)
CICorner.Parent = CornerIndicator

local curW, curH = BASE_W, BASE_H
local resizing = false
local resizeMode = "br"
local startMouseX, startMouseY, startW, startH

local function beginResize(mode, input)
	resizing = true
	resizeMode = mode
	startMouseX = input.Position.X
	startMouseY = input.Position.Y
	startW = curW
	startH = curH
end

local function doResize(input)
	if not resizing then return end
	local dx = input.Position.X - startMouseX
	local dy = input.Position.Y - startMouseY
	local newW, newH = curW, curH
	if resizeMode == "br" then
		newW = math.clamp(startW + dx, MIN_W, MAX_W)
		newH = math.clamp(startH + dy, MIN_H, MAX_H)
	elseif resizeMode == "r" then
		newW = math.clamp(startW + dx, MIN_W, MAX_W)
	elseif resizeMode == "b" then
		newH = math.clamp(startH + dy, MIN_H, MAX_H)
	end
	curW, curH = newW, newH
	MainFrame.Size = UDim2.new(0, newW, 0, newH)
end

GripBR.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		beginResize("br", input)
	end
end)
GripR.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		beginResize("r", input)
	end
end)
GripB.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		beginResize("b", input)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		doResize(input)
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		resizing = false
	end
end)

local function createSection(text)
	local section = Instance.new("TextLabel")
	section.Size = UDim2.new(1, 0, 0, 22)
	section.BackgroundTransparency = 1
	section.Text = text
	section.TextColor3 = Theme.AccentLight
	section.TextSize = 11
	section.Font = Enum.Font.GothamBold
	section.TextXAlignment = Enum.TextXAlignment.Left
	section.Parent = Scroll

	local line = Instance.new("Frame")
	line.Size = UDim2.new(1, 0, 0, 1)
	line.Position = UDim2.new(0, 0, 1, -1)
	line.BackgroundColor3 = Theme.AccentDark
	line.BorderSizePixel = 0
	line.Parent = section
end

local function createToggle(name, defaultState, callback, keyGetter)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 38)
	container.BackgroundColor3 = Theme.Panel
	container.BorderSizePixel = 0
	container.Parent = Scroll

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 8)
	c.Parent = container

	local s = Instance.new("UIStroke")
	s.Color = Theme.Stroke
	s.Thickness = 1
	s.Parent = container

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -130, 1, 0)
	label.Position = UDim2.new(0, 14, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Theme.Text
	label.TextSize = 14
	label.Font = Enum.Font.Gotham
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container

	local keyBtn
	if keyGetter then
		keyBtn = Instance.new("TextButton")
		keyBtn.Size = UDim2.new(0, 46, 0, 24)
		keyBtn.Position = UDim2.new(1, -114, 0.5, -12)
		keyBtn.BackgroundColor3 = Theme.PanelAlt
		keyBtn.Text = keyGetter().Name
		keyBtn.TextColor3 = Theme.AccentLight
		keyBtn.TextSize = 11
		keyBtn.Font = Enum.Font.GothamBold
		keyBtn.BorderSizePixel = 0
		keyBtn.Parent = container

		local kbCorner = Instance.new("UICorner")
		kbCorner.CornerRadius = UDim.new(0, 6)
		kbCorner.Parent = keyBtn

		local kbStroke = Instance.new("UIStroke")
		kbStroke.Color = Theme.Stroke
		kbStroke.Thickness = 1
		kbStroke.Parent = keyBtn
	end

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 46, 0, 24)
	btn.Position = UDim2.new(1, -58, 0.5, -12)
	btn.BackgroundColor3 = defaultState and Theme.Accent or Theme.PanelAlt
	btn.Text = defaultState and "ON" or "OFF"
	btn.TextColor3 = Theme.Text
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamBold
	btn.BorderSizePixel = 0
	btn.Parent = container

	local bcorner = Instance.new("UICorner")
	bcorner.CornerRadius = UDim.new(0, 6)
	bcorner.Parent = btn

	local enabled = defaultState

	local function setState(state)
		enabled = state
		btn.Text = state and "ON" or "OFF"
		btn.BackgroundColor3 = state and Theme.Accent or Theme.PanelAlt
		if callback then callback(state) end
	end

	btn.MouseButton1Click:Connect(function()
		setState(not enabled)
	end)

	if keyBtn then
		keyBtn.MouseButton1Click:Connect(function()
			State.ListeningFor = name
			keyBtn.Text = "..."
		end)
	end

	return {
		Set = setState,
		GetState = function() return enabled end,
		SetKeyText = function(newKey)
			if keyBtn then keyBtn.Text = newKey.Name end
		end,
		Name = name,
	}
end
	local function createSlider(name, min, max, default, callback)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 72)
	container.BackgroundColor3 = Theme.Panel
	container.BorderSizePixel = 0
	container.Parent = Scroll

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 8)
	c.Parent = container

	local s = Instance.new("UIStroke")
	s.Color = Theme.Stroke
	s.Thickness = 1
	s.Parent = container

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -90, 0, 24)
	label.Position = UDim2.new(0, 14, 0, 6)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Theme.Text
	label.TextSize = 14
	label.Font = Enum.Font.Gotham
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container

	local inputBox = Instance.new("TextBox")
	inputBox.Size = UDim2.new(0, 70, 0, 24)
	inputBox.Position = UDim2.new(1, -82, 0, 6)
	inputBox.BackgroundColor3 = Theme.PanelAlt
	inputBox.Text = tostring(default)
	inputBox.TextColor3 = Theme.AccentLight
	inputBox.TextSize = 13
	inputBox.Font = Enum.Font.GothamBold
	inputBox.BorderSizePixel = 0
	inputBox.ClearTextOnFocus = false
	inputBox.Parent = container

	local icorner = Instance.new("UICorner")
	icorner.CornerRadius = UDim.new(0, 6)
	icorner.Parent = inputBox

	local istroke = Instance.new("UIStroke")
	istroke.Color = Theme.Stroke
	istroke.Thickness = 1
	istroke.Parent = inputBox

	local track = Instance.new("Frame")
	track.Size = UDim2.new(1, -28, 0, 8)
	track.Position = UDim2.new(0, 14, 0, 50)
	track.BackgroundColor3 = Theme.PanelAlt
	track.BorderSizePixel = 0
	track.Parent = container

	local tcorner = Instance.new("UICorner")
	tcorner.CornerRadius = UDim.new(1, 0)
	tcorner.Parent = track

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	fill.BackgroundColor3 = Theme.Accent
	fill.BorderSizePixel = 0
	fill.Parent = track

	local fcorner = Instance.new("UICorner")
	fcorner.CornerRadius = UDim.new(1, 0)
	fcorner.Parent = fill

	local dragBtn = Instance.new("TextButton")
	dragBtn.Size = UDim2.new(0, 16, 0, 16)
	dragBtn.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
	dragBtn.BackgroundColor3 = Theme.AccentLight
	dragBtn.Text = ""
	dragBtn.BorderSizePixel = 0
	dragBtn.Parent = track

	local dcorner = Instance.new("UICorner")
	dcorner.CornerRadius = UDim.new(1, 0)
	dcorner.Parent = dragBtn

	local value = default
	local dragging = false

	local function applyValue(v, updateSlider)
		v = math.clamp(math.floor(v + 0.5), min, max)
		value = v
		if updateSlider then
			local rel = (v - min) / (max - min)
			fill.Size = UDim2.new(rel, 0, 1, 0)
			dragBtn.Position = UDim2.new(rel, -8, 0.5, -8)
		end
		inputBox.Text = tostring(v)
		if callback then callback(v) end
	end

	local function updateFromX(x)
		local rel = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		applyValue(min + rel * (max - min), false)
		local newRel = (value - min) / (max - min)
		fill.Size = UDim2.new(newRel, 0, 1, 0)
		dragBtn.Position = UDim2.new(newRel, -8, 0.5, -8)
	end

	dragBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
		end
	end)

	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			updateFromX(input.Position.X)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			updateFromX(input.Position.X)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	inputBox.FocusLost:Connect(function()
		local num = tonumber(inputBox.Text)
		if num then
			applyValue(num, true)
		else
			inputBox.Text = tostring(value)
		end
	end)

	return {
		GetValue = function() return value end,
		SetValue = function(v) applyValue(v, true) end,
	}
end

local function createButton(name, color, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 38)
	btn.BackgroundColor3 = color or Theme.Panel
	btn.Text = name
	btn.TextColor3 = Theme.Text
	btn.TextSize = 14
	btn.Font = Enum.Font.GothamBold
	btn.BorderSizePixel = 0
	btn.Parent = Scroll

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 8)
	c.Parent = btn

	local s = Instance.new("UIStroke")
	s.Color = Theme.Stroke
	s.Thickness = 1
	s.Parent = btn

	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = color and color:Lerp(Color3.new(1,1,1), 0.15) or Theme.PanelAlt
	end)
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = color or Theme.Panel
	end)

	btn.MouseButton1Click:Connect(function()
		if callback then callback() end
	end)

	return btn
end

local function notify(text, isError)
	local n = Instance.new("TextLabel")
	n.Size = UDim2.new(1, 0, 0, 28)
	n.BackgroundColor3 = isError and Theme.Danger or Theme.Success
	n.Text = text
	n.TextColor3 = Color3.fromRGB(255, 255, 255)
	n.TextSize = 12
	n.Font = Enum.Font.GothamBold
	n.BorderSizePixel = 0
	n.Parent = Scroll

	local nc = Instance.new("UICorner")
	nc.CornerRadius = UDim.new(0, 6)
	nc.Parent = n

	task.delay(2, function()
		if n then n:Destroy() end
	end)
end

createSection("MOVEMENT")

local flyToggle = createToggle("Fly", false, function(state)
	State.FlyEnabled = state
end, function() return State.FlyKey end)

local flySpeedSlider = createSlider("Fly Speed", 30, 1000, 100, function(val)
	State.FlySpeed = val
end)

local speedToggle = createToggle("Speed Boost", false, function(state)
	State.SpeedEnabled = state
	local char = LocalPlayer.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = state and State.SpeedValue or 16
		end
	end
end, function() return State.SpeedKey end)

local speedSlider = createSlider("Walk Speed", 30, 1000, 30, function(val)
	State.SpeedValue = val
	if State.SpeedEnabled then
		local char = LocalPlayer.Character
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then hum.WalkSpeed = val end
		end
	end
end)

createSection("COLLISION")

local noclipToggle = createToggle("NoClip", false, function(state)
	State.NoClipEnabled = state
end, function() return State.NoClipKey end)

createSection("SPAWN MANAGER")

createButton("Set Spawn (current pos)", Theme.AccentDark, function()
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		State.SavedSpawn = char.HumanoidRootPart.CFrame
		notify("Spawn saved!", false)
	end
end)

createButton("Load Spawn (teleport)", Theme.AccentDark, function()
	if State.SavedSpawn then
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			char.HumanoidRootPart.CFrame = State.SavedSpawn
			notify("Teleported!", false)
		end
	else
		notify("No spawn saved!", true)
	end
end)

createSection("INTERFACE")

local keybindContainer = Instance.new("Frame")
keybindContainer.Size = UDim2.new(1, 0, 0, 60)
keybindContainer.BackgroundColor3 = Theme.Panel
keybindContainer.BorderSizePixel = 0
keybindContainer.Parent = Scroll

local kcc = Instance.new("UICorner")
kcc.CornerRadius = UDim.new(0, 8)
kcc.Parent = keybindContainer

local kcs = Instance.new("UIStroke")
kcs.Color = Theme.Stroke
kcs.Thickness = 1
kcs.Parent = keybindContainer

local kLabel = Instance.new("TextLabel")
kLabel.Size = UDim2.new(1, -20, 0, 20)
kLabel.Position = UDim2.new(0, 12, 0, 6)
kLabel.BackgroundTransparency = 1
kLabel.Text = "Toggle UI Hotkey"
kLabel.TextColor3 = Theme.Text
kLabel.TextSize = 13
kLabel.Font = Enum.Font.Gotham
kLabel.TextXAlignment = Enum.TextXAlignment.Left
kLabel.Parent = keybindContainer

local kButton = Instance.new("TextButton")
kButton.Size = UDim2.new(1, -24, 0, 26)
kButton.Position = UDim2.new(0, 12, 0, 28)
kButton.BackgroundColor3 = Theme.PanelAlt
kButton.Text = State.ToggleKey.Name
kButton.TextColor3 = Theme.AccentLight
kButton.TextSize = 13
kButton.Font = Enum.Font.GothamBold
kButton.BorderSizePixel = 0
kButton.Parent = keybindContainer

local kbc = Instance.new("UICorner")
kbc.CornerRadius = UDim.new(0, 6)
kbc.Parent = kButton

local kbs = Instance.new("UIStroke")
kbs.Color = Theme.Stroke
kbs.Thickness = 1
kbs.Parent = kButton

local scaleInfo = Instance.new("TextLabel")
scaleInfo.Size = UDim2.new(1, 0, 0, 30)
scaleInfo.BackgroundTransparency = 1
scaleInfo.Text = "Click a key button, then press the key you want to bind."
scaleInfo.TextColor3 = Theme.TextDim
scaleInfo.TextSize = 10
scaleInfo.Font = Enum.Font.Gotham
scaleInfo.TextWrapped = true
scaleInfo.Parent = Scroll

local function toggleUI()
	ScreenGui.Enabled = not ScreenGui.Enabled
end

kButton.MouseButton1Click:Connect(function()
	State.ListeningFor = "ui"
	kButton.Text = "..."
	kButton.TextColor3 = Theme.AccentLight
end)

MinButton.MouseButton1Click:Connect(function()
	toggleUI()
end)

UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
	if UserInputService:GetFocusedTextBox() then return end

	if State.ListeningFor then
		local key = input.KeyCode
		if State.ListeningFor == "ui" then
			State.ToggleKey = key
			kButton.Text = key.Name
		elseif State.ListeningFor == "Fly" then
			State.FlyKey = key
			flyToggle.SetKeyText(key)
		elseif State.ListeningFor == "Speed Boost" then
			State.SpeedKey = key
			speedToggle.SetKeyText(key)
		elseif State.ListeningFor == "NoClip" then
			State.NoClipKey = key
			noclipToggle.SetKeyText(key)
		end
		State.ListeningFor = nil
		return
	end

	if input.KeyCode == State.ToggleKey then
		toggleUI()
	elseif input.KeyCode == State.FlyKey then
		flyToggle.Set(not flyToggle.GetState())
	elseif input.KeyCode == State.SpeedKey then
		speedToggle.Set(not speedToggle.GetState())
	elseif input.KeyCode == State.NoClipKey then
		noclipToggle.Set(not noclipToggle.GetState())
	end
end)

local flyConnection, flyBodyVelocity, flyBodyGyro

local function startFly()
	local char = LocalPlayer.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if not hrp or not humanoid then return end

	humanoid.PlatformStand = true

	flyBodyVelocity = Instance.new("BodyVelocity")
	flyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
	flyBodyVelocity.Parent = hrp

	flyBodyGyro = Instance.new("BodyGyro")
	flyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	flyBodyGyro.P = 9e4
	flyBodyGyro.CFrame = hrp.CFrame
	flyBodyGyro.Parent = hrp

	local camera = workspace.CurrentCamera

	flyConnection = RunService.RenderStepped:Connect(function()
		if not hrp or not hrp.Parent or not camera then return end
		local moveDir = Vector3.new(0, 0, 0)
		local camCF = camera.CFrame

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += camCF.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= camCF.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= camCF.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += camCF.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0,1,0) end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.new(0,1,0) end

		if moveDir.Magnitude > 0 then
			moveDir = moveDir.Unit * State.FlySpeed
		end

		flyBodyVelocity.Velocity = moveDir
		flyBodyGyro.CFrame = camCF
	end)
end

local function stopFly()
	if flyConnection then flyConnection:Disconnect() flyConnection = nil end
	if flyBodyVelocity then flyBodyVelocity:Destroy() flyBodyVelocity = nil end
	if flyBodyGyro then flyBodyGyro:Destroy() flyBodyGyro = nil end
	local char = LocalPlayer.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then hum.PlatformStand = false end
	end
end

task.spawn(function()
	local lastState = false
	while ScreenGui.Parent do
		if State.FlyEnabled ~= lastState then
			lastState = State.FlyEnabled
			if lastState then startFly() else stopFly() end
		end
		task.wait(0.1)
	end
end)

task.spawn(function()
	while ScreenGui.Parent do
		if State.SpeedEnabled then
			local char = LocalPlayer.Character
			if char then
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum and hum.WalkSpeed ~= State.SpeedValue then
					hum.WalkSpeed = State.SpeedValue
				end
			end
		end
		task.wait(0.1)
	end
end)

local noclipConnection = RunService.Stepped:Connect(function()
	if State.NoClipEnabled then
		local char = LocalPlayer.Character
		if char then
			for _, part in ipairs(char:GetDescendants()) do
				if part:IsA("BasePart") and part.CanCollide then
					part.CanCollide = false
				end
			end
		end
	end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
	char:WaitForChild("Humanoid")
	task.wait(0.5)
	if State.FlyEnabled then
		stopFly()
		task.wait(0.2)
		startFly()
	end
	if State.SpeedEnabled then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then hum.WalkSpeed = State.SpeedValue end
	end
end)

ScreenGui.Destroying:Connect(function()
	noclipConnection:Disconnect()
	stopFly()
end)

print("[KRIEG v5] Loaded successfully!")
