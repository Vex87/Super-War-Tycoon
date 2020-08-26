-- // Settings \\ --

local UPDATE_DEPLAY = 1
local CAPTURE_REWARD = 1
local MAX_PARTS = math.huge
local NEUTRAL_COLOR = BrickColor.new("Institutional white")

-- // Variables \\ --

local ConquestPoint = workspace.ConquestPoint
local Beam = ConquestPoint.Beam
local Point1 = ConquestPoint.Point1
local Point2 = ConquestPoint.Point2

-- Creates the region
local Region = Region3.new(Point1.Position, Point2.Position)
local PlayersInRegion = {}
local CurrentOwner

local IgnoreList = {ConquestPoint}

-- // Functions \\ --

function RemovePlayers(PartsInRegion)
    -- If the root in PlayersInRegion is not in PartsInRegion or the player is dead, the player will be removed
    for i,Root in pairs(PlayersInRegion) do
        if Root.Parent.Humanoid.Health == 0 or not table.find(PartsInRegion, Root) then
            table.remove(PlayersInRegion, i)
        end
    end
end

function AddPlayers(PartsInRegion)
    -- If the part in the region is a player, it isn't in PlayersInRegion, and it is alive; it will be added to PlayersInRegion
    for _,Part in pairs(PartsInRegion or {}) do
        local Char = Part.Parent
        if game.Players:FindFirstChild(Char.Name) and Char:FindFirstChild("HumanoidRootPart") and not table.find(PlayersInRegion, Char.HumanoidRootPart) and Char.Humanoid.Health > 0 then
            table.insert(PlayersInRegion, Char.HumanoidRootPart)
        end
    end
end

function AddPoints()
    -- Sets current owner to the only person in the region if applicable, gives them money

    if #PlayersInRegion == 1 then
        local Root = PlayersInRegion[1]
        CurrentOwner = Root
    elseif #PlayersInRegion > 1 then
        CurrentOwner = nil
    end

    if CurrentOwner then
        game.Players[CurrentOwner.Parent.Name].leaderstats.Money.Value = game.Players[CurrentOwner.Parent.Name].leaderstats.Money.Value + CAPTURE_REWARD
    end
end

function Visualize()
    -- If there is a CurrentOwner, then the beam will be the owner's team TeamColor or a neutral color if not applicable
    if CurrentOwner then
        Beam.BrickColor = game.Players[CurrentOwner.Parent.Name].TeamColor
    else
        Beam.BrickColor = NEUTRAL_COLOR
    end
end

-- // Main \\ --

while wait(UPDATE_DEPLAY) do
    local PartsInRegion = workspace:FindPartsInRegion3WithIgnoreList(Region, IgnoreList, MAX_PARTS)
    RemovePlayers(PartsInRegion)
    AddPlayers(PartsInRegion)
    AddPoints()
    Visualize()
end