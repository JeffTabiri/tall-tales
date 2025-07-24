local State = {}
State.__index = State

--[[ 
	Represents player state,
]]
function State.new(name: string)
	local self = setmetatable({}, State)
	self.changeState = nil
    self.name = name
	self.connections = {}
	return self
end

function State:init(): () end

function State:onEnter(): () end

function State:onLeave(): () end

function State:destroy(): () end

return State
