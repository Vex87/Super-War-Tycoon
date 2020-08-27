wait(1)

local CHOSEN_REWARD_I = 24
local START_POS = UDim2.new(0, 0, 0.5, 0)
local END_POS = UDim2.new(-1.43, 0, 0.5, 0)

local EASE_DIRECTION = Enum.EasingDirection.Out
local EASE_STYLE = Enum.EasingStyle.Quart
local TWEEN_DURATION = 3
local OVERRIDES = false
local BREAK_DURATION = 2

local Core = require(game.ReplicatedStorage.Modules.Core)
local TweenService = game:GetService("TweenService")
local Remotes = game.ReplicatedStorage.Remotes
local p = game.Players.LocalPlayer

local UI = p.PlayerGui:WaitForChild("LootBox")
local Rewards = UI.Rewards
local Pin = UI.Pin

function StartTween(Reward)
    Rewards:TweenPosition(END_POS, EASE_DIRECTION, EASE_STYLE, TWEEN_DURATION, OVERRIDES, function()
        Core.NewThread(function()
            wait(BREAK_DURATION)
            Rewards.Visible, Pin.Visible = false, false
        end)

        Remotes.GiveReward:FireServer(Reward)
    end)
end

function MakeRewards(Reward, PossibleRewards)
    for _,Reward in pairs(Core.Get(Rewards, "Frame")) do
        Reward:Destroy()
    end

    for i, Reward in pairs(PossibleRewards) do
        if i ~= CHOSEN_REWARD_I then
            local NewReward = Rewards.ListLayout[Reward]:Clone()
            NewReward.LayoutOrder = i
            NewReward.Parent = Rewards
        end
    end

    local ChosenReward = Rewards.ListLayout[Reward]:Clone()
    ChosenReward.LayoutOrder = CHOSEN_REWARD_I
    ChosenReward.Parent = Rewards

    Rewards.Position = START_POS
    Rewards.Visible, Pin.Visible = true, true
end

Remotes.RunLootBox.OnClientEvent:Connect(function(Reward, PossibleRewards)
    MakeRewards(Reward, PossibleRewards)
    StartTween(Reward)
end)