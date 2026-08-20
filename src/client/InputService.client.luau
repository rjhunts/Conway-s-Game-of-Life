local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpdateCellFunction = ReplicatedStorage:WaitForChild("UpdateCellFunction")
local ToggleSimulationEvent = ReplicatedStorage:WaitForChild("ToggleSimulationEvent")
local ScreenGUI = Player:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")
local Frame = ScreenGUI:WaitForChild("Frame")
local ToggleButton = Frame:WaitForChild("TextButton")
local Speed = Frame:WaitForChild("TextBox")
local isToggled = false

function fixUI()
	-- Connect to the InputBegan event to detect mouse clicks
	UIS.InputBegan:Connect(function(input, gameProcessedEvent)
		if gameProcessedEvent then return end

		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			local Mouse = Player:GetMouse()
			local Target = Mouse.Target
			if not Target then return end

			if Target:HasTag("Cell") then
				UpdateCellFunction:InvokeServer(Target)
			end
		end
	end)

	local function fixText()
		ToggleButton.Text = isToggled and "On" or "Off"
	end
	fixText()

	ToggleButton.MouseButton1Click:Connect(function()
		isToggled = not isToggled
		fixText()

		ToggleSimulationEvent:FireServer(isToggled)
	end)
end

if Player.Character then
	fixUI()
else
	Player.CharacterAdded:Wait()
	fixUI()
end
Player.CharacterAdded:Connect(function()
	fixUI()
end)