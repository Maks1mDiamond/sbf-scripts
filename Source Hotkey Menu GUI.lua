local plr = game.Players.LocalPlayer
task.wait(1)
local chr = plr.Character
plr.CharacterAdded:Connect(function(character)
	chr = character
end)

local strgui = game:GetService("StarterGui")
local UIS = game:GetService("UserInputService")
local reps = game:GetService("ReplicatedStorage")

local gui = Instance.new("ScreenGui")
gui.Name = "sorse 2 menu gui"
gui.Parent = game:GetService("CoreGui")
--gui.DisplayOrder = 200

-- default config if not using loadstring version
if keypad == nil then
    adminPerms = false
    sbfStyle = true

    bgColor = Color3.fromRGB(0,0,0)
    textColor = Color3.fromRGB(255,190,0)
    textFont = Enum.Font.SourceSansBold
    cornerRadius = 10

    menuAnimations = true
    inDelay = 0.3
    outDelay = 0.2

    openMenuKeybind = Enum.KeyCode.C
    keypad = false
end

local db = false -- dont touch

if menuAnimations then
    twsrv = game:GetService("TweenService")
    twinfoin = TweenInfo.new(inDelay, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
    twinfoout = TweenInfo.new(outDelay, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
    appearAnim = {}
    disappearAnim = {}
end

local kc = Enum.KeyCode

local k0,k1,k2,k3,k4,k5,k6,k7,k8,k9
if keypad ~= true then
    k0 = openMenuKeybind
    k1 = kc.One
    k2 = kc.Two
    k3 = kc.Three
    k4 = kc.Four
    k5 = kc.Five
    k6 = kc.Six
    k7 = kc.Seven
    k8 = kc.Eight
    k9 = kc.Nine
else
    --[[
        those keys doesnt register at all

        kc.KeypadPeriod
        kc.KeypadEnter
        kc.KeypadDivide
    ]]

    k0 = kc.KeypadZero
    k1 = kc.KeypadOne
    k2 = kc.KeypadTwo
    k3 = kc.KeypadThree
    k4 = kc.KeypadFour
    k5 = kc.KeypadFive
    k6 = kc.KeypadSix
    k7 = kc.KeypadSeven
    k8 = kc.KeypadEight
    k9 = kc.KeypadNine
end

local k0_text = k0.Name.." | Go back"
if keypad then
    k0_text = "0 | Go back"
end

local function genmenu(menu_type,t1,t2,t3,t4,t5,t6,t7,t8,t9)
    local frame = Instance.new("Frame")
    frame.Parent = gui
    frame.Name = menu_type
    frame.Visible = false

    frame.AnchorPoint = Vector2.new(0, 0.5)
    frame.Position = UDim2.new(0, 10, 0.5, 0)
    frame.Size = UDim2.new(0, 250, 0, 400)


    frame.BackgroundColor3 = bgColor
    frame.BorderSizePixel = 0
    --frame.ClipsDescendants = true

    if sbfStyle then
        local img = Instance.new("ImageLabel")
        img.Parent = frame
        img.AnchorPoint = Vector2.new(0.5,0.5)
        img.Position = UDim2.new(0.5,0,0.5,0)
        img.Size = UDim2.new(1.2,0,1.2,0)

        img.Image = "rbxassetid://7375503999"
        img.ScaleType = Enum.ScaleType.Slice
	    img.SliceCenter = Rect.new(57,57,193,193)
	    img.SliceScale = 0.9

        img.BackgroundTransparency = 1
        frame.BackgroundTransparency = 1
        if menuAnimations then
            img.ImageTransparency = 1
            table.insert(appearAnim, twsrv:Create(img, twinfoout, { ImageTransparency = 0.5 }))
            table.insert(disappearAnim, twsrv:Create(img, twinfoin, { ImageTransparency = 1 }))
        else
            img.ImageTransparency = 0.5
        end
    else
        if cornerRadius >= 1 then
            local uicorner = Instance.new("UICorner")
            uicorner.Parent = frame
            uicorner.CornerRadius = UDim.new(0,cornerRadius)
        end

        frame.BackgroundTransparency = 0.5
        if menuAnimations then
            frame.BackgroundTransparency = 1
            table.insert(appearAnim, twsrv:Create(frame, twinfoout, { BackgroundTransparency = 0.5 }))
            table.insert(disappearAnim, twsrv:Create(frame, twinfoin, { BackgroundTransparency = 1 }))
        else
            frame.BackgroundTransparency = 0.5
        end
    end

    warn(menu_type, "has been created")

    local ySize = 40
    local function gentext(t, yPos)
        local text = Instance.new("TextLabel")
        text.Parent = frame

        text.Position = UDim2.new(0,15,0,yPos)
        text.Size = UDim2.new(1,-15,0,ySize)
        if t ~= "t0" then
            text.Text = t
        else
            text.Text = k0_text
        end

        if sbfStyle then
            text.Font = Enum.Font.Fantasy
            text.TextSize = 20
            textColor = Color3.new(1, 1, 1)
        else
            text.Font = textFont
            text.TextSize = 20
        end

        text.TextColor3 = textColor
        text.TextWrapped = true
        text.TextXAlignment = Enum.TextXAlignment.Left

        text.BackgroundTransparency = 1
        text.BorderSizePixel = 0

        if menuAnimations then
            text.TextTransparency = 1
            table.insert(appearAnim, twsrv:Create(text, twinfoout, { TextTransparency = 0 }))
            table.insert(disappearAnim, twsrv:Create(text, twinfoin, { TextTransparency = 1 }))
        else
            text.TextTransparency = 0
        end
    end

    if t1 then gentext("1 | "..t1, 0) end
    if t2 and t2 ~= "" then gentext("2 | "..t2, ySize) end
    if t3 and t3 ~= "" then gentext("3 | "..t3, ySize*2) end
    if t4 and t4 ~= "" then gentext("4 | "..t4, ySize*3) end
    if t5 and t5 ~= "" then gentext("5 | "..t5, ySize*4) end
    if t6 and t6 ~= "" then gentext("6 | "..t6, ySize*5) end
    if t7 and t7 ~= "" then gentext("7 | "..t7, ySize*6) end
    if t8 and t8 ~= "" then gentext("8 | "..t8, ySize*7) end
    if t9 then gentext("9 | "..t9, ySize*8) end
    gentext("t0", ySize*9)
end

if adminPerms then
    genmenu("main", "Regular Tools", "Useful Tools", "Admin Tools")
else
    genmenu("main", "Regular Tools", "Useful Tools")
end
genmenu("rtools", "Foods", "Weapons", "Fnuuy", "Vehicles", "Event", "FumoFest")


-- foods
genmenu(
    "toolsR1",
    "pizzer",
    "FriedRice",
    "cofe",
    "borgir",
    "yuyuletics",
    "IceCream",
    "chiru",
    "pep",
    "- Page 1 >"
)
genmenu(
    "toolsR1P2",
    "choccy milk",
    "soder",
    "Watermelon",
    "flancake",
    "",
    "",
    "",
    "",
    "< Page 2 -"
)

-- weapons
genmenu(
    "toolsR2",
    "DESCENSIONIST",
    "PoolNoodle",
    "GravityGun",
    "PortalGun",
    "Yuuka's Parasol",
    "Kogasa's Parasol",
    "Remilia's Parasol",
    "the pan",
    "- Page 1 >"
)
genmenu(
    "toolsR2P2",
    "Prototype",
    "Yamato",
    "RocketLauncher",
    "Banana",
    "ClassicTrowel",
    "lcv2",
    "Lightning Cannon",
    "BoomboxGun",
    "< Page 2 -"
)

-- fnuuy
genmenu(
    "toolsR3",
    "FIREWORKS LAUNCHER!!!!!!",
    "Microwave",
    "dwaggy plushie",
    "life jacket",
    "YuyuOnionRing",
    "Petition",
    "ClownpieceRocket",
    "Fishing Rod",
    "Bucket"
)

-- vehicles
genmenu(
    "toolsR4",
    "Roomba",
    "Boat",
    "chair",
    "Bike",
    "Gokart",
    "Motorbike",
    "Wheeliebike",
    "Wheelchair"
)

-- event
genmenu(
    "toolsR5",
    "Red PoolNoodle",
    "Blue PoolNoodle"
)

-- fumofest
genmenu(
    "toolsR6",
    "Lemonade",
    "radiated fries",
    "eggzrin doll",
    "dango",
    "cucumber soda",
    "suika watermelon",
    "mooncarrot",
    "cucumber",
    "whopeecushion"
)



genmenu("utools", "radar", "cloudplant", "blal", "Pagoda")
genmenu("atools", "Infinite Gravity Gun", "Ascensionist", "Immortality Lord", "Normalifyscensionist", "Megaphone", "Lost")

-- tools to add into the list

--[[
mug

parasol
- Yuuka Umbrella
- cogloss
- Remi Umbrella
]]

local function tweenAppear()
    for _, tween in ipairs(appearAnim) do
        tween:Play()
    end
end
local function tweenDisappear()
    for _, tween in ipairs(disappearAnim) do
        tween:Play()
    end
end
local function tweenAnim(v)
    if menuAnimations then
        if v then
            tweenAppear()
            task.wait(outDelay)
        else
            tweenDisappear()
            task.wait(inDelay)
        end
    end
end
local appear = true
local disappear = false

local cBackpack = false
local function toggleMainMenu(v)
    if v then
        if db then return end
        if keypad ~= true then
            if strgui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) then
                strgui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
                cBackpack = true
            else
                cBackpack = false
            end
        end
        db = true
        gui.main.Visible = true
        tweenAnim(appear)
        db = false
    else
        if db then return end
        if cBackpack then
            strgui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
        end
        db = true
        tweenAnim(disappear)
        db = false
        gui.main.Visible = false
    end
end



local function returnFromToolsIntoMainMenu()
    if db then return end
    db = true
    tweenAnim(disappear)
    gui.rtools.Visible = false
    gui.utools.Visible = false
    gui.atools.Visible = false
    gui.main.Visible = true
    tweenAnim(appear)
    db = false
end



local function fDisappear()
    if db then return end
    db = true
    tweenAnim(disappear)
end
local function fAppear()
    tweenAnim(appear)
    db = false
end

local function toolsMenu()
    fDisappear()
    gui.main.Visible = false

    gui.toolsR1.Visible = false
    gui.toolsR1P2.Visible = false
    gui.toolsR2.Visible = false
    gui.toolsR2P2.Visible = false
    gui.toolsR3.Visible = false
    gui.toolsR4.Visible = false
    gui.toolsR5.Visible = false
    gui.toolsR6.Visible = false

    gui.rtools.Visible = true
    fAppear()
end

local function toolsR1Menu()
    fDisappear()
    gui.rtools.Visible = false
    gui.toolsR1.Visible = true
    gui.toolsR1P2.Visible = false
    fAppear()
end
local function toolsR1P2Menu()
    fDisappear()
    gui.rtools.Visible = false
    gui.toolsR1.Visible = false
    gui.toolsR1P2.Visible = true
    fAppear()
end
local function toolsR2Menu()
    fDisappear()
    gui.rtools.Visible = false
    gui.toolsR2.Visible = true
    gui.toolsR2P2.Visible = false
    fAppear()
end
local function toolsR2P2Menu()
    fDisappear()
    gui.rtools.Visible = false
    gui.toolsR2.Visible = false
    gui.toolsR2P2.Visible = true
    fAppear()
end
local function toolsR3Menu()
    fDisappear()
    gui.rtools.Visible = false
    gui.toolsR3.Visible = true
    fAppear()
end
local function toolsR4Menu()
    fDisappear()
    gui.rtools.Visible = false
    gui.toolsR4.Visible = true
    fAppear()
end
local function toolsR5Menu()
    fDisappear()
    gui.rtools.Visible = false
    gui.toolsR5.Visible = true
    fAppear()
end
local function toolsR6Menu()
    fDisappear()
    gui.rtools.Visible = false
    gui.toolsR6.Visible = true
    fAppear()
end



local function utoolsMenu()
    fDisappear()
    gui.main.Visible = false
    gui.utools.Visible = true
    fAppear()
end
local function atoolsMenu()
    if adminPerms ~= true then return end
    fDisappear()
    gui.main.Visible = false
    gui.atools.Visible = true
    fAppear()
end

local function menuSwitch(key, isChatting)
    if isChatting then return end
    if key.KeyCode == k0 then
        local function checkvisibility()
            for i,v in next, gui:GetDescendants() do
                if v:IsA("Frame") then
                    if v.Visible == true then
                        return true
                    end
                end
            end
        end
        if checkvisibility() ~= true then
            toggleMainMenu(appear)
        elseif gui.main.Visible then
            toggleMainMenu(disappear)
        elseif
        gui.rtools.Visible or
        gui.utools.Visible or
        gui.atools.Visible then
            returnFromToolsIntoMainMenu()
        elseif
        gui.toolsR1.Visible or gui.toolsR1P2.Visible or
        gui.toolsR2.Visible or gui.toolsR2P2.Visible or
        gui.toolsR3.Visible or
        gui.toolsR4.Visible or
        gui.toolsR5.Visible or
        gui.toolsR6.Visible then
            toolsMenu()
        end
    elseif key.KeyCode == k1 then
        if gui.main.Visible then
            toolsMenu()
        elseif gui.rtools.Visible then
            toolsR1Menu()
        end
    elseif key.KeyCode == k2 then
        if gui.main.Visible then
            utoolsMenu()
        elseif gui.rtools.Visible then
            toolsR2Menu()
        end
    elseif key.KeyCode == k3 then
        if gui.main.Visible then
            atoolsMenu()
        elseif gui.rtools.Visible then
            toolsR3Menu()
        end
    elseif key.KeyCode == k4 then
        if gui.rtools.Visible then
            toolsR4Menu()
        end
    elseif key.KeyCode == k5 then
        if gui.rtools.Visible then
            toolsR5Menu()
        end
    elseif key.KeyCode == k6 then
        if gui.rtools.Visible then
            toolsR6Menu()
        end
    elseif key.KeyCode == k7 then

    elseif key.KeyCode == k8 then

    elseif key.KeyCode == k9 then
        if gui.toolsR1.Visible then
            toolsR1P2Menu()
        elseif gui.toolsR1P2.Visible then
            toolsR1Menu()
        elseif gui.toolsR2.Visible then
            toolsR2P2Menu()
        elseif gui.toolsR2P2.Visible then
            toolsR2Menu()
        end
    end
end


-- HOTKEYS
local itemGiversFolder = game.Workspace.ItemGivers
local function itemGiver(item, var)
    if adminPerms then
        reps.Req:InvokeServer("RunCommand", "give "..plr.Name.." "..item)
    else
        if item == "PoolNoodle" then
            for i, v in next, itemGiversFolder:GetChildren() do
                if v:IsA("Model") and v.Name == item then
                    if v:GetAttribute("Color") == "red" and var == "red" then
                        local cd = v:FindFirstChild("Giver").ClickDetector
                        fireclickdetector(cd)
                    elseif v:GetAttribute("Color") == "blue" and var == "blue" then
                        local cd = v:FindFirstChild("Giver").ClickDetector
                        fireclickdetector(cd)
                    elseif v:GetAttribute("Color") == nil and var == nil then
                        local cd = v:FindFirstChild("Giver").ClickDetector
                        fireclickdetector(cd)
                    end
                end
            end
        elseif item == "parasol" then
            for i, v in next, itemGiversFolder:GetChildren() do
                if v:IsA("Model") and v.Name == item then
                    if v:GetAttribute("ParasolType") == "Yuuka" and var == "yuuka" then
                        local cd = v:FindFirstChild("Giver").ClickDetector
                        fireclickdetector(cd)
                    elseif v:GetAttribute("ParasolType") == "Kogasa" and var == "koggers" then
                        local cd = v:FindFirstChild("Giver").ClickDetector
                        fireclickdetector(cd)
                    elseif v:GetAttribute("ParasolType") == "Remilia" and var == "remi" then
                        local cd = v:FindFirstChild("Giver").ClickDetector
                        fireclickdetector(cd)
                    end
                end
            end
        else
            local cd = itemGiversFolder[item]:FindFirstChild("Giver").ClickDetector
            fireclickdetector(cd)
        end
    end
end
local function hotkeyGiver(v)
    -- Foods
    if gui.toolsR1.Visible then
        if v == k1 then
            itemGiver("pizzer")
        elseif v == k2 then
            itemGiver("FriedRice")
        elseif v == k3 then
            local cofe = game.Workspace.Map["SBF's Fumofas Map (RANDOMPOTATO)"]["LeFumo Cafe"].Furniture["Coffee Maker"]:FindFirstChild("BaseClickBox").ClickDetector
            if cofe then
                itemGiver("mug")
                task.wait(1)
		        plr.Backpack.mug.Parent = chr
		        fireclickdetector(cofe)
            end
        elseif v == k4 then
            itemGiver("borgir")
        elseif v == k5 then
            itemGiver("yuyuletics")
        elseif v == k6 then
            itemGiver("IceCream")
        elseif v == k7 then
            itemGiver("chiru")
        elseif v == k8 then
            itemGiver("pep")
        elseif v == k9 then
            -- goto page 2
        end
    elseif gui.toolsR1P2.Visible then
        if v == k1 then
            itemGiver("choccy milk")
        elseif v == k2 then
            itemGiver("soder")
        elseif v == k3 then
            itemGiver("Watermelon")
        elseif v == k4 then
            itemGiver("flancake")
        elseif v == k5 then

        elseif v == k6 then

        elseif v == k7 then

        elseif v == k8 then

        elseif v == k9 then
            -- goto page 1
        end


        -- Weapons
    elseif gui.toolsR2.Visible then
        if v == k1 then
            itemGiver("DESCENSIONIST")
        elseif v == k2 then
            itemGiver("PoolNoodle")
        elseif v == k3 then
            itemGiver("GravityGun")
        elseif v == k4 then
            itemGiver("PortalGun")
        elseif v == k5 then
            itemGiver("parasol", "yuuka")
        elseif v == k6 then
            itemGiver("parasol", "koggers")
        elseif v == k7 then
            itemGiver("parasol", "remi")
        elseif v == k8 then
            itemGiver("the pan")
        elseif v == k9 then
            -- goto page 2
        end
    elseif gui.toolsR2P2.Visible then
        if v == k1 then
            itemGiver("Prototype")
        elseif v == k2 then
            itemGiver("Yamato")
        elseif v == k3 then
            itemGiver("RocketLauncher")
        elseif v == k4 then
            itemGiver("Banana")
        elseif v == k5 then
            itemGiver("ClassicTrowel")
        elseif v == k6 then
            itemGiver("lcv2")
        elseif v == k7 then
            itemGiver("Lightning Cannon")
        elseif v == k8 then
            itemGiver("BoomboxGun")
        elseif v == k9 then
            -- goto page 1
        end


        -- fnuuy
    elseif gui.toolsR3.Visible then
        if v == k1 then
            itemGiver("FIREWORKS LAUNCHER!!!!!!")
        elseif v == k2 then
            itemGiver("Microwave")
        elseif v == k3 then
            itemGiver("dwaggy plushie")
        elseif v == k4 then
            itemGiver("life jacket")
        elseif v == k5 then
            itemGiver("YuyuOnionRing")
        elseif v == k6 then
            itemGiver("Petition")
        elseif v == k7 then
            itemGiver("ClownpieceRocket")
        elseif v == k8 then
            itemGiver("Fishing Rod")
        elseif v == k9 then
            itemGiver("Bucket")
        end


        -- Vehicles
    elseif gui.toolsR4.Visible then
        if v == k1 then
            itemGiver("Roomba")
        elseif v == k2 then
            itemGiver("Boat")
        elseif v == k3 then
            itemGiver("chair")
        elseif v == k4 then
            itemGiver("Bike")
        elseif v == k5 then
            itemGiver("Gokart")
        elseif v == k6 then
            itemGiver("Motorbike")
        elseif v == k7 then
            itemGiver("Wheeliebike")
        elseif v == k8 then
            itemGiver("Wheelchair")
        elseif v == k9 then

        end

        -- Event
    elseif gui.toolsR5.Visible then
        if v == k1 then
            itemGiver("PoolNoodle", "red")
        elseif v == k2 then
            itemGiver("PoolNoodle", "blue")
        elseif v == k3 then

        elseif v == k4 then

        elseif v == k5 then

        elseif v == k6 then

        elseif v == k7 then

        elseif v == k8 then

        elseif v == k9 then

        end

        -- Fumofest
    elseif gui.toolsR6.Visible then
        if v == k1 then
            itemGiver("Lemonade")
        elseif v == k2 then
            itemGiver("radiated fries")
        elseif v == k3 then
            itemGiver("eggzrin doll")
        elseif v == k4 then
            itemGiver("dango")
        elseif v == k5 then
            itemGiver("cucumber soda")
        elseif v == k6 then
            itemGiver("suika watermelon")
        elseif v == k7 then
            itemGiver("mooncarrot")
        elseif v == k8 then
            itemGiver("cucumber")
        elseif v == k9 then
            itemGiver("whopeecushion")
        end


        -- Useful Tools
    elseif gui.utools.Visible then
        if v == k1 then
            itemGiver("radar")
        elseif v == k2 then
            itemGiver("cloudplant")
        elseif v == k3 then
            itemGiver("blal")
        elseif v == k4 then
            itemGiver("Pagoda")
        elseif v == k5 then

        elseif v == k6 then

        elseif v == k7 then

        elseif v == k8 then

        elseif v == k9 then

        end


        -- Admin Tools
    elseif gui.atools.Visible then
        if v == k1 then
            itemGiver("InfGravityGun")
        elseif v == k2 then
            itemGiver("ASCENSIONIST")
        elseif v == k3 then
            itemGiver("Immortality Lord")
        elseif v == k4 then
            itemGiver("NORMALIFYSCENSIONIST")
        elseif v == k5 then
            itemGiver("Megaphone")
        elseif v == k6 then
            itemGiver("Lost")
        elseif v == k7 then

        elseif v == k8 then

        elseif v == k9 then

        end
    end
end
local function menuGiver(key, isChatting)
    if isChatting then return end
    if key.KeyCode == k1 then
        hotkeyGiver(k1)
    elseif key.KeyCode == k2 then
        hotkeyGiver(k2)
    elseif key.KeyCode == k3 then
        hotkeyGiver(k3)
    elseif key.KeyCode == k4 then
        hotkeyGiver(k4)
    elseif key.KeyCode == k5 then
        hotkeyGiver(k5)
    elseif key.KeyCode == k6 then
        hotkeyGiver(k6)
    elseif key.KeyCode == k7 then
        hotkeyGiver(k7)
    elseif key.KeyCode == k8 then
        hotkeyGiver(k8)
    elseif key.KeyCode == k9 then
        hotkeyGiver(k9)
    end
end

UIS.InputBegan:Connect(function(key, isChatting)
    if gui ~= nil then
        menuGiver(key, isChatting)
        menuSwitch(key, isChatting)
    end
end)

-- self destruction
UIS.InputBegan:Connect(function(key, isChatting)
    if gui ~= nil then
        if isChatting then return end
        if key.KeyCode == Enum.KeyCode.PageDown then
            k0,k1,k2,k3,k4,k5,k6,k7,k8,k9 = nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
            gui:Destroy()
        end
    end
end)