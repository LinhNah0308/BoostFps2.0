repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

pcall(function()
	StarterGui:SetCore("SendNotification",{
		Title = "Script Notification",
		Text = "✅Boost Fps Successful✅",
		Duration = 5
	})
end)

for _,v in pairs(Lighting:GetChildren()) do
	if v:IsA("PostEffect") then v:Destroy() end
end

local cc = Instance.new("ColorCorrectionEffect")
cc.Saturation = -1
cc.TintColor = Color3.fromRGB(160,160,160)
cc.Parent = Lighting

Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 1
Lighting.Ambient = Color3.fromRGB(150,150,150)
Lighting.OutdoorAmbient = Color3.fromRGB(150,150,150)

local function KillEffect(v)
	if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam")
	or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
		v.Enabled = false
	elseif v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight") then
		v.Enabled = false
	elseif v:IsA("Decal") or v:IsA("Texture") then
		v.Transparency = 1
	elseif v:IsA("Highlight") then
		v.Enabled = false
	end
end

local function SimplifyMap(v)
	if v:IsA("BasePart") then
		v.Material = Enum.Material.SmoothPlastic
		v.CastShadow = false
		v.Color = Color3.fromRGB(150,150,150)
		v.Transparency = 0.9
		v.CanCollide = true
	end
end

local function InvisibleNPC(model)
	if model:IsA("Model")
	and model:FindFirstChildOfClass("Humanoid")
	and not Players:GetPlayerFromCharacter(model) then
		for _,v in pairs(model:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Transparency = 1
				v.CanCollide = true
			elseif v:IsA("Decal") then
				v.Transparency = 1
			end
		end
	end
end

local function InvisibleChar(char)
	for _,v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Transparency = 1
			v.CanCollide = true
		elseif v:IsA("Decal") then
			v.Transparency = 1
		end
	end
end

if player.Character then InvisibleChar(player.Character) end
player.CharacterAdded:Connect(InvisibleChar)

pcall(function()
	local t = workspace.Terrain
	t.WaterTransparency = 1
	t.WaterWaveSize = 0
	t.WaterWaveSpeed = 0
end)

for _,v in pairs(game:GetDescendants()) do
	if v:IsA("Sound") then v.Volume = 0 end
end

RunService.RenderStepped:Connect(function()
	for _,v in pairs(workspace:GetDescendants()) do
		KillEffect(v)
		SimplifyMap(v)
		InvisibleNPC(v)
	end
end)

print("Loaded")
