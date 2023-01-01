local plr = game.Players
--local locplr = plr.LocalPlayer
local scriptName = "[Maks's FPS Optimizer]"

if config.changeMaterial == nil then
    config = {
        excludePlayers = false,
        --local exclude_localplayer = true
        faceless = false,

        changeMaterial = true,
        removeTexture = true,
        removeMesh = false,
        removeParticles = false,
        material = Enum.Material.SmoothPlastic,
        ignoreForceFieldMaterial = true,

        optimizeLighting = false,

        debug = false
    }
end

local blacklistMeshIDs = {
    "rbxassetid://9398214567", "rbxassetid://9412211620", -- head
    "rbxassetid://9398214611", "rbxassetid://9412211617", -- larm
    "rbxassetid://9398214568", "rbxassetid://9412211541", -- lleg
    "rbxassetid://9398214611", "rbxassetid://9412211617", -- rarm
    "rbxassetid://9398214575", "rbxassetid://9412211549", -- rleg
    "rbxassetid://9398214570", "rbxassetid://9412211561", -- torso
}
local blacklistTextures = {
    "http://www.roblox.com/asset/?id=6239942134",
    "rbxassetid://6239942134",
    "6239942134"
}

local function printDebug(text)
    if config.debug then
        print(text)
    end
end

local startTime = os.clock()
local function optimize(a)
    local function purge(part)
        part:Destroy()
        printDebug(scriptName.." "..part.ClassName.." | "..part.Name.." | has been destroyed")
    end

    for _, v in next, a:GetDescendants() do
        local function applyMaterial(part)
            if config.ignoreForceFieldMaterial then
                if part.Material ~= Enum.Material.ForceField and part.Material ~= config.material and part.Material ~= Enum.Material.Neon then
                    part.Material = config.material
                    printDebug(scriptName.." "..part.ClassName.." | "..part.Name.." | has been solidified")
                end
            elseif part.Material ~= config.material and part.Material ~= Enum.Material.Neon then
                part.Material = config.material
                printDebug(scriptName.." "..part.ClassName.." | "..part.Name.." | has been solidified")
            end
        end
        local function purgeMesh(part)
            for i, _ in pairs(blacklistMeshIDs) do
                if not table.find(blacklistMeshIDs, part.MeshId) and part.MeshId ~= "" then
                    part.MeshId = "rbxassetid://"
                    printDebug(scriptName.." "..part.ClassName.." | "..part.Name.." | removed MeshId")
                end
            end
        end
        local function purgeTexture(part, prop)
            if part[prop] ~= "" then
                part[prop] = ""
                printDebug(scriptName.." "..part.ClassName.." | "..part.Name.." ".."| removed "..prop)
            end
        end

        if v:IsA("Decal") or v:IsA("Texture") then
            if config.removeTexture then
                if v.Texture ~= "http://www.roblox.com/asset/?id=6239942134" and v.Texture ~= "rbxassetid://6239942134" and v.Texture ~= "6239942134" then
                    if config.faceless ~= true and v.Parent then
                        if v.Parent.Name ~= "Shine" and v.Parent.Name ~= "EyeShinePart" and v.Parent.Name ~= "Head" then
                            purge(v)
                        end
                    else
                        purge(v)
                    end
                end
            end
        elseif v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("WedgePart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            if config.changeMaterial then
                applyMaterial(v)
            end
        elseif v:IsA("MeshPart") then
            if config.removeTexture then
                purgeTexture(v, "TextureID")
            end
            if config.changeMaterial then
                applyMaterial(v)
            end
            if config.removeMesh then
                purgeMesh(v)
            end
        elseif v:IsA("SpecialMesh") then
            if config.removeTexture then
                purgeTexture(v, "TextureId")
            end
            if config.removeMesh then
                purgeMesh(v)
            end
        elseif v:IsA("ParticleEmitter") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
            if config.removeParticles then
                purge(v)
            end
        end
    end
    if config.optimizeLighting then
        for i,v in next, game.Lighting:GetChildren() do
            if v:IsA("Atmosphere") or v:IsA("SunRaysEffect") or v:IsA("DepthOfFieldEffect") then
                purge(v)
            end
        end
    end
end

for i, v in next, workspace:GetChildren() do
    if config.excludePlayers then
        if v:IsA("Highlight") and v.Name == "Players" then
            return
        end
    end
    optimize(v)
end

local terraria = workspace:FindFirstChild("Terrain")
terraria.WaterReflectance = 0
terraria.WaterWaveSize = 0
terraria.WaterWaveSpeed = 0

local deltaTime = os.clock() - startTime
print(scriptName, ("Finished cleaning up everything, took %.2f seconds"):format(deltaTime))



local function chrAdded(character)
    task.wait(4)
    optimize(character)
    printDebug(scriptName.." Newly created character has been optimized: "..character.Name)
end
local function plrAdded(player)
    if config.excludePlayers then return end
    player.CharacterAdded:Connect(chrAdded)
    if player.Character then
        chrAdded(player.Character)
    end
end
for _, player in pairs(plr:GetPlayers()) do
    plrAdded(player)
end
plr.PlayerAdded:Connect(plrAdded)