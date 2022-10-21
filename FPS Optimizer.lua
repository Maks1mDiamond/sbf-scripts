local plr = game.Players
--local locplr = plr.LocalPlayer

local exclude_players = false
--local exclude_localplayer = true
local faceless = false

local change_mat = true
local remove_tex = true
local remove_mesh = false
local remove_particles = false
local mat = Enum.Material.SmoothPlastic

local debug = false

local startTime = os.clock()
local function optimize(a)
    for _, v in next, a:GetDescendants() do
        if v:IsA("Decal") or v:IsA("Texture") then
            if remove_tex then
                local function purge()
                    v:Destroy()
                    if debug then
                        print(v.ClassName .. " | " .. v.Name, "| has been destroyed")
                    end
                end
                if faceless ~= true then
                    if v.Texture ~= "http://www.roblox.com/asset/?id=6239942134" and v.Texture ~= "rbxassetid://6239942134" and v.Texture ~= "6239942134" and
                    --[[v.Name ~= "Eyes" and v.Name ~= "Mouth" and v.Name ~= "EyeBrows" and v.Name ~= "EyeShine" and v.Parent.Name ~= "Shine" and]]
                    v.Parent.Name ~= "EyeShinePart" and v.Parent.Name ~= "Head" then
                        purge()
                    end
                else
                    if v.Texture ~= "http://www.roblox.com/asset/?id=6239942134" and v.Texture ~= "rbxassetid://6239942134" and v.Texture ~= "6239942134" then
                        purge()
                    end
                end
            end
        elseif v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("WedgePart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            if change_mat then
                if v.Material ~= mat and v.Material ~= Enum.Material.Neon then
                    v.Material = mat
                    if debug then
                        print(v.ClassName .. " | " .. v.Name, "| has been solidified")
                    end
                end
            end
        elseif v:IsA("MeshPart") then
            if remove_tex then
                if v.TextureID ~= "" then
                    v.TextureID = ""
                    if debug then
                        print(v.ClassName .. " | " .. v.Name, "| removed TextureID")
                    end
                end
            end
            if change_mat then
                if v.Material ~= mat and v.Material ~= Enum.Material.Neon then
                    v.Material = mat
                    if debug then
                        print(v.ClassName .. " | " .. v.Name, "| has been solidified")
                    end
                end
            end
            if remove_mesh then
                if v.MeshId ~= "" then
                    v.MeshId = ""
                    if debug then
                        print(v.ClassName .. " | " .. v.Name, "| removed MeshId")
                    end
                end
            end
        elseif v:IsA("SpecialMesh") and v.TextureId then
            if remove_tex then
                v.TextureId = ""

                if debug then
                    print(v.ClassName .. " | " .. v.Name, "| removed TextureId")
                end
            end
            if remove_mesh then
                if v.MeshId ~= "" then
                    v.MeshId = ""
                    if debug then
                        print(v.ClassName .. " | " .. v.Name, "| removed MeshId")
                    end
                end
            end
        elseif v:IsA("ParticleEmitter") then
            if remove_particles then
                v:Destroy()
            end
        end
    end
end

for i, r in next, workspace:GetChildren() do
    if exclude_players then
        if r:IsA("Highlight") and r.Name == "Players" then
            return
        end
    --[[
    elseif exclude_localplayer then
        if r:IsA("Highlight") and r.Name == "Players" then
            if r:FindFirstChild(locplr.Name) then
                return
            end
        end
    ]]
    end
    optimize(r)
end

local terraria = workspace:FindFirstChild("Terrain")
terraria.WaterReflectance = 0
terraria.WaterWaveSize = 0
terraria.WaterWaveSpeed = 0

local deltaTime = os.clock() - startTime
print(("Finished cleaning up everything, took %.2f seconds"):format(deltaTime))

plr.PlayerAdded:Connect(function(pplr)
    if exclude_players then
        return
    end
    task.wait(5)
    optimize(pplr.Character)
end)
for i, v in ipairs(plr:GetPlayers()) do
    if exclude_players then
        return
    end
    local function fard()
        v.CharacterAdded:Connect(function(chr)
            task.wait(0.5)
            optimize(chr)
        end)
        if v.Character then
            optimize(v)
        end
    end
    fard()
    --[[if exclude_localplayer then
        if v ~= locplr then
            fard()
        end
    else
        fard()
    end]]
end
