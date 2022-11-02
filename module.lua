local module = {}

local DataStoreName = "UserData"

local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore(DataStoreName)

local Funcs = {
	['Added'] = {},
	['Removed'] = {}
}

function module:PlayerAdded(Player)
	local Handler = {}
	Handler.New = function(
		name : string,
		path : Instance,
		instance : string,
		value : any
	)
		local NewInstance = Instance.new(instance, path)
		NewInstance.Name = name
		NewInstance.Value = value
		return NewInstance
	end

	local Success, Data = pcall(function()
		return DataStore:GetAsync(Player.UserId)
	end)

	if not Success then warn(Data) Data = {} end
	if Data == nil then Data = {} end
	for i,v in pairs(Funcs.Added) do
		v(Player, Data, Handler)
	end
end

function module:PlayerRemoving(Player)
	local Data = {}
	local Set = function(key,val) Data[key] = val end

	for i,v in pairs(Funcs.Removed) do
		v(Player, Set)
	end

	local Success, Error = pcall(function()
		DataStore:SetAsync(Player.UserId, Data)
	end)
	if not Success then
		return warn(Error)
	end
end

module.Added = function(func)
	table.insert(Funcs.Added, func)
end

module.Removed = function(func)
	table.insert(Funcs.Removed, func)
end

return module
