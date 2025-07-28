local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local Module = {}

local currentWeather = nil
local timeRunning = nil
local clockTimeDt = 0.01
local connection = nil

function Module.init()
	connection = RunService.Heartbeat:Connect(Module.cycleDay)
	timeRunning = true

	-- Initatiate setting for Litghting box
end

function Module.cycleDay(deltaTime: number)
	Lighting.ClockTime += clockTimeDt
end

function Module.setWeather(weather: string)
	-- Sets weather
end

function Module.getWeather()
	-- Gets weather
end

function Module.toggleDayNightCycle()
	if timeRunning then
		timeRunning = false
		connection:Disconnect()
		connection = nil
	else
		connection = RunService.Heartbeat:Connect(Module.cycleDay)
		timeRunning = true
	end
end

return Module
