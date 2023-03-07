a-- Variables Prep --

local Players = game:GetService("Players")
local http = game:GetService("HttpService")
local webhook = "https://discord.com/api/webhooks/" 

-- Actual Code --

Players.PlayerAdded:Connect(function(plr)
	local data = 
		{
			["contents"] = "",
			["embeds"] = {{
				["title"]= plr.name,
				["description"] = "player came to eat",
				["type"]= "rich",
				["color"]= tonumber(0x36393e),
				["fields"]={
					{
						["name"]="Player joined the game",
						["value"]="User: **"..plr.Name.."** with ID: **"..plr.UserId.."** has joined [game](https://www.roblox.com/games/".. game.PlaceId..")/[Profile](https://www.roblox.com/users/"..plr.UserId.."/profile)",
						["inline"]=true}}}}
		}
	http:PostAsync(webhook,http:JSONEncode(data))
end)

Players.PlayerRemoving:Connect(function(plr)
	local leavedata = 
		{
			["contents"] = "",
			["embeds"] = {{
				["title"]= plr.name,
				["description"] = "player was saturated",
				["type"]= "rich",
				["color"]= tonumber(0x36393e),
				["fields"]={
					{
						["name"]="Player left the game",
						["value"]="User: **"..plr.Name.."** with ID: **"..plr.UserId.."** left [game](https://www.roblox.com/games/".. game.PlaceId..")/[Profile](https://www.roblox.com/users/"..plr.UserId.."/profile)",
						["inline"]=true}}}}
		}
	http:PostAsync(webhook,http:JSONEncode(leavedata))
end)
