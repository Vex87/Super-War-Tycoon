local MAX_TIME = 10
local REWARD_MULTIPLIER = 0.25

local Core = require(game.ReplicatedStorage.Core)
local Remotes = game.ReplicatedStorage.Remotes
local TimedChest = workspace.TimedChest
local Players = {}

function StartTimer(p)
    Players[p.Name].Amount = Core.Round(p:WaitForChild("leaderstats").Money.Value * REWARD_MULTIPLIER)

    Core.NewThread(function()
        Remotes.StartTimer:FireClient(p, MAX_TIME, Players[p.Name].Amount)
    end)

    for Second = MAX_TIME, 0, -1 do
        Players[p.Name].Seconds = Second
        wait(1)
    end
end

TimedChest.ClickDetector.MouseClick:Connect(function(p)
    if Players[p.Name].Seconds == 0 then
		p.leaderstats.Money.Value = p.leaderstats.Money.Value + Players[p.Name].Amount
		StartTimer(p)
	end
end)

game.Players.PlayerAdded:Connect(function(p)
	Players[p.Name] = {
		Seconds = MAX_TIME,
		Amount = 0
	}
	Core.NewThread(StartTimer, p)	
end)