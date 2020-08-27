game.Players.PlayerAdded:Connect(function(p)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = p
    
    local Money = Instance.new("IntValue")
    Money.Name = "Money"
    Money.Parent = leaderstats
    
end)