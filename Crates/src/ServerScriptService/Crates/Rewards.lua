local Rewards = {
    Objects = {},
    Functions = {},
    AllRewards = {},
}

Rewards.Objects = {
    Money100 = {
        Type = "Money",
        Chance = 5,
        Amount = 100
    },
    Money200 = {
        Type = "Money",
        Chance = 4,
        Amount = 200
    },
    Money300 = {
        Type = "Money",
        Chance = 3,
        Amount = 300
    },
    Money400 = {
        Type = "Money",
        Chance = 2,
        Amount = 400
    },
    Money500 = {
        Type = "Money",
        Chance = 1,
        Amount = 500
    },
}

function Rewards.ChooseRandomReward()
    return Rewards.AllRewards[math.random(#Rewards.AllRewards)]
end

function Rewards.RunFunction(p, Name)
    Rewards.Functions[Rewards.Objects[Name].Type](p, Name)
end

function Rewards.Functions.Money(p, Name)
    local Amount = Rewards.Objects[Name].Amount
    p.leaderstats.Money.Value = p.leaderstats.Money.Value + Amount
end

for Name, Info in pairs(Rewards.Objects) do
    for Chance = 1, Info.Chance do
        table.insert(Rewards.AllRewards, Name)
    end
end

return Rewards