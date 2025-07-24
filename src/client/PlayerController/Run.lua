local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Constants)
local Player = require(ReplicatedStorage.Shared.Utility.Player)
local State = require(ReplicatedStorage.Shared.State)
local Run = State.new(Constants.STATE_RUN)

function Run:init()
	local onRun = function()
		local isMoving = Player.getHumanoid().MoveDirection.Magnitude > 0
		if isMoving then
			self.setState(Constants.STATE_RUN)
		else
			self.setState(Constants.STATE_IDLE)
		end
	end

	table.insert(self.connections, Player.getHumanoid().Running:Connect(onRun))
end

function Run:onEnter() end

function Run:onLeave() end

return Run
