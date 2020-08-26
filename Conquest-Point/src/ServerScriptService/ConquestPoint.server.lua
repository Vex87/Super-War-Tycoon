-- // Settings \\ --

local UPDATE_DEPLAY = 1
local MONEY_MULTIPLIER = 1
local MAX_PARTS = math.huge
local NEUTRAL_COLOR = BrickColor.new("Institutional white")
local POINT_TAG = "Point"

-- // Variables \\ --

local CollectionService = game:GetService("CollectionService")
local Core = require(game.ReplicatedStorage.Core)
local Points = {}

-- // Functions \\ --

function RemovePlayers(Info)
    for i,p in pairs(Info.PlayersInRegion) do
        local Char = p.Character
        if Char.Humanoid.Health == 0 or not table.find(Info.PartsInRegion, Char.HumanoidRootPart) then
            table.remove(Info.PlayersInRegion, i)
        end
    end
end

function AddPlayers(Info)
    for _,Part in pairs(Info.PartsInRegion or {}) do
        local Char = Part.Parent
        local p = game.Players:FindFirstChild(Char.Name)
        if p and Char:FindFirstChild("HumanoidRootPart") and not table.find(Info.PlayersInRegion, p) and Char.Humanoid.Health > 0 then
            table.insert(Info.PlayersInRegion, p)
        end
    end
end

function AddPoints(Info)
    if #Info.PlayersInRegion == 1 and Info.CurrentOwner ~= Info.PlayersInRegion[1] then
        
        if Info.CurrentOwner then
            Info.CurrentOwner.Stats.MoneyMultiplier.Value = Info.CurrentOwner.Stats.MoneyMultiplier.Value - MONEY_MULTIPLIER
        end

        Info.CurrentOwner = Info.PlayersInRegion[1]
        Info.CurrentOwner.Stats.MoneyMultiplier.Value = Info.CurrentOwner.Stats.MoneyMultiplier.Value + MONEY_MULTIPLIER

    elseif #Info.PlayersInRegion > 1 then
        if Info.CurrentOwner then
            Info.CurrentOwner.Stats.MoneyMultiplier.Value = Info.CurrentOwner.Stats.MoneyMultiplier.Value - MONEY_MULTIPLIER
        end
        Info.CurrentOwner = nil
    end
end

function Visualize(Info)
    if Info.CurrentOwner then
        Info.Point.Beam.BrickColor = Info.CurrentOwner.TeamColor
    else
        Info.Point.Beam.BrickColor = NEUTRAL_COLOR
    end
end

function Initiate(Point)

    local Info = {
        Point = Point,
        Region = Region3.new(Point.Point1.Position, Point.Point2.Position),
        PlayersInRegion = {},
        CurrentOwner = nil,    
        IgnoreList = {Point},
        PartsInRegion = {}
    }
    Points[Point.Name] = Info

    while wait(UPDATE_DEPLAY) do
        Info.PartsInRegion = workspace:FindPartsInRegion3WithIgnoreList(Info.Region, Info.IgnoreList, MAX_PARTS)
        RemovePlayers(Info)
        AddPlayers(Info)
        AddPoints(Info)
        Visualize(Info)
    end

end

-- // Main \\ --

for _,Point in pairs(CollectionService:GetTagged(POINT_TAG)) do
    Core.NewThread(Initiate, Point)
end

CollectionService:GetInstanceAddedSignal(POINT_TAG):Connect(function(Point)
    Core.NewThread(Initiate, Point)
end)