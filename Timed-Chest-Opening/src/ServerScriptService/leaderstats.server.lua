local REWARD_DELAY = 1
local REWARD_AMOUNT = 100

game.Players.PlayerAdded:Connect(function(p)

    -- Leaderstats
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = p

    local Money = Instance.new("IntValue")
    Money.Name = "Money"
    Money.Parent = leaderstats   

    while wait(REWARD_DELAY) do
        Money.Value = Money.Value + REWARD_AMOUNT
    end

end)