# sbf-scripts
some random and useful scripts for scuffed become fumo

## Source Hotkey Menu GUI (Loadstring)
```lua
getgenv().adminPerms = false
if game.PlaceId == 9050217454 then getgenv().adminPerms = true end

-- [[ disable sbfStyle to customize your menugui ]]
getgenv().sbfStyle = true

getgenv().bgColor = Color3.fromRGB(0,0,0)
getgenv().textColor = Color3.fromRGB(255,190,0)
getgenv().textFont = Enum.Font.SourceSansBold
getgenv().cornerRadius = 10

getgenv().menuAnimations = true
getgenv().inDelay = 0.3
getgenv().outDelay = 0.2

-- [[ this only works if you have keypad disabled ]]
getgenv().openMenuKeybind = Enum.KeyCode.C
getgenv().keypad = false

loadstring(game:HttpGet("https://raw.githubusercontent.com/Maks1mDiamond/sbf-scripts/main/Source%20Hotkey%20Menu%20GUI.lua"))()
```

## FPS Optimizer (Loadstring)
```lua
getgenv().exclude_players = true
getgenv().faceless = false

getgenv().change_mat = true
getgenv().remove_tex = true
getgenv().remove_mesh = true
getgenv().remove_particles = true
getgenv().mat = Enum.Material.SmoothPlastic
getgenv().ignoreffmat = true

getgenv().optimizeLighting = true

getgenv().debug = false

loadstring(game:HttpGet("https://raw.githubusercontent.com/Maks1mDiamond/sbf-scripts/main/FPS%20Optimizer.lua"))()
```
