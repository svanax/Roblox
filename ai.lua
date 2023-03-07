local Dummy = script.Parent
local humanoid = Dummy.Humanoid
Dummy.PrimaryPart:SetNetworkOwner(nil)

local function canSeeTarget(target)
	local origin = Dummy.HumanoidRootPart.Position
	local direction = (target.HumanoidRootPart.Position - Dummy.HumanoidRootPart.Position).unit * 40
	local ray = Ray.new(origin, direction)

	local hit, pos = workspace:FindPartOnRay(ray, Dummy)


	if hit then
		if hit:IsDescendantOf(target) then
			return true
		end
	else
		return false
	end
end

local function findTarget()
	local players = game.Players:GetPlayers()
	local maxDistance = 100
	local nearestTarget

	for index, player in pairs(players) do
		if player.Character then
			local target = player.Character
			local distance = (Dummy.HumanoidRootPart.Position - target.HumanoidRootPart.Position).Magnitude

			if distance < maxDistance and canSeeTarget(target) then
				nearestTarget = target
				maxDistance = distance
			end
		end
	end

	return nearestTarget
end

local function getPath(destination)
	local PathfindingService = game:GetService("PathfindingService")

	local pathParams = {
		["AgentHeight"] = 5,
		["AgentRadius"] = 3,
		["AgentCanJump"] = false
	}

	local path = PathfindingService:CreatePath(pathParams)

	path:ComputeAsync(Dummy.HumanoidRootPart.Position, destination.Position)

	return path
end

local function attack(target)
	local distance = (Dummy.HumanoidRootPart.Position - target.HumanoidRootPart.Position).Magnitude

	if distance > 3.5 then
		humanoid:MoveTo(target.HumanoidRootPart.Position)
	else
		local attackAnim = humanoid:LoadAnimation(script.Attack)
		attackAnim:Play()
		target.Humanoid.Health = target.Humanoid.Health - 60
		wait(0.5)
	end
end

local function walkTo(destination)

	local path = getPath(destination)

	if path.Status == Enum.PathStatus.Success then
		for index, waypoint in pairs(path:GetWaypoints()) do
			local target = findTarget()
			if target and target.Humanoid.Health > 0 then
				Dummy.Humanoid.WalkSpeed = 16
				print("found")
				attack(target)
				break
			else
				Dummy.Humanoid.WalkSpeed = 10
				print("move")
				humanoid:MoveTo(waypoint.Position)
				humanoid.MoveToFinished:Wait()
			end
		end
	else
		humanoid:MoveTo(destination.Position - (Dummy.HumanoidRootPart.CFrame.LookVector * 10))
	end
end

function patrol()
	local waypoints = workspace.waypoints:GetChildren()
	local randomNum = math.random(1, #waypoints)
	walkTo(waypoints[randomNum])
end

while wait(0.01) do
	patrol()
end

