-- Script by BobaFeddyWap @ Brutopia Des & Dev
-- Shift 2 Sprint Script - place in StarterPlayerScripts

local player = game.Players.LocalPlayer -- We get the Player 

local mouse = player:GetMouse() -- Get Player's mouse
local running = false -- Set running to false

-- Function to get the tool the player is holding
function getTool()	
	for _, kid in ipairs(script.Parent:GetChildren()) do -- Loop through all the children of the player
		if kid.className == "Tool" then return kid end -- If we find Tool, return it
	end
	return nil -- If we don't find Tool, return nil
end


-- Event: when player presses "LeftShift" key
mouse.KeyDown:connect(function (key) -- Run function passing the key pressed as parameter
	local player = game.Players.LocalPlayer -- Get the local player
	
	key = string.lower(key) -- Make the key lowercase
	
	local tool = getTool() -- Get Tool if player is holding one
	
	if string.byte(key) == 48 then -- If player pressed "LeftShift" key
		
		running = true -- Set running boolean to true
		
		-- Connect anonymous function to the KeyUp event and store connection to a variable
		local keyConnection = mouse.KeyUp:connect(function (key) -- When player releases key 
			if string.byte(key) == 48 then -- If the key released is "LeftShift"
				running = false -- Set runnning bool to false
			end
		end)
		
		-- Change the player's camera's FieldOfView to give cool effect while sprinting
		for i = 1,5 do	-- For loop to animate the FieldOfView change 
			game.Workspace.CurrentCamera.FieldOfView = (70+(i*2)) -- Widen FieldOfView
			wait()
		end
		
		-- Set Player's speed within Humanoid with the player's "runSpeed" property
		player.Character.Humanoid.WalkSpeed = player:WaitForChild("pVars").runSpeed.Value
		repeat wait() until running == false -- Repeat loop until running is false
		-- When running is false, disconnect the keyConnection and reset the player's speed and FieldOfView
		keyConnection:disconnect()
		player.Character.Humanoid.WalkSpeed = 14
		for i = 1,5 do
			game.Workspace.CurrentCamera.FieldOfView = (80-(i*2))
			wait()
		end
	end
end)