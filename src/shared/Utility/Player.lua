local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local Player = {}

function Player.getCharacter(): Model
	return localPlayer.character or localPlayer.CharacterAdded:Wait()
end

function Player.getHumanoid(): Humanoid
	local humanoid = Player.getCharacter():FindFirstChild("Humanoid")
	if not humanoid then
		warn("Humanoid does not exist")
	end
	return humanoid
end

return Player
