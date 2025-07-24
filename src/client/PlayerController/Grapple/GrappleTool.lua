local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Player = require(ReplicatedStorage.Shared.Utility.Player)
local getOrCreateAttachment = require(ReplicatedStorage.Shared.Utility.getOrCreateAttachment)
local Grapple = {}

local maxRange = 100

local raycastParams = RaycastParams.new()
local rope = nil
local hook = nil

function Grapple.findTetherPoint()
	local mouseLocation = UserInputService:GetMouseLocation()
	local ray = Workspace.CurrentCamera:ViewportPointToRay(mouseLocation.X, mouseLocation.Y)
	local result = Workspace:Raycast(ray.Origin, ray.Direction * maxRange, raycastParams)
	return result
end

function Grapple.createRope(source: Attachment, target: Attachment)
	local Rope = Instance.new("RopeConstraint")
	Rope.Attachment0 = source
	Rope.Attachment1 = target
	Rope.Length = (source.WorldPosition - target.WorldPosition).Magnitude
	Rope.Thickness = 0.5
	Rope.Visible = true
	Rope.Color = BrickColor.new(0.407843, 0.2, 0.05098)
	Rope.Parent = Workspace
	return Rope
end

function Grapple.rappelUp() end

function Grapple.rappelDown() end

function Grapple.createHook(tetherPoint: Vector3)
	local part = Instance.new("Part")
	local attachment = Instance.new("Attachment")
	part.Shape = Enum.PartType.Ball
	part.Transparency = 0.5
	part.Position = tetherPoint
	part.Anchored = true
	part.Shape = Enum.PartType.Ball
	part.Color = Color3.new(0.745098, 0.121569, 0.121569)
	attachment.Parent = part
	part.Parent = Workspace
	return part
end

function Grapple.hook()
	local result = Grapple.findTetherPoint()
	if not result then
		warn("Player did not hit a grippable object.")
		return
	end
	 hook = Grapple.createHook(result.Position)
	 rope = Grapple.createRope(
		getOrCreateAttachment(Player.getCharacter().HumanoidRootPart.RootAttachment),
		getOrCreateAttachment(hook)
	)


end

function Grapple.unhook()
	rope:Destroy()
	hook:Destroy()
end

return Grapple
