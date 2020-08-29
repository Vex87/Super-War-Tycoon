-- // Settings \\ --

local REWARD_DELAY = 1

-- // Events \\ --

workspace.Map.Buttons.IncreaseRevenue.ClickDetector.MouseClick:Connect(function(p)
    p.Stats.Revenue.Value = p.Stats.Revenue.Value + 1
end)

workspace.Map.Buttons.DecreaseRevenue.ClickDetector.MouseClick:Connect(function(p)
    p.Stats.Revenue.Value = p.Stats.Revenue.Value - 1
end)

game.Players.PlayerAdded:Connect(function(p)

    -- Leaderstats
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = p

    local Money = Instance.new("IntValue")
    Money.Name = "Money"
    Money.Parent = leaderstats   

    -- Stats
    local Stats = Instance.new("Folder")
    Stats.Name = "Stats"
    Stats.Parent = p

    local Revenue = Instance.new("IntValue")
    Revenue.Name = "Revenue"
    Revenue.Value = 1
    Revenue.Parent = Stats 

    local MoneyMultiplier = Instance.new("NumberValue")
    MoneyMultiplier.Name = "MoneyMultiplier"
    MoneyMultiplier.Value = 1
    MoneyMultiplier.Parent = Stats 

    while wait(REWARD_DELAY) do
        Money.Value = Money.Value + (Revenue.Value * MoneyMultiplier.Value)
    end

end)