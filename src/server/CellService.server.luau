local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpdateCellFunction = ReplicatedStorage:WaitForChild("UpdateCellFunction")

UpdateCellFunction.OnServerInvoke = function(player, cell)
    checkCell(cell)
end

function checkCell(cell)

	local white = Color3.fromRGB(255, 255, 255)
	local black = Color3.fromRGB(0, 0, 0)

	if cell.Color == white then
		cell.Color = black -- Change cell to black
	else
		cell.Color = white -- Change cell to white
	end
end

local ToggleSimulationEvent = ReplicatedStorage:WaitForChild("ToggleSimulationEvent")
ToggleSimulationEvent.OnServerEvent:Connect(function(player, state)
	-- Handle the toggle simulation event here
	print(player.Name .. " toggled simulation to: " .. tostring(state))
	-- You can add logic to start or stop the simulation based on the state
	STATE = state
	runSimulation()
end)

STATE = false -- Initial state of the simulation

function runSimulation()
	while STATE do
		print("Simulation running...")
		task.wait(1)
	end
end