local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "LK7_V22_Fixed"
sg.ResetOnSpawn = false

local VALOR_ROBUX = 11284
local TECLA_TOGGLE = Enum.KeyCode.P

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 250, 0, 620)
Main.Position = UDim2.new(0.5, -125, 0.5, -310)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

local Title = Instance.new("TextLabel", Main)
Title.Text = "LK7 HUB"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

local TargetBox = Instance.new("TextBox", Main)
TargetBox.Name = "TargetBox"
TargetBox.PlaceholderText = "Jogador (all / nome)"
TargetBox.Size = UDim2.new(0, 230, 0, 30)
TargetBox.Position = UDim2.new(0, 10, 0, 45)
TargetBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TargetBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TargetBox)

local function GetTarget()
    local text = TargetBox.Text:lower()
    local targets = {}
    if text == "" then return targets end
    for _, p in pairs(game.Players:GetPlayers()) do
        if text == "all" or p.Name:lower():find(text) or p.DisplayName:lower():find(text) then
            table.insert(targets, p)
        end
    end
    return targets
end

local function SendVisualChat(msg)
    local tList = GetTarget()
    for _, p in pairs(tList) do
        if p.Character and p.Character:FindFirstChild("Head") then
            game:GetService("Chat"):Chat(p.Character.Head, msg, "White")
        end
    end
end

local function AtivarLojaInfinita()
    VALOR_ROBUX = 100000
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "[LK7] Saldo Visual de 100K Ativado!",
        Color = Color3.fromRGB(255, 255, 0),
        Font = Enum.Font.GothamBold
    })

    local function HookButtons(obj)
        if obj:IsA("TextButton") or obj:IsA("ImageButton") then
            if obj.Name:lower():find("buy") or obj.Name:lower():find("purchase") or obj.Name:lower():find("comprar") then
                obj.MouseButton1Click:Connect(function()
                    local oldText = obj.Text
                    obj.Text = "COMPRADO!"
                    task.wait(1)
                    obj.Text = oldText
                    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                        Text = "Compra realizada com sucesso (Visual)!",
                        Color = Color3.new(0, 1, 0)
                    })
                end)
            end
        end
        for _, child in pairs(obj:GetChildren()) do HookButtons(child) end
    end
    HookButtons(player.PlayerGui)
end

local function CreateGiftInterface()
    local targets = GetTarget()
    local target = targets[1]
    if not target then return end

    local GiftOverlay = Instance.new("Frame", sg)
    GiftOverlay.Size = UDim2.new(1, 0, 1, 0)
    GiftOverlay.BackgroundColor3 = Color3.new(0, 0, 0)
    GiftOverlay.BackgroundTransparency = 0.5
    GiftOverlay.ZIndex = 20

    local GiftMain = Instance.new("Frame", GiftOverlay)
    GiftMain.Size = UDim2.new(0, 380, 0, 420)
    GiftMain.Position = UDim2.new(0.5, -190, 0.5, -210)
    GiftMain.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Instance.new("UICorner", GiftMain).CornerRadius = UDim.new(0, 20)

    local GTitle = Instance.new("TextLabel", GiftMain)
    GTitle.Text = "GIFT GAMEPASS"
    GTitle.Size = UDim2.new(1, 0, 0, 50)
    GTitle.TextColor3 = Color3.new(1, 1, 1)
    GTitle.Font = Enum.Font.GothamBold
    GTitle.BackgroundTransparency = 1

    local Avatar = Instance.new("ImageLabel", GiftMain)
    Avatar.Size = UDim2.new(0, 90, 0, 90)
    Avatar.Position = UDim2.new(0.5, -45, 0, 60)
    Avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..target.UserId.."&w=150&h=150"
    Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)

    local NameLabel = Instance.new("TextLabel", GiftMain)
    NameLabel.Text = target.DisplayName
    NameLabel.Size = UDim2.new(0, 320, 0, 35)
    NameLabel.Position = UDim2.new(0.5, -160, 0, 170)
    NameLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    NameLabel.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", NameLabel)

    local function Item(name, img, pos)
        local b = Instance.new("TextButton", GiftMain)
        b.Size = UDim2.new(0, 150, 0, 100)
        b.Position = pos
        b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        b.Text = ""
        Instance.new("UICorner", b)
        local i = Instance.new("ImageLabel", b)
        i.Size = UDim2.new(0, 40, 0, 40)
        i.Position = UDim2.new(0.5, -20, 0.2, 0)
        i.Image = img
        i.BackgroundTransparency = 1
        local t = Instance.new("TextLabel", b)
        t.Text = name
        t.Size = UDim2.new(1, 0, 0, 20)
        t.Position = UDim2.new(0, 0, 0.7, 0)
        t.TextColor3 = Color3.new(1, 1, 1)
        t.BackgroundTransparency = 1
    end

    Item("Flying Carpet", "rbxassetid://13540134443", UDim2.new(0, 25, 0, 220))
    Item("Admin Panel", "rbxassetid://11419714853", UDim2.new(0, 205, 0, 220))

    local GiftBtn = Instance.new("TextButton", GiftMain)
    GiftBtn.Text = "GIFT"
    GiftBtn.Size = UDim2.new(0, 330, 0, 50)
    GiftBtn.Position = UDim2.new(0.5, -165, 0, 340)
    GiftBtn.BackgroundColor3 = Color3.new(1, 1, 1)
    GiftBtn.TextColor3 = Color3.new(0, 0, 0)
    Instance.new("UICorner", GiftBtn)

    GiftBtn.MouseButton1Click:Connect(function()
        GiftBtn.Text = "SENDING..."
        task.wait(1)
        GiftOverlay:Destroy()
        SendVisualChat("Olhe seu inventário, te enviei o Gamepass!")
    end)
end

local function PhraseBtn(text, pos)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0, 110, 0, 30)
    btn.Position = pos
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(60, 30, 150)
    btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() SendVisualChat(text) end)
end

local function CmdBtn(name, pos, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0, 230, 0, 35)
    btn.Position = pos
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

PhraseBtn("Obrigado", UDim2.new(0, 10, 0, 85))
PhraseBtn("Vlw MN", UDim2.new(0, 130, 0, 85))
PhraseBtn("Tmj", UDim2.new(0, 10, 0, 125))
PhraseBtn("Vouch", UDim2.new(0, 130, 0, 125))

CmdBtn("Ragdoll (Safe)", UDim2.new(0, 10, 0, 180), function()
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum:ChangeState(Enum.HumanoidStateType.Physics) task.wait(2) hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
end)

CmdBtn("Rocket (Anti-Death)", UDim2.new(0, 10, 0, 225), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Velocity = Vector3.new(0, 60, 0)
        local f = Instance.new("Fire", hrp)
        task.wait(1.5)
        bv:Destroy() f:Destroy()
    end
end)

CmdBtn("Jail Target (5 Seg)", UDim2.new(0, 10, 0, 270), function()
    local t = GetTarget()[1]
    if t and t.Character then
        local hrp = t.Character:FindFirstChild("HumanoidRootPart")
        local cf = hrp.CFrame
        local s = tick()
        while tick() - s < 5 do hrp.CFrame = cf task.wait(0.1) end
    end
end)

CmdBtn("Balloon (Fixed Float)", UDim2.new(0, 10, 0, 315), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(0, 25000, 0)
        bv.Velocity = Vector3.new(0, 15, 0)
        task.wait(5)
        bv:Destroy()
    end
end)

CmdBtn("Simular Gift Gamepass", UDim2.new(0, 10, 0, 360), CreateGiftInterface)
CmdBtn("LOJA INFINITA (100K)", UDim2.new(0, 10, 0, 405), AtivarLojaInfinita)

CmdBtn("Simular Compra Admin", UDim2.new(0, 10, 0, 450), function()
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {Text = "Compra realizada com sucesso!", Color = Color3.new(0,1,0)})
end)

local RobuxLabel = Instance.new("TextLabel", Main)
RobuxLabel.Position = UDim2.new(0, 10, 0, 560)
RobuxLabel.Size = UDim2.new(1, -20, 0, 30)
RobuxLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
RobuxLabel.BackgroundTransparency = 1
RobuxLabel.Font = Enum.Font.GothamBold

spawn(function()
    while task.wait(0.1) do
        RobuxLabel.Text = "Robux: " .. string.format('%,d', VALOR_ROBUX):gsub(",", ".")
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == TECLA_TOGGLE then Main.Visible = not Main.Visible end
end)
