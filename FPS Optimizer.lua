local plr = game.Players
local locplr = plr.LocalPlayer

local exclude_players = false
local exclude_localplayer = true

local change_mat = true
local remove_tex = true
local mat = Enum.Material.SmoothPlastic

local debug = false



local startTime = os.clock()
local function optimize(a)
    for _, v in next, a:GetDescendants() do
        -- DECALS
        if v:IsA("Decal") or v:IsA("Texture") then
            if remove_tex then
                if v.Texture ~= "http://www.roblox.com/asset/?id=6239942134" and v.Texture ~= "rbxassetid://6239942134" and v.Texture ~= "6239942134" then
                    v:Destroy()
                    if debug then
                        print(v.ClassName .. " | " .. v.Name, "| has been destroyed")
                    end
                end
            end

            -- PARTS
        elseif v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("WedgePart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            if change_mat then
                if v.Material ~= mat and v.Material ~= Enum.Material.Neon then
                    v.Material = mat
                    if debug then
                        print(v.ClassName .. " | " .. v.Name, "| has been solidified")
                    end
                end
            end

            -- MESHPARTS
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
                if v.Material ~= mat then
                    v.Material = mat
                    if debug then
                        print(v.ClassName .. " | " .. v.Name, "| has been solidified")
                    end
                end
            end

            -- SPECIALMESH
        elseif v:IsA("SpecialMesh") and v.TextureId then
            if remove_tex then
                v.TextureId = ""

                if debug then
                    print(v.ClassName .. " | " .. v.Name, "| removed TextureId")
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
    elseif exclude_localplayer then
        if r:IsA("Highlight") and r.Name == "Players" then
            if r:FindFirstChild(locplr.Name) then
                return
            end
        end
    end
    optimize(r)
end

-- there goes the terrain stuff
local terraria = workspace:FindFirstChild("Terrain")
terraria.WaterReflectance = 0
terraria.WaterWaveSize = 0
terraria.WaterWaveSpeed = 0

local deltaTime = os.clock() - startTime
print(("Finished cleaning up everything, took %.2f seconds"):format(deltaTime))

-- im about to have stroke
plr.PlayerAdded:Connect(function(pplr)
    if exclude_players then
        return
    end
    task.wait(0.5)
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
            print(chr.ClassName, chr.Name, "chr added")
        end)
        if v.Character then
            optimize(v)
            print(v.Name, "chr applied")
        end
    end
    if exclude_localplayer then
        if v ~= locplr then
            fard()
        end
    else
        fard()
    end
end
