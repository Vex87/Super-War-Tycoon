local Rewards = {
    Crates = {},
    Objects = {},
    Functions = {},
    Rewards = {},
}
local CrateStorage = game.ServerStorage.Objects.Crates
local WeaponStorage = game.ServerStorage.Objects.Weapons

Rewards.Crates = {
    Air = CrateStorage.Air;
    Doom = CrateStorage.Doom;
    Fire = CrateStorage.Fire;
    God = CrateStorage.God;
    Water = CrateStorage.Water;
}

Rewards.Objects = {
    Money100 = {
        Type = "Money",
        Chance = 31,
        Crates = {"Air", "Doom", "Fire", "God", "Water"},
        Amount = 100
    },
    Money200 = {
        Type = "Money",
        Chance = 30,
        Crates = {"Air", "Doom", "Fire", "God", "Water"},
        Amount = 200
    },
    Money300 = {
        Type = "Money",
        Chance = 29,
        Crates = {"Air", "Doom", "Fire", "God", "Water"},
        Amount = 300
    },
    Money400 = {
        Type = "Money",
        Chance = 27,
        Crates = {"Air", "Doom", "Fire", "God", "Water"},
        Amount = 400
    },
    Money500 = {
        Type = "Money",
        Chance = 25,
        Crates = {"Air", "Doom", "Fire", "God", "Water"},
        Amount = 500
    },
    ["Air Auto Pistol"] = {
        Type = "Weapon",
        Chance = 15,
        Crates = {"Air"}
    },
    ["Air Shotgun"] = {
        Type = "Weapon",
        Chance = 11,
        Crates = {"Air"}
    },
    ["Air Knife"] = {
        Type = "Weapon",
        Chance = 22,
        Crates = {"Air"}
    },
    ["Air Pistol"] = {
        Type = "Weapon",
        Chance = 19,
        Crates = {"Air"}
    },
    ["Air Rifle"] = {
        Type = "Weapon",
        Chance = 6,
        Crates = {"Air"}
    },
    ["Air Rocket Launcher"] = {
        Type = "Weapon",
        Chance = 1,
        Crates = {"Air"}
    },
    ["Doom Auto Pistol"] = {
        Type = "Weapon",
        Chance = 15,
        Crates = {"Doom"}
    },
    ["Doom Shotgun"] = {
        Type = "Weapon",
        Chance = 11,
        Crates = {"Doom"}
    },
    ["Doom Knife"] = {
        Type = "Weapon",
        Chance = 22,
        Crates = {"Doom"}
    },
    ["Doom Pistol"] = {
        Type = "Weapon",
        Chance = 19,
        Crates = {"Doom"}
    },
    ["Doom Rifle"] = {
        Type = "Weapon",
        Chance = 6,
        Crates = {"Doom"}
    },
    ["Doom Rocket Launcher"] = {
        Type = "Weapon",
        Chance = 1,
        Crates = {"Doom"}
    },
    ["Electric Auto Pistol"] = {
        Type = "Weapon",
        Chance = 15,
        Crates = {"God"},
    },
    ["Electric Knife"] = {
        Type = "Weapon",
        Chance = 22,
        Crates = {"God"},
    },
    ["Electric Pistol"] = {
        Type = "Weapon",
        Chance = 19,
        Crates = {"God"},
    },
    ["Electric Rocket Launcher"] = {
        Type = "Weapon",
        Chance = 1,
        Crates = {"God"},
    },
    ["Electric Shotgun"] = {
        Type = "Weapon",
        Chance = 20,
        Crates = {"God"},
    },
    ["Fire Auto Pistol"] = {
        Type = "Weapon",
        Chance = 11,
        Crates = {"Fire"},
    },
    ["Fire Pistol"] = {
        Type = "Weapon",
        Chance = 19,
        Crates = {"Fire"},
    },
    ["Fire Rifle"] = {
        Type = "Weapon",
        Chance = 6,
        Crates = {"Fire"},
    },
    ["Fire Rocket Launcher"] = {
        Type = "Weapon",
        Chance = 1,
        Crates = {"Fire"},
    },
    ["Fire Shotgun"] = {
        Type = "Weapon",
        Chance = 11,
        Crates = {"Fire"},
    },
    ["Water Auto Pistol"] = {
        Type = "Weapon",
        Chance = 15,
        Crates = {"Water"},
    },
    ["Water Knife"] = {
        Type = "Weapon",
        Chance = 22,
        Crates = {"Water"},
    },
    ["Water Pistol"] = {
        Type = "Weapon",
        Chance = 19,
        Crates = {"Water"},
    },
    ["Water Rifle"] = {
        Type = "Weapon",
        Chance = 6,
        Crates = {"Water"},
    },
    ["Water Rocket Launcher"] = {
        Type = "Weapon",
        Chance = 1,
        Crates = {"Water"},
    },
}

function Rewards.ChooseRandomReward(Crate)
    return Rewards.Rewards[Crate.Name][math.random(#Rewards.Rewards[Crate.Name])]
end

function Rewards.ChooseRandomRewards(Crate, Amount)
    local PossibleRewards = {}
    for RewardNum = 1, Amount do
        table.insert(PossibleRewards, Rewards.ChooseRandomReward(Crate))
    end
    return PossibleRewards
end

function Rewards.RunFunction(p, Name)
    Rewards.Functions[Rewards.Objects[Name].Type](p, Name)
end

function Rewards.Functions.Money(p, Name)
    local Amount = Rewards.Objects[Name].Amount
    p.leaderstats.Money.Value = p.leaderstats.Money.Value + Amount
end

function Rewards.Functions.Weapon(p, Name)
    local Backpack = p:WaitForChild("Backpack")
    WeaponStorage[Name]:Clone().Parent = Backpack
end

-- Creates tables for all of the rewards and crates

for Crate,_ in pairs(Rewards.Crates) do
    Rewards.Rewards[Crate] = {}
end

for Name, Info in pairs(Rewards.Objects) do
    for _,Crate in pairs(Info.Crates) do
        for Chance = 1, Info.Chance do
            table.insert(Rewards.Rewards[Crate], Name)
        end
    end
end

return Rewards