local plr = game.Players
--local locplr = plr.LocalPlayer
local scriptName = "[Maks's FPS Optimizer]"

if change_mat == nil then
    exclude_players = false
    --local exclude_localplayer = true
    faceless = false

    change_mat = true
    remove_tex = true
    remove_mesh = false
    remove_particles = false
    mat = Enum.Material.SmoothPlastic
    ignoreffmat = true

    optimizeLighting = false

    debug = false
end

local startTime = os.clock()
local function optimize(a)
    for _, v in next, a:GetDescendants() do
        local function applyMat()
            if ignoreffmat then
                if v.Material ~= Enum.Material.ForceField and v.Material ~= mat and v.Material ~= Enum.Material.Neon then
                    v.Material = mat
                    if debug then
                        print(scriptName, v.ClassName .. " | " .. v.Name, "| has been solidified")
                    end
                end
            elseif v.Material ~= mat and v.Material ~= Enum.Material.Neon then
                v.Material = mat
                if debug then
                    print(scriptName, v.ClassName .. " | " .. v.Name, "| has been solidified")
                end
            end
        end
        if v:IsA("Decal") or v:IsA("Texture") then
            if remove_tex then
                local function purge()
                    v:Destroy()
                    if debug then
                        print(scriptName, v.ClassName .. " | " .. v.Name, "| has been destroyed")
                    end
                end
                if v.Texture ~= "http://www.roblox.com/asset/?id=6239942134" and v.Texture ~= "rbxassetid://6239942134" and v.Texture ~= "6239942134" then
                    if faceless ~= true then
                        if v.Parent.Name ~= "Shine" and v.Parent.Name ~= "EyeShinePart" and v.Parent.Name ~= "Head" then
                        --[[v.Name ~= "Eyes" and v.Name ~= "Mouth" and v.Name ~= "EyeBrows" and v.Name ~= "EyeShine" and]]
                            purge()
                        end
                    else
                        purge()
                    end
                end
            end
        elseif v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("WedgePart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            if change_mat then
                applyMat()
            end
        elseif v:IsA("MeshPart") then
            if remove_tex then
                if v.TextureID ~= "" then
                    v.TextureID = ""
                    if debug then
                        print(scriptName, v.ClassName .. " | " .. v.Name, "| removed TextureID")
                    end
                end
            end
            if change_mat then
                applyMat()
            end
            if remove_mesh then
                if v.MeshId ~= "" then
                    v.MeshId = ""
                    if debug then
                        print(scriptName, v.ClassName .. " | " .. v.Name, "| removed MeshId")
                    end
                end
            end
        elseif v:IsA("SpecialMesh") and v.TextureId then
            if remove_tex then
                v.TextureId = ""

                if debug then
                    print(scriptName, v.ClassName .. " | " .. v.Name, "| removed TextureId")
                end
            end
            if remove_mesh then
                if v.MeshId ~= "" then
                    v.MeshId = ""
                    if debug then
                        print(scriptName, v.ClassName .. " | " .. v.Name, "| removed MeshId")
                    end
                end
            end
        elseif v:IsA("ParticleEmitter") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
            if remove_particles then
                v:Destroy()
            end
        end
    end
    if optimizeLighting then
        for i,v in next, game.Lighting:GetChildren() do
            if v:IsA("Atmosphere") or v:IsA("SunRaysEffect") or v:IsA("DepthOfFieldEffect") then
                v:Destroy()
                if debug then
                    print(scriptName, "Removed: ", v.ClassName)
                end
            end
        end
    end
end

for i, r in next, workspace:GetChildren() do
    if exclude_players then
        if r:IsA("Highlight") and r.Name == "Players" then
            return
        end
    end
    optimize(r)
end

local terraria = workspace:FindFirstChild("Terrain")
terraria.WaterReflectance = 0
terraria.WaterWaveSize = 0
terraria.WaterWaveSpeed = 0

local deltaTime = os.clock() - startTime
print(scriptName, ("Finished cleaning up everything, took %.2f seconds"):format(deltaTime))

plr.PlayerAdded:Connect(function(pplr)
    if exclude_players then return end
    task.wait(5)
    optimize(pplr.Character)
    if debug then
        print(scriptName, "Newly created character has been optimized:", pplr.Character.Name)
    end
end)
for i, v in ipairs(plr:GetPlayers()) do
    if exclude_players then return end
    v.CharacterAdded:Connect(function(chr)
        task.wait(0.5)
        optimize(chr)
    end)
    if v.Character then
        optimize(v)
    end
end