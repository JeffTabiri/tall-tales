local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(script.Parent.Constants)
local signal = require(ReplicatedStorage.Packages.signal)

local StateMachine = {}
StateMachine.__index = StateMachine

function StateMachine.new(initalState: string, states: {}, transitions: {})
	local self = setmetatable({}, StateMachine)
	self.stateChanged = signal.new()
	self.transitions = transitions
	self.states = states
	self.previous = nil

	for _, state in self.states do
		state.setState = function(name: string)
			self:setState(name)
		end
		state:init()
	end

	self.current = self.states[initalState]
	return self
end

function StateMachine:setState(name: string)
	if not Constants.STATE_TRANSITIONS[self.current.name][name] then
		warn("Transition is illegal.")
		return
	end

	self.current:onLeave()
	self.previous = self.current
	
	self.current = self.states[name]
	self.current:onEnter()

	self.stateChanged:Fire(self.previous, self.current)
end

function StateMachine:getState()
	return self.current
end

return StateMachine
