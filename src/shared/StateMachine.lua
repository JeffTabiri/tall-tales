local StateMachine = {}
StateMachine.__index = StateMachine

function StateMachine.new(initalState: string, states: {})
	local self = setmetatable({}, StateMachine)

	for _, state in states do
		state.setState = self.setState
		state:init()
	end

	self.states = states
	self.current = states[initalState]

	return self
end

function StateMachine:setState(name: string)
	self.current:onLeave()
	self.current = self.states[name]
	self.current:onEnter()
end

return StateMachine
