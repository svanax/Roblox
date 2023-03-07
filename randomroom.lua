local rooms = game.ReplicatedStorage.Roomremote:WaitForChild("Rooms"):GetChildren()
for i, placeholder in pairs(game.Workspace.Placeholders:GetChildren()) do
	local selectedRoom = rooms[math.random(1,#rooms)]
	selectedRoom.PrimaryPart = selectedRoom.Floor
	selectedRoom:setPrimaryPartCFrame(placeholder.CFrame)
	
	placeholder:Destroy()
	selectedRoom.Parent = game.Workspace
	
end
