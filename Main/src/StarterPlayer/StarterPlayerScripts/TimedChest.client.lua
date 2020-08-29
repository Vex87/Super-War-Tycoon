-- // Settings \\ --

local NOTIFIED_TRANSPARENCY = 0.4

-- // Variables \\ --

local Remotes = game.ReplicatedStorage.Remotes.TimedChest
local Chest = workspace.Map.TimedChest

-- // Functions \\ --

function StartTimer(Duration, Amount)
    Chest.Notifier.Transparency = 1
    for Second = Duration, 0, -1 do
        Chest.Pad.Info.Label.Text = Second .. " seconds remaining..."
        wait(1)
    end
    Chest.Pad.Info.Label.Text = "Touched to collect $" .. Amount
    Chest.Notifier.Transparency = 0.6
end

-- // Events \\ --

Remotes.StartTimer.OnClientEvent:Connect(StartTimer)