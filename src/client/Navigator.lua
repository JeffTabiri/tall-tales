local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local PlayerGui = Players.LocalPlayer.PlayerGui
local Views: Instance = ReplicatedStorage.Views

local Module = {}

local views = {}
local current = nil

function Module.init()
	for _, value in ipairs(Views:GetChildren()) do
		-- If the value is not our screenGUI, skip it.
		if not value:IsA("ScreenGui") then
			continue
		end

		local clone = value:Clone()
		clone.Enabled = false
		clone.Parent = PlayerGui

		views[clone.Name] = {
			gui = clone,
			module = require(clone.ModuleScript),
		}
	end

	Module.navigateTo("Hud")
end

function Module.navigateTo(name: string)
	local view = views[name]

	if not view then
		warn("UI not found: " .. name)
		return
	end

	if current then
		current.module:onLeave()
		current.gui.Enabled = false
	end

	current = view
	current.gui.Enabled = true
	current.module.onEnter()
end

return Module
