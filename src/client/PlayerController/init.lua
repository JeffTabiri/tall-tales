local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Constants)
local StateMachine = require(ReplicatedStorage.Shared.StateMachine)
local Player = require(ReplicatedStorage.Shared.Utility.Player)
local loadModules = require(ReplicatedStorage.Shared.Utility.loadModules)

local machine = nil
local connection = nil

local Module = {}

function Module.init()
	local onStateChanged = function(old, new)
		Player.getCharacter():SetAttribute(Constants.ATTRIBUTE_STATE_PREVIOUS, old.name)
		Player.getCharacter():SetAttribute(Constants.ATTRIBUTE_STATE_CURRENT, new.name)
        Player.getHumanoid().WalkSpeed = 100
	end
	machine = StateMachine.new(Constants.STATE_IDLE, loadModules(script), Constants.STATE_TRANSITIONS)
	connection = machine.stateChanged:Connect(onStateChanged)
end

function Module.onStart() end

return Module
