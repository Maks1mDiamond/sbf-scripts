# sbf-scripts
some random and useful scripts for scuffed become fumo

## Source Hotkey Menu GUI (Loadstring)
```lua
getgenv().config = {
    adminPerms = false,
    -- [[ disable sbfStyle to customize your menugui ]]
    sbfStyle = true,

    bgColor = Color3.fromRGB(0,0,0),
    textColor = Color3.fromRGB(255,190,0),
    textFont = Enum.Font.SourceSansBold,
    cornerRadius = 10,

    menuAnimations = false,
    inDelay = 0.3,
    outDelay = 0.2,

    -- [[ this only works if you have keypad disabled ]]
    openMenuKeybind = Enum.KeyCode.C,
    keypad = false
}
if game.PlaceId == 9050217454 then config.adminPerms = true end

loadstring(game:HttpGet("https://raw.githubusercontent.com/Maks1mDiamond/sbf-scripts/main/Source%20Hotkey%20Menu%20GUI.lua"))()
```

## FPS Optimizer (Loadstring)
```lua
getgenv().config = {
    excludePlayers = false,
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
loadstring(game:HttpGet("https://raw.githubusercontent.com/Maks1mDiamond/sbf-scripts/main/FPS%20Optimizer.lua"))()
```
