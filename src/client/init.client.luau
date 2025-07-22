local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Loader = require(ReplicatedStorage.Shared.Loader)

local modules = Loader.loadModules(script)

Loader.spawnAll(modules, "init")
Loader.spawnAll(modules, "onStart")
