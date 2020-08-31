-- // Variables \\ --

local Remotes = game.ReplicatedStorage.Remotes.TimedChest
local Chest = workspace.Map.TimedChest
local Effects = Chest.Effects
local Bottom = Chest.Bottom

-- // Functions \\ --

function Open()
    Bottom.Open:Play()

    Effects.Glow.Enabled = true
    Effects.Sparkles.Enabled = true
    Effects.PointLight.Enabled = true
    Effects.SpotLight.Enabled = true

    Bottom.Left.AngularSpeed = 1.5
    Bottom.Right.AngularSpeed = 1.5  
    Bottom.Left.TargetAngle = 60
    Bottom.Right.TargetAngle = 60   
end

function Close()
    Bottom.Close:Play()

    Effects.Glow.Enabled = false
    Effects.Sparkles.Enabled = false
    Effects.PointLight.Enabled = false
    Effects.SpotLight.Enabled = false

    Bottom.Left.AngularSpeed = 2
    Bottom.Right.AngularSpeed = 2  
    Bottom.Left.TargetAngle = 180
    Bottom.Right.TargetAngle = 180
end

function StartTimer(Duration, Amount)
    Close()
    for Second = Duration, 0, -1 do
        if Second == 1 then
            Bottom.Info.Label.Text = Second .. " Second Remaining..."
        else
            Bottom.Info.Label.Text = Second .. " Seconds Remaining..."
        end
        wait(1)
    end
    Open()
    Bottom.Info.Label.Text = "COLLECT: $" .. Amount
end

-- // Events \\ --

Remotes.StartTimer.OnClientEvent:Connect(StartTimer)