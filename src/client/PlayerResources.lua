local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Resource = require(ReplicatedStorage.Shared.Resource)

local StaminaBar = Resource.new(100, 10)

local function onStaminaChanged(stamina: number)
	print(stamina)
end

StaminaBar.changed:Connect(onStaminaChanged)

StaminaBar:use(60)
