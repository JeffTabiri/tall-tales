local ReplicatedStorage = game:GetService("ReplicatedStorage")
local disconnectAndClear = require(ReplicatedStorage.Shared.Utility.disconnectAndClear)
local View = {}
View.__index = View

function View.new()
	local self = setmetatable({}, View)
	self.connections = {}
	return self
end

function View:onEnter() end

function View:onLeave() end

function View:destroy()
	disconnectAndClear(self.connections)
end

return View
