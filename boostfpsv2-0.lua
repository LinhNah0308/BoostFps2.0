repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local Debris = game:GetService("Debris")
local player = Players.LocalPlayer

pcall(function()
	StarterGui:SetCore("SendNotification",{
		Title = "Script Notification",
		Text = "Boost Fps Successful✅",
		Duration = 5
	})
end)

-- ===== LIGHTING / FPS =====
Lighting.GlobalShadows = false
Lighting.Brightness = 1
Lighting.FogEnd = 9e9
Lighting.Ambient = Color3.fromRGB(120,120,120)
Lighting.OutdoorAmbient = Color3.fromRGB(120,120,120)

-- ===== EFFECT NAME CHECK =====
local EffectNames = {
	"damage","dmg","hit","hits","effect","fx","vfx",
	"smoke","slash","cut","explosion","boom",
	"shock","shockwave","burn","fire","spark"
}

local function IsEffectName(name)
	name = string.lower(name)
	for _,v in pairs(EffectNames) do
		if string.find(name, v) then
			return true
		end
	end
	return false
end

-- ===== MAP LOW =====
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

-- ===== AUTO TÀNG HÌNH PLAYER (LUÔN + SAU KHI CHẾT) =====
local function InvisiblePlayer(char)
	task.wait(0.3)
	for _,v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Transparency = 1
			v.CanCollide = true
			v.CastShadow = false
		elseif v:IsA("Decal") then
			v.Transparency = 1
		end
	end
end

local function OnCharacterAdded(char)
	InvisiblePlayer(char)
	local hum = char:WaitForChild("Humanoid", 5)
	if hum then
		hum.Died:Connect(function()
			local newChar = player.CharacterAdded:Wait()
			InvisiblePlayer(newChar)
		end)
	end
end

if player.Character then
	OnCharacterAdded(player.Character)
end
player.CharacterAdded:Connect(OnCharacterAdded)

-- ===== AUTO REMOVE EFFECT SPAWN (0.1s LOOP) =====
task.spawn(function()
	while true do
		task.wait(0.1)
		pcall(function()
			for _,v in ipairs(workspace:GetDescendants()) do
				if IsEffectName(v.Name)
				or v:IsA("ParticleEmitter")
				or v:IsA("Trail")
				or v:IsA("Beam")
				or v:IsA("Smoke")
				or v:IsA("Fire")
				or v:IsA("Sparkles")
				or v:IsA("Explosion")
				or v:IsA("BillboardGui")
				or v:IsA("SurfaceGui") then
					Debris:AddItem(v, 0)

				elseif v:IsA("Decal") or v:IsA("Texture") then
					v.Transparency = 1

				elseif v:IsA("PointLight")
				or v:IsA("SpotLight")
				or v:IsA("SurfaceLight") then
					v.Enabled = false
				end
			end
		end)
	end
end)

-- ===== AUTO TÀNG HÌNH QUÁI / MOB =====
task.spawn(function()
	while true do
		task.wait(0.1)
		for _,m in pairs(workspace:GetDescendants()) do
			if m:IsA("Model") and m:FindFirstChild("Humanoid") and m ~= player.Character then
				for _,p in pairs(m:GetDescendants()) do
					if p:IsA("BasePart") then
						p.Transparency = 1
						p.CastShadow = false
						p.CanCollide = true
					elseif p:IsA("Decal") or p:IsA("Texture") then
						p.Transparency = 1
					end
				end
			end
		end
	end
end)

-- ===== AUTO TÀNG HÌNH 99,99% KHỐI XUNG QUANH PLAYER =====
task.spawn(function()
	while true do
		task.wait(5)
		local char = player.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if hrp then
			local pos = hrp.Position
			for _,v in pairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") and (v.Position - pos).Magnitude <= 1000 then
					v.Transparency = math.max(v.Transparency, 0.9999)
					v.CastShadow = false
					v.Material = Enum.Material.SmoothPlastic
				end
			end
		end
	end
end)

print("Loaded")
