local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

Player.CharacterAdded:Connect(function(Character)
	UIS.InputBegan:Connect(function(input, gameProcessedEvent)
		if gameProcessedEvent then return end	
		
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			local Mouse = Player:GetMouse()
			local Target = Mouse.Target
			if not Target then return end
		    
			if Target:HasTag("Cell") then
				print("Cell " .. Target.Name .. " Clicked")
			end
		end
	end)
end)