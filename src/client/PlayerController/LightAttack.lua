local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Constants = require(ReplicatedStorage.Shared.Constants)
local State = require(ReplicatedStorage.Shared.State)
local LightAttack = State.new(Constants.STATE_LIGHT_ATTACK)

function LightAttack:init()
	local connection = ContextActionService:BindAction(Constants.STATE_LIGHT_ATTACK, function(...: any)
		self:handleInput(...)
	end, true, Enum.UserInputType.MouseButton1)
	table.insert(self.connections, connection)
end

function LightAttack:handleInput(actionName, inputState, inputObject)
	if inputState ~= Enum.UserInputState.Begin then
		return
	end
	print("Hit")
	self.setState(Constants.STATE_LIGHT_ATTACK)
end

function LightAttack:onEnter() end

function LightAttack:onLeave() end

return LightAttack
