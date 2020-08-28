local Remotes = game.ReplicatedStorage.Remotes
local Info = workspace.TimedChest.Info

function StartTimer(Duration, Amount)
    Info.Reward.Text = "Pending: $" .. Amount
    for Second = Duration, 0, -1 do
        Info.Timer.Text = Second .. " seconds remaining..."
        wait(1)
    end
    Info.Timer.Text = "Click to Receive Money"
end

Remotes.StartTimer.OnClientEvent:Connect(StartTimer)