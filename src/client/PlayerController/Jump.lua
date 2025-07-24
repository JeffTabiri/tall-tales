local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Constants = require(ReplicatedStorage.Shared.Constants)
local State = require(ReplicatedStorage.Shared.State)
local Player = require(ReplicatedStorage.Shared.Utility.Player)

local Jump = State.new(Constants.STATE_JUMP)

local doubleJump = false

function Jump:init()
	local onJump = function(active: boolean)
		if active then
			self.setState(Constants.STATE_JUMP)
		end
	end

	local onSpaceInput = function(inputObject, isTyping)
		if isTyping then
			return
		end
		if inputObject.KeyCode == Enum.KeyCode.Space then
			if doubleJump then
				Player.getHumanoid():ChangeState(Enum.HumanoidStateType.Jumping)
				doubleJump = false
			end
		end
	end

	local onStateChanged = function(old: Enum.HumanoidStateType, new: Enum.HumanoidStateType)
		if new == Enum.HumanoidStateType.Jumping and not doubleJump then
			if old == Enum.HumanoidStateType.Running then
				doubleJump = true
			end
		elseif new == Enum.HumanoidStateType.Landed then
			doubleJump = false
		end
	end

	table.insert(self.connections, {
		Player.getHumanoid().Jumping:Connect(onJump),
		UserInputService.InputBegan:Connect(onSpaceInput),
		Player.getHumanoid().StateChanged:Connect(onStateChanged),
	})
end

function Jump:onEnter() end

function Jump:onLeave() end

return Jump
