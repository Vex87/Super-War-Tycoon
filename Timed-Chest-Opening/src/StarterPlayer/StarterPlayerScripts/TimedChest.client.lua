local NOTIFIED_TRANSPARENCY = 0.4

local Remotes = game.ReplicatedStorage.Remotes
local Chest = workspace.TimedChest

function StartTimer(Duration, Amount)
    Chest.Notifier.Transparency = 1
    for Second = Duration, 0, -1 do
        Chest.Pad.Info.Label.Text = Second .. " seconds remaining..."
        wait(1)
    end
    Chest.Pad.Info.Label.Text = "Touched to collect $" .. Amount
    Chest.Notifier.Transparency = 0.6
end

Remotes.StartTimer.OnClientEvent:Connect(StartTimer)