local Weather = {}
Weather.__index = Weather

function Weather.new(name: string)
    local self = setmetatable({}, Weather)
    self.name = name
	self.connections = {}
	return self
end
function Weather:onEnter()    end

return Weather