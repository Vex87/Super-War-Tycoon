-- // Settings \\ --

local DROP_DELAY = 10
local DROP_COUNT = 1
local SPAWN_DELAY = 1

local ORIGINAL_POS = Vector3.new(0, 50, 0)
local MIN_DESPAWN_DELAY = 15
local MAX_DESPAWN_DELAY = 20
local X_OFFSET = 100
local Y_OFFSET = 20
local Z_OFFSET = 100

local MAX_POSSIBLE_REWARDS = 30

-- // Variables \\ --

local Debris = game:GetService("Debris")
local Rewards = require(script.Rewards)
local Remotes = game.ReplicatedStorage.Remotes.LootBox

-- // Functions \\ --

function Touched(NewCrate, Obj)
    local p = game.Players:FindFirstChild(Obj.Parent.Name)
    if p then
        NewCrate:Destroy()
        local Reward = Rewards.ChooseRandomReward(NewCrate)        
        local PossibleRewards = Rewards.ChooseRandomRewards(NewCrate, MAX_POSSIBLE_REWARDS)
        Remotes.Run:FireClient(p, Reward, PossibleRewards)
    end
end

function CloneCrates()
    for Name, Crate in pairs(Rewards.Crates) do
        for x = 1, DROP_COUNT do
            local X = math.random(-X_OFFSET/2, X_OFFSET/2)
            local Y = math.random(-Y_OFFSET/2, Y_OFFSET/2)
            local Z = math.random(-Z_OFFSET/2, Z_OFFSET/2)
    
            local NewCrate = Crate:Clone()
            NewCrate.Parent = workspace.Debris
            NewCrate.Position = ORIGINAL_POS + Vector3.new(X, Y, Z)
            NewCrate.Rotation = Vector3.new(math.random(360), math.random(360), math.random(360))
    
            NewCrate.Touched:Connect(function(Obj)
                Touched(NewCrate, Obj)
            end)
    
            Debris:AddItem(NewCrate, math.random(MIN_DESPAWN_DELAY, MAX_DESPAWN_DELAY))
            wait(SPAWN_DELAY)
        end
    end
end

-- // Events \\ --

Remotes.GiveReward.OnServerEvent:Connect(Rewards.RunFunction)

-- // Main \\ --

while wait(DROP_DELAY) do
    CloneCrates()
end