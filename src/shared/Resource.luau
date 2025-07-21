local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local signal = require(ReplicatedStorage.Packages.signal)

local Resource = {}
Resource.__index = Resource

function Resource.new(max: number, growth: number)
	local self = setmetatable({}, Resource)

	self.max = max
	self.current = max
	self.growth = growth
	self.changed = signal.new()
	self.connection = nil

	return self
end

function Resource:increase()
	self:add(self.growth)
	self.changed:Fire(self.current)

	if self.current == self.max then
		self.connection:Disconnect()
		self.connection = nil
	end
end

function Resource:setGrowth(growth: number)
	self.growth = growth
end

function Resource:setMax(max: number)
	self.max = max
end

function Resource:use(amount: number)
	if self.current - amount < 0 then
		return false
	else
		self.current -= amount

		if not self.connection then
			self.connection = RunService.Heartbeat:Connect(function()
				self:increase()
			end)
		end

		return true
	end
end

function Resource:add(amount: number)
	if self.current + amount > self.max then
		self.current = self.max
	else
		self.current += amount
	end
end

function Resource:destroy()
	if self.connection then
		self.connection:Disconnect()
		self.connection = nil
	end
end

return Resource
