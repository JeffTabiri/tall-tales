local Loader = {}

function Loader.loadModules(source: Instance)
	local modules = {}

	for _, module in source:GetDescendants() do
		if not module:IsA("ModuleScript") then
			continue
		end
		modules[module.Name] = require(module)
	end

	return modules
end

function Loader.spawnAll(modules: { [string]: any }, methodName: string)
	for name, module in modules do
		local method = module[methodName]
		if type(method) ~= "function" then
			continue
		end

		debug.setmemorycategory(name)
		task.spawn(function()
			debug.setmemorycategory(name)
			method()
		end)
	end
end

return Loader
