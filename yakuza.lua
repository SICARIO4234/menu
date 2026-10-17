-- LocalScript en StarterPlayerScripts
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- ================= [ANTIBAN] GUARDIA =================
if _G.__YKZ_LOADED then return end
_G.__YKZ_LOADED = true

local function antiScanDelay()
	local checks = 0
	for _, v in ipairs(player:GetDescendants()) do
		if v:IsA("ScreenGui") and v.Name ~= "YakuzaMenu" then
			checks += 1
		end
	end
	if checks > 6 then
		task.wait(math.random(2, 5))
	end
	task.wait(math.random(50, 350) / 1000)
end

antiScanDelay()

-- ================= BYPASS DE KEY PARA USUARIO ESPECÍFICO =================
local BYPASS_USER = "elcojo2057"
local skipKeyGate = (player.Name:lower() == BYPASS_USER:lower())

-- ================= SISTEMA DE KEYS ROTATIVAS =================
local KEY_LIST = {"ykz", "ykz2", "ykz3", "ykz4", "ykz5", "ykz6", "ykz7", "ykz8"}

local function getCurrentKeyIndex()
	local idx = nil
	pcall(function()
		idx = player:GetAttribute("__ykz_key_idx")
	end)
	if type(idx) ~= "number" then idx = 1 end
	return idx
end

local function advanceKeyIndex()
	local idx = getCurrentKeyIndex() + 1
	if idx > #KEY_LIST then idx = 1 end
	pcall(function()
		player:SetAttribute("__ykz_key_idx", idx)
	end)
	return idx
end

local function getValidKey()
	local idx = getCurrentKeyIndex()
	return KEY_LIST[idx] or KEY_LIST[1], idx
end

-- ================= PANTALLA ROJA BLOQUEANTE (solo si NO es bypass) =================
if not skipKeyGate then

	local keyGui = Instance.new("ScreenGui")
	keyGui.Name = "SettingsPanel_" .. tostring(math.random(1000, 9999))
	keyGui.ResetOnSpawn = false
	keyGui.IgnoreGuiInset = true
	keyGui.DisplayOrder = 10000
	keyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	keyGui.Parent = player:WaitForChild("PlayerGui")

	local blocker = Instance.new("TextButton")
	blocker.Size = UDim2.new(1, 0, 1, 0)
	blocker.Position = UDim2.new(0, 0, 0, 0)
	blocker.BackgroundColor3 = Color3.fromRGB(160, 0, 0)
	blocker.BorderSizePixel = 0
	blocker.Text = ""
	blocker.AutoButtonColor = false
	blocker.Modal = true
	blocker.ZIndex = 1
	blocker.Parent = keyGui

	local blockerGrad = Instance.new("UIGradient")
	blockerGrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 10, 10)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(130, 0, 0)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 5, 5)),
	})
	blockerGrad.Rotation = 45
	blockerGrad.Parent = blocker

	local keyPanel = Instance.new("Frame")
	keyPanel.Size = UDim2.new(0, 380, 0, 240)
	keyPanel.Position = UDim2.new(0.5, -190, 0.5, -120)
	keyPanel.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
	keyPanel.BorderSizePixel = 0
	keyPanel.ZIndex = 5
	keyPanel.Parent = keyGui

	local keyPanelCorner = Instance.new("UICorner")
	keyPanelCorner.CornerRadius = UDim.new(0, 10)
	keyPanelCorner.Parent = keyPanel

	local keyPanelStroke = Instance.new("UIStroke")
	keyPanelStroke.Color = Color3.fromRGB(255, 60, 60)
	keyPanelStroke.Thickness = 2
	keyPanelStroke.Transparency = 0.1
	keyPanelStroke.Parent = keyPanel

	local keyTitle = Instance.new("TextLabel")
	keyTitle.Size = UDim2.new(1, -40, 0, 40)
	keyTitle.Position = UDim2.new(0, 20, 0, 20)
	keyTitle.BackgroundTransparency = 1
	keyTitle.Text = "🔒  INGRESA LA KEY"
	keyTitle.TextColor3 = Color3.fromRGB(255, 200, 200)
	keyTitle.Font = Enum.Font.GothamBlack
	keyTitle.TextSize = 22
	keyTitle.ZIndex = 6
	keyTitle.Parent = keyPanel

	local keySubtitle = Instance.new("TextLabel")
	keySubtitle.Size = UDim2.new(1, -40, 0, 20)
	keySubtitle.Position = UDim2.new(0, 20, 0, 62)
	keySubtitle.BackgroundTransparency = 1
	keySubtitle.Text = "Debes ingresar la key para continuar"
	keySubtitle.TextColor3 = Color3.fromRGB(255, 120, 120)
	keySubtitle.Font = Enum.Font.Gotham
	keySubtitle.TextSize = 12
	keySubtitle.ZIndex = 6
	keySubtitle.Parent = keyPanel

	local keyBox = Instance.new("TextBox")
	keyBox.Size = UDim2.new(1, -40, 0, 52)
	keyBox.Position = UDim2.new(0, 20, 0, 95)
	keyBox.BackgroundColor3 = Color3.fromRGB(60, 10, 10)
	keyBox.Text = ""
	keyBox.PlaceholderText = "Escribe la key aquí..."
	keyBox.PlaceholderColor3 = Color3.fromRGB(200, 100, 100)
	keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	keyBox.Font = Enum.Font.GothamBold
	keyBox.TextSize = 18
	keyBox.TextXAlignment = Enum.TextXAlignment.Center
	keyBox.BorderSizePixel = 0
	keyBox.ClearTextOnFocus = false
	keyBox.ZIndex = 6
	keyBox.Parent = keyPanel

	local keyBoxCorner = Instance.new("UICorner")
	keyBoxCorner.CornerRadius = UDim.new(0, 6)
	keyBoxCorner.Parent = keyBox

	local keyBoxStroke = Instance.new("UIStroke")
	keyBoxStroke.Color = Color3.fromRGB(180, 40, 40)
	keyBoxStroke.Thickness = 1.5
	keyBoxStroke.Parent = keyBox

	local keyFeedback = Instance.new("TextLabel")
	keyFeedback.Size = UDim2.new(1, -40, 0, 24)
	keyFeedback.Position = UDim2.new(0, 20, 0, 158)
	keyFeedback.BackgroundTransparency = 1
	keyFeedback.Text = ""
	keyFeedback.TextColor3 = Color3.fromRGB(255, 150, 150)
	keyFeedback.Font = Enum.Font.GothamBold
	keyFeedback.TextSize = 13
	keyFeedback.ZIndex = 6
	keyFeedback.Parent = keyPanel

	local keyBtn = Instance.new("TextButton")
	keyBtn.Size = UDim2.new(1, -40, 0, 40)
	keyBtn.Position = UDim2.new(0, 20, 0, 186)
	keyBtn.BackgroundColor3 = Color3.fromRGB(200, 20, 40)
	keyBtn.Text = "VERIFICAR"
	keyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	keyBtn.Font = Enum.Font.GothamBlack
	keyBtn.TextSize = 15
	keyBtn.BorderSizePixel = 0
	keyBtn.AutoButtonColor = false
	keyBtn.ZIndex = 6
	keyBtn.Parent = keyPanel

	local keyBtnCorner = Instance.new("UICorner")
	keyBtnCorner.CornerRadius = UDim.new(0, 6)
	keyBtnCorner.Parent = keyBtn

	keyBtn.MouseEnter:Connect(function()
		TweenService:Create(keyBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(240, 40, 60)}):Play()
	end)
	keyBtn.MouseLeave:Connect(function()
		TweenService:Create(keyBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(200, 20, 40)}):Play()
	end)

	local keyPassed = false

	local function destroyKeyGate()
		if keyGui and keyGui.Parent then
			pcall(function() keyGui:Destroy() end)
		end
	end

	local function submitKey()
		if keyPassed then return end
		local typed = string.lower(string.gsub(keyBox.Text, "%s", ""))
		local expected = string.lower(getValidKey())

		if typed == "" then
			keyFeedback.Text = "Escribe algo."
			keyFeedback.TextColor3 = Color3.fromRGB(255, 180, 100)
			return
		end

		if typed == expected then
			keyPassed = true
			advanceKeyIndex()
			keyFeedback.Text = "✅ Key correcta. Abriendo..."
			keyFeedback.TextColor3 = Color3.fromRGB(150, 255, 150)
			pcall(function()
				keyBoxStroke.Color = Color3.fromRGB(100, 255, 100)
			end)
			task.wait(0.4)
			destroyKeyGate()
		else
			keyFeedback.Text = "❌ Key incorrecta. Intenta de nuevo."
			keyFeedback.TextColor3 = Color3.fromRGB(255, 80, 80)
			pcall(function()
				keyBoxStroke.Color = Color3.fromRGB(255, 40, 40)
				TweenService:Create(keyBoxStroke, TweenInfo.new(0.4), {Color = Color3.fromRGB(180, 40, 40)}):Play()
			end)
			keyBox.Text = ""
			local orig = keyPanel.Position
			for i = 1, 6 do
				keyPanel.Position = orig + UDim2.new(0, (i % 2 == 0) and 8 or -8, 0, 0)
				task.wait(0.03)
			end
			keyPanel.Position = orig
		end
	end

	keyBtn.MouseButton1Click:Connect(submitKey)
	keyBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then submitKey() end
	end)

	task.spawn(function()
		while not keyPassed do
			if keyGui and keyGui.Parent and keyBox and keyBox.Parent then
				if not keyBox:IsFocused() then
					pcall(function() keyBox:CaptureFocus() end)
				end
			end
			task.wait(0.5)
		end
	end)

	while not keyPassed do
		task.wait(0.1)
	end

end
-- ================= FIN DE LA PANTALLA DE KEY =================

-- ================= A PARTIR DE AQUÍ, EL MENÚ ORIGINAL =================

local gui = Instance.new("ScreenGui")
gui.Name = "YakuzaMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

pcall(function() gui.Name = "SettingsUI_" .. tostring(math.random(1000, 9999)) end)

-- ================= [ANTI-LAG] AUTO (SIN OPCIÓN) =================
-- Arranca solo al cargar. No aparece en ACCIONES. No toca jugadores ni GUI.
local antiLagEnabled = true
local ANTI_LAG_INTERVAL = 2.5
local CLEANABLE_NAMES = {
	"Smoke", "Fire", "Sparkles", "ParticleEmitter",
	"Trail", "Beam", "Explosion", "Blast",
	"Debris", "FX", "Effect", "Effects",
}

local function isVisibleFromCam(obj, camPos, maxDist)
	local pos
	if obj:IsA("BasePart") then
		pos = obj.Position
	elseif obj:IsA("Model") then
		local pri = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
		if not pri then return true end
		pos = pri.Position
	else
		return true
	end
	if (pos - camPos).Magnitude > maxDist then return false end
	return true
end

local function antiLagPass()
	if not antiLagEnabled then return end
	local cam = workspace.CurrentCamera
	if not cam then return end
	local camPos = cam.CFrame.Position
	local maxDist = 250

	-- 1) Partículas / humo / fuego / trails lejanos
	for _, obj in ipairs(workspace:GetDescendants()) do
		if not obj.Parent then continue end
		if obj:IsA("ParticleEmitter") or obj:IsA("Smoke")
			or obj:IsA("Fire") or obj:IsA("Sparkles")
			or obj:IsA("Trail") or obj:IsA("Beam") then
			local parentPart = obj.Parent
			if parentPart and (parentPart:IsA("BasePart") or parentPart:IsA("Model")) then
				if not isVisibleFromCam(parentPart, camPos, maxDist) then
					pcall(function() obj.Enabled = false end)
				end
			end
		end
	end

	-- 2) Objetos sueltos con nombres típicos de FX / debris
	for _, obj in ipairs(workspace:GetChildren()) do
		if not obj.Parent then continue end
		if obj:IsA("Model") or obj:IsA("BasePart") then
			local n = obj.Name
			for _, key in ipairs(CLEANABLE_NAMES) do
				if string.find(n, key, 1, true) then
					if not isVisibleFromCam(obj, camPos, maxDist) then
						pcall(function() obj:Destroy() end)
					end
					break
				end
			end
		end
	end

	-- 3) Calidad gráfica baja en Lighting
	pcall(function()
		local lighting = game:GetService("Lighting")
		if lighting.GlobalShadows then
			lighting.GlobalShadows = false
		end
		lighting.EnvironmentDiffuseScale = 0
		lighting.EnvironmentSpecularScale = 0
	end)
end

task.spawn(function()
	task.wait(3)
	while antiLagEnabled and gui.Parent do
		pcall(antiLagPass)
		task.wait(ANTI_LAG_INTERVAL)
	end
end)
-- ================= FIN ANTI-LAG =================

local function cornerLine(parent, size, pos, color)
	local l = Instance.new("Frame")
	l.Size = size
	l.Position = pos
	l.BackgroundColor3 = color or Color3.fromRGB(255, 60, 100)
	l.BorderSizePixel = 0
	l.ZIndex = 3
	l.Parent = parent
	return l
end

-- ===== BOTÓN ABRIR FUTURISTA =====
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 180, 0, 50)
toggleBtn.Position = UDim2.new(0, 20, 0, 80)
toggleBtn.BackgroundColor3 = Color3.fromRGB(10, 5, 15)
toggleBtn.Text = "  ⚡ ABRIR MENÚ  "
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.GothamBlack
toggleBtn.TextSize = 15
toggleBtn.BorderSizePixel = 0
toggleBtn.AutoButtonColor = false
toggleBtn.Parent = gui

local tCorner = Instance.new("UICorner")
tCorner.CornerRadius = UDim.new(0, 4)
tCorner.Parent = toggleBtn

local tGrad = Instance.new("UIGradient")
tGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 30, 60)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 10, 30)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 30, 60)),
})
tGrad.Rotation = 90
tGrad.Parent = toggleBtn

local tStroke1 = Instance.new("UIStroke")
tStroke1.Color = Color3.fromRGB(255, 80, 120)
tStroke1.Thickness = 1.5
tStroke1.Transparency = 0.1
tStroke1.Parent = toggleBtn

local tStroke2 = Instance.new("UIStroke")
tStroke2.Color = Color3.fromRGB(255, 200, 220)
tStroke2.Thickness = 0.5
tStroke2.Transparency = 0.4
tStroke2.Parent = toggleBtn

cornerLine(toggleBtn, UDim2.new(0, 10, 0, 2), UDim2.new(0, 6, 0, 6))
cornerLine(toggleBtn, UDim2.new(0, 2, 0, 10), UDim2.new(0, 6, 0, 6))
cornerLine(toggleBtn, UDim2.new(0, 10, 0, 2), UDim2.new(1, -16, 1, -8))
cornerLine(toggleBtn, UDim2.new(0, 2, 0, 10), UDim2.new(1, -8, 1, -16))

local _loops = {}
local function safeLoop(fn)
	local conn = task.spawn(fn)
	table.insert(_loops, conn)
end

safeLoop(function()
	while toggleBtn.Parent do
		TweenService:Create(tStroke1, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.6, Thickness = 2.5}):Play()
		task.wait(0.7)
		TweenService:Create(tStroke1, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.05, Thickness = 1.5}):Play()
		task.wait(0.7)
	end
end)

safeLoop(function()
	while toggleBtn.Parent do
		TweenService:Create(tGrad, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {Rotation = tGrad.Rotation + 180}):Play()
		task.wait(1.5)
	end
end)

toggleBtn.MouseEnter:Connect(function()
	TweenService:Create(toggleBtn, TweenInfo.new(0.15), {Size = UDim2.new(0, 188, 0, 54), TextColor3 = Color3.fromRGB(255, 230, 235)}):Play()
end)
toggleBtn.MouseLeave:Connect(function()
	TweenService:Create(toggleBtn, TweenInfo.new(0.15), {Size = UDim2.new(0, 180, 0, 50), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)

-- ===== VENTANA PRINCIPAL =====
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 560, 0, 650)
frame.Position = UDim2.new(0, 20, 0, 145)
frame.BackgroundColor3 = Color3.fromRGB(12, 8, 18)
frame.BorderSizePixel = 0
frame.Active = true
frame.Visible = false
frame.ClipsDescendants = true
frame.Parent = gui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame

local frameGrad = Instance.new("UIGradient")
frameGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 10, 20)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(12, 8, 18)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 8, 15)),
})
frameGrad.Rotation = 45
frameGrad.Parent = frame

safeLoop(function()
	while frame.Parent do
		if frame.Visible then
			TweenService:Create(frameGrad, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = frameGrad.Rotation + 180}):Play()
			task.wait(3)
		else
			task.wait(0.5)
		end
	end
end)

local frameStroke1 = Instance.new("UIStroke")
frameStroke1.Color = Color3.fromRGB(255, 50, 90)
frameStroke1.Thickness = 1.5
frameStroke1.Transparency = 0.1
frameStroke1.Parent = frame

local frameStroke2 = Instance.new("UIStroke")
frameStroke2.Color = Color3.fromRGB(255, 180, 210)
frameStroke2.Thickness = 0.5
frameStroke2.Transparency = 0.5
frameStroke2.Parent = frame

safeLoop(function()
	while frame.Parent do
		TweenService:Create(frameStroke1, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.65, Thickness = 2.5}):Play()
		task.wait(0.9)
		TweenService:Create(frameStroke1, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.05, Thickness = 1.5}):Play()
		task.wait(0.9)
	end
end)

cornerLine(frame, UDim2.new(0, 18, 0, 2), UDim2.new(0, 10, 0, 10))
cornerLine(frame, UDim2.new(0, 2, 0, 18), UDim2.new(0, 10, 0, 10))
cornerLine(frame, UDim2.new(0, 18, 0, 2), UDim2.new(1, -28, 0, 10))
cornerLine(frame, UDim2.new(0, 2, 0, 18), UDim2.new(1, -12, 0, 10))
cornerLine(frame, UDim2.new(0, 18, 0, 2), UDim2.new(0, 10, 1, -12))
cornerLine(frame, UDim2.new(0, 2, 0, 18), UDim2.new(0, 10, 1, -28))
cornerLine(frame, UDim2.new(0, 18, 0, 2), UDim2.new(1, -28, 1, -12))
cornerLine(frame, UDim2.new(0, 2, 0, 18), UDim2.new(1, -12, 1, -28))

-- ===== CABECERA =====
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 48)
titleBar.BackgroundColor3 = Color3.fromRGB(28, 10, 18)
titleBar.BackgroundTransparency = 0.1
titleBar.BorderSizePixel = 0
titleBar.Parent = frame

local titleBarCorner = Instance.new("UICorner")
titleBarCorner.CornerRadius = UDim.new(0, 8)
titleBarCorner.Parent = titleBar

local titleBarFix = Instance.new("Frame")
titleBarFix.Size = UDim2.new(1, 0, 0.5, 0)
titleBarFix.Position = UDim2.new(0, 0, 0.5, 0)
titleBarFix.BackgroundColor3 = Color3.fromRGB(28, 10, 18)
titleBarFix.BackgroundTransparency = 0.1
titleBarFix.BorderSizePixel = 0
titleBarFix.Parent = titleBar

local accent = Instance.new("Frame")
accent.Size = UDim2.new(1, -24, 0, 2)
accent.Position = UDim2.new(0, 12, 1, -2)
accent.BackgroundColor3 = Color3.fromRGB(255, 60, 100)
accent.BorderSizePixel = 0
accent.Parent = titleBar

local accentGrad = Instance.new("UIGradient")
accentGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 100)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 200, 220)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 60, 100)),
})
accentGrad.Parent = accent

safeLoop(function()
	while accent.Parent do
		TweenService:Create(accentGrad, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Offset = Vector2.new(1, 0)}):Play()
		task.wait(2)
		TweenService:Create(accentGrad, TweenInfo.new(0.01), {Offset = Vector2.new(-1, 0)}):Play()
	end
end)

-- ===== TÍTULO =====
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -120, 1, 0)
title.Position = UDim2.new(0, 16, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⛩  YAKUZA ON TOP"
title.TextColor3 = Color3.fromRGB(255, 90, 110)
title.Font = Enum.Font.GothamBlack
title.TextSize = 17
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextTruncate = Enum.TextTruncate.AtEnd
title.Parent = titleBar

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(0, 120, 0, 14)
subtitle.Position = UDim2.new(1, -160, 0, 8)
subtitle.BackgroundTransparency = 1
subtitle.Text = "CONTROL PANEL"
subtitle.TextColor3 = Color3.fromRGB(255, 150, 180)
subtitle.TextTransparency = 0.4
subtitle.Font = Enum.Font.GothamBold
subtitle.TextSize = 9
subtitle.TextXAlignment = Enum.TextXAlignment.Right
subtitle.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -38, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = false
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

closeBtn.MouseEnter:Connect(function()
	TweenService:Create(closeBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(120, 30, 30)}):Play()
end)
closeBtn.MouseLeave:Connect(function()
	TweenService:Create(closeBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(60, 20, 20)}):Play()
end)

local dragging, dragStart, startPos = false, nil, nil
titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
titleBar.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- ===== BUSCADOR + FLY SPEED + BOTÓN ESP =====
local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(0, 230, 0, 40)
searchBox.Position = UDim2.new(0, 16, 0, 62)
searchBox.BackgroundColor3 = Color3.fromRGB(22, 14, 24)
searchBox.Text = ""
searchBox.PlaceholderText = "🔍  Buscar jugador..."
searchBox.PlaceholderColor3 = Color3.fromRGB(150, 120, 150)
searchBox.TextColor3 = Color3.fromRGB(235, 225, 235)
searchBox.Font = Enum.Font.Gotham
searchBox.TextSize = 13
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.BorderSizePixel = 0
searchBox.ClearTextOnFocus = false
searchBox.Parent = frame

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 6)
searchCorner.Parent = searchBox

local searchStroke = Instance.new("UIStroke")
searchStroke.Color = Color3.fromRGB(110, 40, 75)
searchStroke.Thickness = 1
searchStroke.Parent = searchBox

local searchPadding = Instance.new("UIPadding")
searchPadding.PaddingLeft = UDim.new(0, 12)
searchPadding.Parent = searchBox

searchBox.Focused:Connect(function()
	TweenService:Create(searchStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(255, 80, 120), Thickness = 1.5}):Play()
end)
searchBox.FocusLost:Connect(function()
	TweenService:Create(searchStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(110, 40, 75), Thickness = 1}):Play()
end)

local flySpeedBox = Instance.new("TextBox")
flySpeedBox.Size = UDim2.new(0, 90, 0, 40)
flySpeedBox.Position = UDim2.new(0, 258, 0, 62)
flySpeedBox.BackgroundColor3 = Color3.fromRGB(22, 14, 28)
flySpeedBox.Text = "80"
flySpeedBox.PlaceholderText = "Fly"
flySpeedBox.PlaceholderColor3 = Color3.fromRGB(140, 110, 160)
flySpeedBox.TextColor3 = Color3.fromRGB(200, 170, 255)
flySpeedBox.Font = Enum.Font.GothamBold
flySpeedBox.TextSize = 15
flySpeedBox.TextXAlignment = Enum.TextXAlignment.Center
flySpeedBox.BorderSizePixel = 0
flySpeedBox.ClearTextOnFocus = false
flySpeedBox.Parent = frame

local flySpeedCorner = Instance.new("UICorner")
flySpeedCorner.CornerRadius = UDim.new(0, 6)
flySpeedCorner.Parent = flySpeedBox

local flySpeedStroke = Instance.new("UIStroke")
flySpeedStroke.Color = Color3.fromRGB(90, 50, 140)
flySpeedStroke.Thickness = 1
flySpeedStroke.Parent = flySpeedBox

flySpeedBox.Focused:Connect(function()
	TweenService:Create(flySpeedStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(190, 140, 255), Thickness = 1.5}):Play()
end)
flySpeedBox.FocusLost:Connect(function()
	TweenService:Create(flySpeedStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(90, 50, 140), Thickness = 1}):Play()
end)

local flyLabel = Instance.new("TextLabel")
flyLabel.Size = UDim2.new(0, 90, 0, 12)
flyLabel.Position = UDim2.new(0, 258, 0, 104)
flyLabel.BackgroundTransparency = 1
flyLabel.Text = "🕊 Fly Speed"
flyLabel.TextColor3 = Color3.fromRGB(190, 160, 230)
flyLabel.Font = Enum.Font.Gotham
flyLabel.TextSize = 10
flyLabel.TextXAlignment = Enum.TextXAlignment.Left
flyLabel.Parent = frame

local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0, 90, 0, 40)
espBtn.Position = UDim2.new(0, 356, 0, 62)
espBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
espBtn.Text = "ESP OFF"
espBtn.TextColor3 = Color3.fromRGB(255, 150, 150)
espBtn.Font = Enum.Font.GothamBold
espBtn.TextSize = 13
espBtn.BorderSizePixel = 0
espBtn.AutoButtonColor = false
espBtn.Parent = frame

local espBtnCorner = Instance.new("UICorner")
espBtnCorner.CornerRadius = UDim.new(0, 6)
espBtnCorner.Parent = espBtn

local espBtnStroke = Instance.new("UIStroke")
espBtnStroke.Color = Color3.fromRGB(120, 40, 40)
espBtnStroke.Thickness = 1
espBtnStroke.Parent = espBtn

espBtn.MouseEnter:Connect(function()
	TweenService:Create(espBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(80, 30, 30)}):Play()
end)
espBtn.MouseLeave:Connect(function()
	if espBtn.Text == "ESP OFF" then
		TweenService:Create(espBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 20, 20)}):Play()
	else
		TweenService:Create(espBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(20, 60, 20)}):Play()
	end
end)

local sep = Instance.new("Frame")
sep.Size = UDim2.new(1, -32, 0, 1)
sep.Position = UDim2.new(0, 16, 0, 128)
sep.BackgroundColor3 = Color3.fromRGB(70, 40, 60)
sep.BorderSizePixel = 0
sep.Parent = frame

-- ===== ZONA LISTA + ACCIONES =====
local contentY = 140

local listHeader = Instance.new("TextLabel")
listHeader.Size = UDim2.new(0, 200, 0, 18)
listHeader.Position = UDim2.new(0, 18, 0, contentY)
listHeader.BackgroundTransparency = 1
listHeader.Text = "👥 JUGADORES"
listHeader.TextColor3 = Color3.fromRGB(255, 150, 170)
listHeader.Font = Enum.Font.GothamBold
listHeader.TextSize = 11
listHeader.TextXAlignment = Enum.TextXAlignment.Left
listHeader.Parent = frame

local countLabel = Instance.new("TextLabel")
countLabel.Size = UDim2.new(0, 120, 0, 18)
countLabel.Position = UDim2.new(0, 130, 0, contentY)
countLabel.BackgroundTransparency = 1
countLabel.Text = "0"
countLabel.TextColor3 = Color3.fromRGB(160, 140, 170)
countLabel.Font = Enum.Font.Gotham
countLabel.TextSize = 11
countLabel.TextXAlignment = Enum.TextXAlignment.Left
countLabel.Parent = frame

local drop = Instance.new("ScrollingFrame")
drop.Size = UDim2.new(0, 300, 1, -238)
drop.Position = UDim2.new(0, 16, 0, contentY + 22)
drop.BackgroundColor3 = Color3.fromRGB(20, 14, 22)
drop.BackgroundTransparency = 0.15
drop.BorderSizePixel = 0
drop.CanvasSize = UDim2.new(0, 0, 0, 0)
drop.ScrollBarThickness = 5
drop.ScrollBarImageColor3 = Color3.fromRGB(255, 60, 100)
drop.ClipsDescendants = true
drop.Parent = frame

local dropCorner = Instance.new("UICorner")
dropCorner.CornerRadius = UDim.new(0, 6)
dropCorner.Parent = drop

local dropStroke = Instance.new("UIStroke")
dropStroke.Color = Color3.fromRGB(90, 40, 60)
dropStroke.Thickness = 1
dropStroke.Parent = drop

local dropLayout = Instance.new("UIListLayout")
dropLayout.Padding = UDim.new(0, 4)
dropLayout.SortOrder = Enum.SortOrder.LayoutOrder
dropLayout.Parent = drop

local dropPadding = Instance.new("UIPadding")
dropPadding.PaddingTop = UDim.new(0, 6)
dropPadding.PaddingLeft = UDim.new(0, 6)
dropPadding.PaddingRight = UDim.new(0, 6)
dropPadding.PaddingBottom = UDim.new(0, 6)
dropPadding.Parent = drop

local actionHeader = Instance.new("TextLabel")
actionHeader.Size = UDim2.new(0, 200, 0, 18)
actionHeader.Position = UDim2.new(1, -226, 0, contentY)
actionHeader.BackgroundTransparency = 1
actionHeader.Text = "⚙  ACCIONES"
actionHeader.TextColor3 = Color3.fromRGB(255, 150, 170)
actionHeader.Font = Enum.Font.GothamBold
actionHeader.TextSize = 11
actionHeader.TextXAlignment = Enum.TextXAlignment.Left
actionHeader.Parent = frame

local actionPanel = Instance.new("Frame")
actionPanel.Size = UDim2.new(0, 210, 1, -238)
actionPanel.Position = UDim2.new(1, -226, 0, contentY + 22)
actionPanel.BackgroundColor3 = Color3.fromRGB(20, 14, 22)
actionPanel.BackgroundTransparency = 0.15
actionPanel.BorderSizePixel = 0
actionPanel.Parent = frame

local actionCorner = Instance.new("UICorner")
actionCorner.CornerRadius = UDim.new(0, 6)
actionCorner.Parent = actionPanel

local actionStroke = Instance.new("UIStroke")
actionStroke.Color = Color3.fromRGB(90, 40, 60)
actionStroke.Thickness = 1
actionStroke.Parent = actionPanel

local actionPad = Instance.new("UIPadding")
actionPad.PaddingTop = UDim.new(0, 10)
actionPad.PaddingLeft = UDim.new(0, 8)
actionPad.PaddingRight = UDim.new(0, 8)
actionPad.Parent = actionPanel

local selectedLabel = Instance.new("TextLabel")
selectedLabel.Size = UDim2.new(1, 0, 0, 32)
selectedLabel.BackgroundTransparency = 1
selectedLabel.Text = "Ninguno seleccionado"
selectedLabel.TextColor3 = Color3.fromRGB(160, 140, 170)
selectedLabel.Font = Enum.Font.Gotham
selectedLabel.TextSize = 11
selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
selectedLabel.TextWrapped = true
selectedLabel.TextTruncate = Enum.TextTruncate.AtEnd
selectedLabel.Parent = actionPanel

-- TP
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(1, 0, 0, 46)
tpBtn.Position = UDim2.new(0, 0, 0, 40)
tpBtn.BackgroundColor3 = Color3.fromRGB(10, 5, 15)
tpBtn.Text = "📍  TP"
tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBtn.Font = Enum.Font.GothamBlack
tpBtn.TextSize = 15
tpBtn.BorderSizePixel = 0
tpBtn.AutoButtonColor = false
tpBtn.Parent = actionPanel

local tpCorner = Instance.new("UICorner")
tpCorner.CornerRadius = UDim.new(0, 4)
tpCorner.Parent = tpBtn

local tpGrad = Instance.new("UIGradient")
tpGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 40, 70)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 10, 30)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 40, 70)),
})
tpGrad.Rotation = 90
tpGrad.Parent = tpBtn

local tpStroke1 = Instance.new("UIStroke")
tpStroke1.Color = Color3.fromRGB(255, 80, 120)
tpStroke1.Thickness = 1.5
tpStroke1.Transparency = 0.1
tpStroke1.Parent = tpBtn

local tpStroke2 = Instance.new("UIStroke")
tpStroke2.Color = Color3.fromRGB(255, 200, 220)
tpStroke2.Thickness = 0.5
tpStroke2.Transparency = 0.4
tpStroke2.Parent = tpBtn

cornerLine(tpBtn, UDim2.new(0, 8, 0, 2), UDim2.new(0, 5, 0, 5))
cornerLine(tpBtn, UDim2.new(0, 2, 0, 8), UDim2.new(0, 5, 0, 5))
cornerLine(tpBtn, UDim2.new(0, 8, 0, 2), UDim2.new(1, -13, 1, -7))
cornerLine(tpBtn, UDim2.new(0, 2, 0, 8), UDim2.new(1, -7, 1, -13))

safeLoop(function()
	while tpBtn.Parent do
		TweenService:Create(tpStroke1, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.6, Thickness = 2.5}):Play()
		task.wait(0.8)
		TweenService:Create(tpStroke1, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.05, Thickness = 1.5}):Play()
		task.wait(0.8)
	end
end)

safeLoop(function()
	while tpBtn.Parent do
		TweenService:Create(tpGrad, TweenInfo.new(1.4, Enum.EasingStyle.Linear), {Rotation = tpGrad.Rotation + 180}):Play()
		task.wait(1.4)
	end
end)

tpBtn.MouseEnter:Connect(function()
	TweenService:Create(tpBtn, TweenInfo.new(0.15), {Size = UDim2.new(1, 0, 0, 50)}):Play()
end)
tpBtn.MouseLeave:Connect(function()
	TweenService:Create(tpBtn, TweenInfo.new(0.15), {Size = UDim2.new(1, 0, 0, 46)}):Play()
end)

-- FLY
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(1, 0, 0, 46)
flyBtn.Position = UDim2.new(0, 0, 0, 94)
flyBtn.BackgroundColor3 = Color3.fromRGB(10, 5, 18)
flyBtn.Text = "🕊  FLY"
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.Font = Enum.Font.GothamBlack
flyBtn.TextSize = 15
flyBtn.BorderSizePixel = 0
flyBtn.AutoButtonColor = false
flyBtn.Parent = actionPanel

local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 4)
flyCorner.Parent = flyBtn

local flyGrad = Instance.new("UIGradient")
flyGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 80, 255)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 20, 120)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 80, 255)),
})
flyGrad.Rotation = 90
flyGrad.Parent = flyBtn

local flyStroke1 = Instance.new("UIStroke")
flyStroke1.Color = Color3.fromRGB(180, 120, 255)
flyStroke1.Thickness = 1.5
flyStroke1.Transparency = 0.1
flyStroke1.Parent = flyBtn

local flyStroke2 = Instance.new("UIStroke")
flyStroke2.Color = Color3.fromRGB(230, 200, 255)
flyStroke2.Thickness = 0.5
flyStroke2.Transparency = 0.4
flyStroke2.Parent = flyBtn

cornerLine(flyBtn, UDim2.new(0, 8, 0, 2), UDim2.new(0, 5, 0, 5), Color3.fromRGB(200, 140, 255))
cornerLine(flyBtn, UDim2.new(0, 2, 0, 8), UDim2.new(0, 5, 0, 5), Color3.fromRGB(200, 140, 255))
cornerLine(flyBtn, UDim2.new(0, 8, 0, 2), UDim2.new(1, -13, 1, -7), Color3.fromRGB(200, 140, 255))
cornerLine(flyBtn, UDim2.new(0, 2, 0, 8), UDim2.new(1, -7, 1, -13), Color3.fromRGB(200, 140, 255))

safeLoop(function()
	while flyBtn.Parent do
		TweenService:Create(flyStroke1, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.6, Thickness = 2.5}):Play()
		task.wait(0.8)
		TweenService:Create(flyStroke1, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.05, Thickness = 1.5}):Play()
		task.wait(0.8)
	end
end)

safeLoop(function()
	while flyBtn.Parent do
		TweenService:Create(flyGrad, TweenInfo.new(1.4, Enum.EasingStyle.Linear), {Rotation = flyGrad.Rotation + 180}):Play()
		task.wait(1.4)
	end
end)

flyBtn.MouseEnter:Connect(function()
	TweenService:Create(flyBtn, TweenInfo.new(0.15), {Size = UDim2.new(1, 0, 0, 50)}):Play()
end)
flyBtn.MouseLeave:Connect(function()
	TweenService:Create(flyBtn, TweenInfo.new(0.15), {Size = UDim2.new(1, 0, 0, 46)}):Play()
end)

-- ESPECTAR
local spectateBtn = Instance.new("TextButton")
spectateBtn.Size = UDim2.new(1, 0, 0, 46)
spectateBtn.Position = UDim2.new(0, 0, 0, 148)
spectateBtn.BackgroundColor3 = Color3.fromRGB(5, 15, 20)
spectateBtn.Text = "👁  ESPECTAR"
spectateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
spectateBtn.Font = Enum.Font.GothamBlack
spectateBtn.TextSize = 15
spectateBtn.BorderSizePixel = 0
spectateBtn.AutoButtonColor = false
spectateBtn.Parent = actionPanel

local specCorner = Instance.new("UICorner")
specCorner.CornerRadius = UDim.new(0, 4)
specCorner.Parent = spectateBtn

local specGrad = Instance.new("UIGradient")
specGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 200, 255)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 80, 120)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 200, 255)),
})
specGrad.Rotation = 90
specGrad.Parent = spectateBtn

local specStroke1 = Instance.new("UIStroke")
specStroke1.Color = Color3.fromRGB(80, 220, 255)
specStroke1.Thickness = 1.5
specStroke1.Transparency = 0.1
specStroke1.Parent = spectateBtn

local specStroke2 = Instance.new("UIStroke")
specStroke2.Color = Color3.fromRGB(200, 240, 255)
specStroke2.Thickness = 0.5
specStroke2.Transparency = 0.4
specStroke2.Parent = spectateBtn

cornerLine(spectateBtn, UDim2.new(0, 8, 0, 2), UDim2.new(0, 5, 0, 5), Color3.fromRGB(120, 230, 255))
cornerLine(spectateBtn, UDim2.new(0, 2, 0, 8), UDim2.new(0, 5, 0, 5), Color3.fromRGB(120, 230, 255))
cornerLine(spectateBtn, UDim2.new(0, 8, 0, 2), UDim2.new(1, -13, 1, -7), Color3.fromRGB(120, 230, 255))
cornerLine(spectateBtn, UDim2.new(0, 2, 0, 8), UDim2.new(1, -7, 1, -13), Color3.fromRGB(120, 230, 255))

safeLoop(function()
	while spectateBtn.Parent do
		TweenService:Create(specStroke1, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.6, Thickness = 2.5}):Play()
		task.wait(0.8)
		TweenService:Create(specStroke1, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.05, Thickness = 1.5}):Play()
		task.wait(0.8)
	end
end)

safeLoop(function()
	while spectateBtn.Parent do
		TweenService:Create(specGrad, TweenInfo.new(1.4, Enum.EasingStyle.Linear), {Rotation = specGrad.Rotation + 180}):Play()
		task.wait(1.4)
	end
end)

spectateBtn.MouseEnter:Connect(function()
	TweenService:Create(spectateBtn, TweenInfo.new(0.15), {Size = UDim2.new(1, 0, 0, 50)}):Play()
end)
spectateBtn.MouseLeave:Connect(function()
	TweenService:Create(spectateBtn, TweenInfo.new(0.15), {Size = UDim2.new(1, 0, 0, 46)}):Play()
end)

-- ===== AVISO ESPECTAR =====
local spectateNotice = Instance.new("TextLabel")
spectateNotice.Size = UDim2.new(0, 360, 0, 28)
spectateNotice.Position = UDim2.new(0.5, -180, 0, 20)
spectateNotice.BackgroundColor3 = Color3.fromRGB(10, 20, 30)
spectateNotice.BackgroundTransparency = 0.25
spectateNotice.Text = ""
spectateNotice.TextColor3 = Color3.fromRGB(120, 230, 255)
spectateNotice.Font = Enum.Font.GothamBold
spectateNotice.TextSize = 13
spectateNotice.BorderSizePixel = 0
spectateNotice.Visible = false
spectateNotice.ZIndex = 30
spectateNotice.Parent = gui

local noticeCorner = Instance.new("UICorner")
noticeCorner.CornerRadius = UDim.new(0, 6)
noticeCorner.Parent = spectateNotice

local noticeStroke = Instance.new("UIStroke")
noticeStroke.Color = Color3.fromRGB(80, 220, 255)
noticeStroke.Thickness = 1
noticeStroke.Transparency = 0.2
noticeStroke.Parent = spectateNotice

-- ===== ESTADO =====
local selectedPlayer = nil
local filterText = ""

local function getMyRoot()
	local char = player.Character
	return char and char:FindFirstChild("HumanoidRootPart")
end

local function getTargetRoot()
	if not selectedPlayer then return nil end
	local char = selectedPlayer.Character
	return char and char:FindFirstChild("HumanoidRootPart")
end

-- ===== LÓGICA ESP (PERSISTENTE) =====
local espActive = false
local espTags = {}
local espHighlights = {}

local ESP_TAG = "Ref_" .. tostring(math.random(10000, 99999))
local ESP_HL  = "Node_" .. tostring(math.random(10000, 99999))

local function createESP(p)
	if p == player then return end
	local char = p.Character
	if not char then return end
	local head = char:FindFirstChild("Head")
	if not head then return end

	if espTags[p] and espTags[p].Parent then
		pcall(function() espTags[p]:Destroy() end)
	end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = ESP_TAG
	billboard.Size = UDim2.new(0, 200, 0, 50)
	billboard.StudsOffset = Vector3.new(0, 2.5, 0)
	billboard.AlwaysOnTop = true
	billboard.Adornee = head
	billboard.Parent = head

	local text = Instance.new("TextLabel")
	text.Size = UDim2.new(1, 0, 1, 0)
	text.BackgroundTransparency = 1
	text.TextColor3 = Color3.fromRGB(255, 100, 120)
	text.Font = Enum.Font.GothamBold
	text.TextSize = 14
	text.TextStrokeTransparency = 0.5
	text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	text.Parent = billboard

	espTags[p] = billboard
end

local function createHighlight(p)
	if p == player then return end
	local char = p.Character
	if not char then return end

	if espHighlights[p] then
		pcall(function() espHighlights[p]:Destroy() end)
	end

	local ok, hl = pcall(function()
		local h = Instance.new("Highlight")
		h.Name = ESP_HL
		h.FillColor = Color3.fromRGB(255, 0, 0)
		h.OutlineColor = Color3.fromRGB(255, 0, 0)
		h.FillTransparency = 0.5
		h.OutlineTransparency = 0
		h.Adornee = char
		h.Parent = char
		return h
	end)
	if ok and hl then
		espHighlights[p] = hl
	end
end

local function applyESPToPlayer(p, retries)
	if not espActive or p == player then return end
	retries = retries or 10

	local char = p.Character
	if char and char:FindFirstChild("Head") then
		pcall(createESP, p)
		pcall(createHighlight, p)
	else
		if retries > 0 then
			task.delay(0.5, function()
				applyESPToPlayer(p, retries - 1)
			end)
		end
	end
end

local function applyESPToAll()
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then
			pcall(applyESPToPlayer, p)
		end
	end
end

local function toggleESP()
	espActive = not espActive
	if espActive then
		espBtn.Text = "ESP ON"
		espBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 20)
		espBtn.TextColor3 = Color3.fromRGB(150, 255, 150)
		espBtnStroke.Color = Color3.fromRGB(40, 120, 40)

		applyESPToAll()
	else
		espBtn.Text = "ESP OFF"
		espBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
		espBtn.TextColor3 = Color3.fromRGB(255, 150, 150)
		espBtnStroke.Color = Color3.fromRGB(120, 40, 40)

		for p, tag in pairs(espTags) do
			if tag then pcall(function() tag:Destroy() end) end
			espTags[p] = nil
		end
		for p, hl in pairs(espHighlights) do
			if hl then pcall(function() hl:Destroy() end) end
			espHighlights[p] = nil
		end
	end
end

espBtn.MouseButton1Click:Connect(toggleESP)

local function updateESP()
	if not espActive then return end
	local myRoot = getMyRoot()
	if not myRoot then return end
	local myPos = myRoot.Position

	for p, guiTag in pairs(espTags) do
		if not guiTag.Parent or not p.Character then
			if guiTag then pcall(function() guiTag:Destroy() end) end
			espTags[p] = nil
		else
			local targetHead = p.Character:FindFirstChild("Head")
			local targetRoot = p.Character:FindFirstChild("HumanoidRootPart")
			if targetHead and targetRoot then
				local dist = math.floor((myPos - targetRoot.Position).Magnitude)
				local txt = guiTag:FindFirstChildOfClass("TextLabel")
				if txt then
					txt.Text = p.Name .. " [" .. dist .. "m]"
				end
			end
		end
	end
end

RunService.RenderStepped:Connect(updateESP)

local function hookPlayer(p)
	if espActive then
		applyESPToPlayer(p)
	end
	p.CharacterAdded:Connect(function(char)
		if not espActive or p == player then return end
		local headFound = false
		local tries = 0
		while not headFound and tries < 20 do
			if char and char:FindFirstChild("Head") then
				headFound = true
			else
				tries += 1
				task.wait(0.25)
			end
		end
		if espActive and char and char:FindFirstChild("Head") then
			pcall(createESP, p)
			pcall(createHighlight, p)
		elseif espActive then
			applyESPToPlayer(p)
		end
	end)
end

for _, p in ipairs(Players:GetPlayers()) do
	hookPlayer(p)
end

Players.PlayerAdded:Connect(function(p)
	hookPlayer(p)
end)

Players.PlayerRemoving:Connect(function(p)
	if espTags[p] then
		pcall(function() espTags[p]:Destroy() end)
		espTags[p] = nil
	end
	if espHighlights[p] then
		pcall(function() espHighlights[p]:Destroy() end)
		espHighlights[p] = nil
	end
end)

player.CharacterAdded:Connect(function()
	if espActive then
		task.wait(0.5)
		applyESPToAll()
	end
end)

-- ===== ESPECTAR =====
local spectating = false
local spectateTarget = nil

local function stopSpectate()
	spectating = false
	spectateTarget = nil
	local cam = workspace.CurrentCamera
	cam.CameraType = Enum.CameraType.Custom
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		cam.CameraSubject = hum
	end
	spectateNotice.Visible = false
	spectateBtn.Text = "👁  ESPECTAR"
end

local function startSpectate()
	if not selectedPlayer then
		spectateBtn.Text = "⚠ SELECCIONA ALGUIEN"
		task.wait(1.2)
		spectateBtn.Text = "👁  ESPECTAR"
		return
	end
	if selectedPlayer == player then
		spectateBtn.Text = "⚠ ERES TÚ"
		task.wait(1.2)
		spectateBtn.Text = "👁  ESPECTAR"
		return
	end
	if spectating then
		stopSpectate()
	end
	local char = selectedPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hum then
		spectateBtn.Text = "⚠ SIN PERSONAJE"
		task.wait(1.2)
		spectateBtn.Text = "👁  ESPECTAR"
		return
	end
	spectating = true
	spectateTarget = selectedPlayer
	local cam = workspace.CurrentCamera
	cam.CameraType = Enum.CameraType.Custom
	cam.CameraSubject = hum
	spectateNotice.Text = "👁  ESPECTANDO: " .. selectedPlayer.Name
	spectateNotice.Visible = true
	spectateBtn.Text = "👁  SALIR DE ESPECTAR"
end

safeLoop(function()
	while gui.Parent do
		if spectating and spectateTarget then
			local cam = workspace.CurrentCamera
			local tChar = spectateTarget.Character
			local tHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
			if tHum then
				if cam.CameraSubject ~= tHum then
					cam.CameraType = Enum.CameraType.Custom
					cam.CameraSubject = tHum
				end
				local txt = "👁  ESPECTANDO: " .. spectateTarget.Name
				if spectateNotice.Text ~= txt then
					spectateNotice.Text = txt
				end
			else
				local txt = "👁  ESPERANDO A " .. spectateTarget.Name .. "..."
				if spectateNotice.Text ~= txt then
					spectateNotice.Text = txt
				end
			end
		end
		task.wait(0.25)
	end
end)

spectateBtn.MouseButton1Click:Connect(function()
	if spectating then
		stopSpectate()
	else
		startSpectate()
	end
end)

-- ===== TP =====
tpBtn.MouseButton1Click:Connect(function()
	if spectating then stopSpectate() end

	if not selectedPlayer then
		tpBtn.Text = "⚠ SELECCIONA ALGUIEN"
		task.wait(1.2)
		tpBtn.Text = "📍  TP"
		return
	end
	local myRoot = getMyRoot()
	local targetRoot = getTargetRoot()
	if not myRoot then
		tpBtn.Text = "⚠ SIN PERSONAJE"
		task.wait(1.2)
		tpBtn.Text = "📍  TP"
		return
	end
	if not targetRoot then
		tpBtn.Text = "⚠ SIN TARGET"
		task.wait(1.2)
		tpBtn.Text = "📍  TP"
		return
	end
	if selectedPlayer == player then
		tpBtn.Text = "⚠ YA ESTÁS AQUÍ"
		task.wait(1.2)
		tpBtn.Text = "📍  TP"
		return
	end
	pcall(function()
		local targetPos = targetRoot.Position
		local targetLook = targetRoot.CFrame.LookVector
		local offset = targetLook * -3
		myRoot.CFrame = CFrame.new(targetPos + offset, targetPos)
	end)
	tpBtn.Text = "✅ TP A " .. selectedPlayer.Name
	task.wait(1.2)
	tpBtn.Text = "📍  TP"
end)

-- ===== FLY =====
local flying = false
local flySpeed = 80
local flyConnection = nil
local flyBodyVel = nil
local flyBodyGyro = nil
local savedWalkSpeed = 16

local function getFlySpeedFromBox()
	local v = tonumber(flySpeedBox.Text)
	if v and v > 0 then
		flySpeed = v
	end
	return flySpeed
end

local function stopFly()
	flying = false
	if flyConnection then flyConnection:Disconnect() flyConnection = nil end
	if flyBodyVel then pcall(function() flyBodyVel:Destroy() end) flyBodyVel = nil end
	if flyBodyGyro then pcall(function() flyBodyGyro:Destroy() end) flyBodyGyro = nil end
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.PlatformStand = false
		hum.WalkSpeed = savedWalkSpeed or 16
	end
	flyBtn.Text = "🕊  FLY"
end

local function startFly()
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not hum or not root then return end
	getFlySpeedFromBox()
	savedWalkSpeed = hum.WalkSpeed
	flying = true
	hum.PlatformStand = true

	pcall(function()
		flyBodyVel = Instance.new("BodyVelocity")
		flyBodyVel.Name = "HumanoidPlatformStandPhysics_Vel"
		flyBodyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		flyBodyVel.Velocity = Vector3.zero
		flyBodyVel.Parent = root
	end)
	pcall(function()
		flyBodyGyro = Instance.new("BodyGyro")
		flyBodyGyro.Name = "HumanoidPlatformStandPhysics_Gyro"
		flyBodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
		flyBodyGyro.P = 1000
		flyBodyGyro.D = 50
		flyBodyGyro.Parent = root
	end)

	flyConnection = RunService.RenderStepped:Connect(function()
		local cam = workspace.CurrentCamera
		local dir = Vector3.zero
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0, 1, 0) end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.new(0, 1, 0) end
		pcall(function()
			if flyBodyVel then
				if dir.Magnitude > 0 then
					flyBodyVel.Velocity = dir.Unit * flySpeed
				else
					flyBodyVel.Velocity = Vector3.zero
				end
			end
			if flyBodyGyro then
				flyBodyGyro.CFrame = cam.CFrame
			end
		end)
	end)
	flyBtn.Text = "🕊  FLY ON (" .. flySpeed .. ")"
end

flyBtn.MouseButton1Click:Connect(function()
	if flying then
		stopFly()
	else
		pcall(startFly)
	end
end)

flySpeedBox:GetPropertyChangedSignal("Text"):Connect(function()
	if flying then
		getFlySpeedFromBox()
	end
end)

player.CharacterAdded:Connect(function()
	if flying then stopFly() end
end)

-- ===== LISTA JUGADORES =====
local function refreshList()
	for _, c in ipairs(drop:GetChildren()) do
		if c:IsA("TextButton") then c:Destroy() end
	end

	local count = 0
	local total = 0
	for _, p in ipairs(Players:GetPlayers()) do
		total += 1
		if filterText == "" or string.find(string.lower(p.Name), string.lower(filterText), 1, true) then
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, -12, 0, 40)
			btn.BackgroundColor3 = (p == selectedPlayer) and Color3.fromRGB(120, 20, 30) or Color3.fromRGB(32, 22, 38)
			btn.BackgroundTransparency = (p == selectedPlayer) and 0 or 0.15
			btn.Text = ""
			btn.BorderSizePixel = 0
			btn.AutoButtonColor = false
			btn.LayoutOrder = count
			btn.Parent = drop

			local c2 = Instance.new("UICorner")
			c2.CornerRadius = UDim.new(0, 4)
			c2.Parent = btn

			local btnStroke = Instance.new("UIStroke")
			btnStroke.Color = (p == selectedPlayer) and Color3.fromRGB(255, 80, 120) or Color3.fromRGB(70, 50, 80)
			btnStroke.Thickness = 1
			btnStroke.Parent = btn

			local avatar = Instance.new("ImageLabel")
			avatar.Size = UDim2.new(0, 30, 0, 30)
			avatar.Position = UDim2.new(0, 5, 0.5, -15)
			avatar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
			avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. p.UserId .. "&w=48&h=48"
			avatar.BorderSizePixel = 0
			avatar.Parent = btn

			local avCorner = Instance.new("UICorner")
			avCorner.CornerRadius = UDim.new(1, 0)
			avCorner.Parent = avatar

			local nameLbl = Instance.new("TextLabel")
			nameLbl.Size = UDim2.new(1, -90, 1, 0)
			nameLbl.Position = UDim2.new(0, 42, 0, 0)
			nameLbl.BackgroundTransparency = 1
			nameLbl.Text = (p == player and "⭐ " or "") .. p.Name
			nameLbl.TextColor3 = (p == selectedPlayer) and Color3.fromRGB(255, 220, 230) or Color3.fromRGB(220, 210, 230)
			nameLbl.Font = Enum.Font.GothamMedium
			nameLbl.TextSize = 13
			nameLbl.TextXAlignment = Enum.TextXAlignment.Left
			nameLbl.Parent = btn

			local checkLbl = Instance.new("TextLabel")
			checkLbl.Size = UDim2.new(0, 24, 1, 0)
			checkLbl.Position = UDim2.new(1, -28, 0, 0)
			checkLbl.BackgroundTransparency = 1
			checkLbl.Text = (p == selectedPlayer) and "✔" or ""
			checkLbl.TextColor3 = Color3.fromRGB(255, 80, 120)
			checkLbl.Font = Enum.Font.GothamBold
			checkLbl.TextSize = 14
			checkLbl.Parent = btn

			btn.MouseEnter:Connect(function()
				if p ~= selectedPlayer then
					TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(55, 35, 65), BackgroundTransparency = 0}):Play()
				end
			end)
			btn.MouseLeave:Connect(function()
				if p ~= selectedPlayer then
					TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(32, 22, 38), BackgroundTransparency = 0.15}):Play()
				end
			end)
			btn.MouseButton1Click:Connect(function()
				selectedPlayer = p
				selectedLabel.Text = "Seleccionado: " .. p.Name
				selectedLabel.TextColor3 = Color3.fromRGB(255, 200, 210)
				refreshList()
			end)

			count += 1
		end
	end

	drop.CanvasSize = UDim2.new(0, 0, 0, count * 44 + 12)
	countLabel.Text = "(" .. total .. (filterText ~= "" and (" / " .. count) or "") .. ")"
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	filterText = searchBox.Text
	refreshList()
end)

refreshList()
Players.PlayerAdded:Connect(refreshList)
Players.PlayerRemoving:Connect(function()
	task.wait(0.1)
	refreshList()
end)

-- ===== ABRIR / CERRAR =====
local panelOpen = false
local function setPanel(open)
	panelOpen = open
	if open then
		frame.Visible = true
		frame.Size = UDim2.new(0, 560, 0, 0)
		TweenService:Create(frame, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 560, 0, 650)}):Play()
		toggleBtn.Text = "⚡ CERRAR"
	else
		TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 560, 0, 0)}):Play()
		task.wait(0.2)
		frame.Visible = false
		toggleBtn.Text = "⚡ ABRIR MENÚ"
	end
end

toggleBtn.MouseButton1Click:Connect(function() setPanel(not panelOpen) end)
closeBtn.MouseButton1Click:Connect(function() setPanel(false) end)

-- ================= [ANTIBAN] LIMPIEZA FINAL =================
player.OnTeleport:Connect(function()
	antiLagEnabled = false
	for _, conn in ipairs(_loops) do
		pcall(function()
			if type(conn) == "thread" then task.cancel(conn) end
		end)
	end
	if flying then pcall(stopFly) end
end)
