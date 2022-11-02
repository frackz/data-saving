local handler = require(script.Parent.Handler)

local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(plr) handler:PlayerAdded(plr) end)
Players.PlayerRemoving:Connect(function(plr) handler:PlayerRemoving(plr) end)
