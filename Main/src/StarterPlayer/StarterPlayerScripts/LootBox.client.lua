wait(1)

-- // Settings \\ --

local CHOSEN_REWARD_I = 24
local END_POS = UDim2.new(-1.425, 0, 0.5, 0)
local RAN_OFFSET = 0.03
local RAN_PRECISION = 100

local EASE_DIRECTION = Enum.EasingDirection.Out
local EASE_STYLE = Enum.EasingStyle.Quart
local TWEEN_DURATION = 5
local OVERRIDES = false
local BREAK_DURATION = 2
local TICK_DELAY = 0.1

-- // Variables \\ --

local Core = require(game.ReplicatedStorage.Modules.Core)
local Remotes = game.ReplicatedStorage.Remotes.LootBox
local p = game.Players.LocalPlayer

local UI = p.PlayerGui:WaitForChild("LootBox")
local Frame = UI.ListLayout.Frame

-- // Functions \\ --

function StartTween(Info)

    local RandomPos = END_POS + UDim2.new(math.random(-RAN_OFFSET*RAN_PRECISION, RAN_OFFSET*RAN_PRECISION)/RAN_PRECISION)
    Info.Frame.Rewards:TweenPosition(RandomPos, EASE_DIRECTION, EASE_STYLE, TWEEN_DURATION, OVERRIDES, function()
        Core.NewThread(function()
            wait(BREAK_DURATION)
            Info.Frame:Destroy()
        end)

        Info.Frame.Reward:Play()
        Remotes.GiveReward:FireServer(Info.Reward)
    end)
end

function MakeRewards(Info)
    for i, Reward in pairs(Info.PossibleRewards) do
        if i ~= CHOSEN_REWARD_I then
            local NewReward = Info.Frame.Rewards.ListLayout[Reward]:Clone()
            NewReward.LayoutOrder = i
            NewReward.Parent = Info.Frame.Rewards

            Core.NewThread(function()
                while wait(TICK_DELAY) do
                    if NewReward.AbsolutePosition.X < 0 then
                        local TickSound = Info.Frame.Tick:Clone()
                        TickSound.Parent = Info.Frame
                        TickSound:Play()
                        TickSound.Ended:Wait()
                        TickSound:Destroy()
                        break
                    end
                end
            end)
        end
    end

    local ChosenReward = Info.Frame.Rewards.ListLayout[Info.Reward]:Clone()
    ChosenReward.LayoutOrder = CHOSEN_REWARD_I
    ChosenReward.Parent = Info.Frame.Rewards
end

function Init(Reward, PossibleRewards)
    local Info = {
        Reward = Reward,
        PossibleRewards = PossibleRewards,
        IsWorking = false,
    }

    Info.Frame = Frame:Clone()
    Info.Frame.Parent = UI

    MakeRewards(Info)
    StartTween(Info)
end

-- // Events \\ --

Remotes.Run.OnClientEvent:Connect(function(...)
    Core.NewThread(Init, ...)
end)