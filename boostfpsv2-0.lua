repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

pcall(function()
	StarterGui:SetCore("SendNotification",{
		Title = "Script Notification",
		Text = "Boost Fps Successful✅",
		Duration = 5
	})
end)

Lighting.GlobalShadows = false
Lighting.Brightness = 1
Lighting.FogEnd = 9e9
Lighting.Ambient = Color3.fromRGB(120,120,120)
Lighting.OutdoorAmbient = Color3.fromRGB(120,120,120)

local function RemoveEffects(obj)
	for _,v in pairs(obj:GetDescendants()) do
		if v:IsA("ParticleEmitter")
		or v:IsA("Trail")
		or v:IsA("Beam")
		or v:IsA("Smoke")
		or v:IsA("Fire")
		or v:IsA("Sparkles") then
			v.Enabled = false
		elseif v:IsA("PointLight")
		or v:IsA("SpotLight")
		or v:IsA("SurfaceLight") then
			v.Enabled = false
		elseif v:IsA("Decal") or v:IsA("Texture") then
			v.Transparency = 1
		elseif v:IsA("MeshPart") then
			if v.Name:lower():find("effect")
			or v.Name:lower():find("fx")
			or v.Name:lower():find("skill") then
				v.Transparency = 1
				v.Material = Enum.Material.SmoothPlastic
			end
		end
	end
end

for _,v in pairs(workspace:GetDescendants()) do
	if v:IsA("BasePart") then
		v.Material = Enum.Material.SmoothPlastic
		v.CastShadow = false
		v.Color = Color3.fromRGB(130,130,130)
		v.Transparency = math.clamp(v.Transparency + 0.6, 0, 1)
	end
end

pcall(function()
	local t = workspace.Terrain
	t.WaterTransparency = 1
	t.WaterWaveSize = 0
	t.WaterWaveSpeed = 0
end)

for _,v in pairs(game:GetDescendants()) do
	if v:IsA("Sound") then
		v.Volume = 0
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

if player.Character then
	InvisibleChar(player.Character)
end
player.CharacterAdded:Connect(InvisibleChar)

RemoveEffects(workspace)

workspace.DescendantAdded:Connect(function(v)
	task.wait()
	pcall(function()
		RemoveEffects(v)
	end)
end)

print("Loaded")
