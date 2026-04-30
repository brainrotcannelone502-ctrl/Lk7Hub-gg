local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "LK7_V22_Fixed"
sg.ResetOnSpawn = false

local VALOR_ROBUX = 100000
local TECLA_TOGGLE = Enum.KeyCode.P

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 250, 0, 620)
Main.Position = UDim2.new(0.5, -125, 0.5, -310)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

local Title = Instance.new("TextLabel", Main)
Title.Text = "LK7 HUB V2"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

local TargetBox = Instance.new("TextBox", Main)
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

local function AtivarSuperVisual()
    VALOR_ROBUX = 100000
    task.spawn(function()
        while true do
            for _, v in pairs(player.PlayerGui:GetDescendants()) do
                if v:IsA("TextLabel") or v:IsA("TextButton") then
                    if v.Text:find("R%$") or v.Name:lower():find("robux") or v.Text:lower():find("robux") then
                        v.Text = "R$ 100.000"
                    end
                end
                
                if v:IsA("TextButton") and not v:GetAttribute("Hooked") then
                    local t = v.Text:lower()
                    if t:find("buy") or t:find("comprar") or t:find("purchase") or t:find("obter") then
                        v:SetAttribute("Hooked", true)
                        v.MouseButton1Click:Connect(function()
                            local originalText = v.Text
                            v.Text = "COMPRADO! (V)"
                            v.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
                            task.wait(1.5)
                            v.Text = originalText
                            v.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                            game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                                Text = "[LK7] Item Adicionado ao Inventário (VISUAL)",
                                Color = Color3.new(0, 1, 0)
                            })
                        end)
                    end
                end
            end
            task.wait(1)
        end
    end)
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

local b1 = Instance.new("TextButton", Main)
b1.Text = "Obrigado"; b1.Size = UDim2.new(0,110,0,30); b1.Position = UDim2.new(0,10,0,85); b1.BackgroundColor3 = Color3.fromRGB(60,30,150); b1.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", b1); b1.MouseButton1Click:Connect(function() SendVisualChat("Obrigado") end)

local b2 = Instance.new("TextButton", Main)
b2.Text = "Tmj"; b2.Size = UDim2.new(0,110,0,30); b2.Position = UDim2.new(0,130,0,85); b2.BackgroundColor3 = Color3.fromRGB(60,30,150); b2.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", b2); b2.MouseButton1Click:Connect(function() SendVisualChat("Tmj") end)

CmdBtn("ATIVAR SUPER VISUAL (LOJA)", UDim2.new(0, 10, 0, 130), AtivarSuperVisual)

CmdBtn("Ragdoll (Safe)", UDim2.new(0, 10, 0, 175), function()
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum:ChangeState(Enum.HumanoidStateType.Physics) task.wait(2) hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
end)

CmdBtn("Rocket (Anti-Death)", UDim2.new(0, 10, 0, 220), function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Velocity = Vector3.new(0, 60, 0); task.wait(1.5); bv:Destroy()
    end
end)

CmdBtn("Jail Target (5 Seg)", UDim2.new(0, 10, 0, 265), function()
    local t = GetTarget()[1]
    if t and t.Character then
        local hrp = t.Character:FindFirstChild("HumanoidRootPart")
        local cf = hrp.CFrame
        local s = tick()
        while tick() - s < 5 do hrp.CFrame = cf task.wait(0.1) end
    end
end)

CmdBtn("Simular Compra Admin", UDim2.new(0, 10, 0, 310), function()
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {Text = "Admin Comprado com Sucesso!", Color = Color3.new(0,1,0)})
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
