local State = {}
State.__index = State

--[[ 
	Represents player state,
]]
function State.new()
	local self = setmetatable({}, State)
	self.changeState = nil
	return self
end

function State:init(): () end

function State:onEnter(): () end

function State:onLeave(): () end

function State:destroy(): () end

return State
