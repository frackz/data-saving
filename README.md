# data-saving
A easy system for data saving

This works by - using the module script, you can add a function that will run when the user (joins) and (leaves). But there is a twist, instead of you only getting the player as a argument, you get the loaded data from the datastore, plus a Handler module that contains a .New function that can easily create new files for you!

```lua
local Data = require(script.Parent.module)
Data.Added(function(Player, Data, Handler)
  print("Player "..Player.Name.." joined with data "..Data..")
  local Cash = Handler.New(
  'Cash', -- Name
  Player, -- Path
  'IntValue', -- Type (StringValue, IntValue for example)
  true -- Value
  )
  print("User now got a Cash value")

  -- Read the "Data.Removed" first. Before this part
  -- And you can now get the "Cash" value set down in our Data.Removed
  if Data[Cash] ~= nil then
    Cash = Data[Cash]
  end
end)

Data.Removed(function(Player, Set)
  -- The set function works by, you are getting an array where you can set a key, and it will put it on the datastore.
  -- So instead of you pulling from multiple datastores, which causes lag it only pulls 1 data from the datastore.
  -- So for example, you can use this!
  Set("Cash", 1000)
end)
```
