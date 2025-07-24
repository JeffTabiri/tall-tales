local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Constants = require(ReplicatedStorage.Shared.Constants)
local State = require(ReplicatedStorage.Shared.State)

local Idle = State.new(Constants.STATE_IDLE)

function Idle:init()
end

function Idle:onEnter() end

function Idle:onLeave() end

return Idle
