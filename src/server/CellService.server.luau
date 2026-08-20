local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpdateCellFunction = ReplicatedStorage:WaitForChild("UpdateCellFunction")
local UpdateSpeedEvent = ReplicatedStorage:WaitForChild("UpdateSpeedEvent")
local Cells = workspace:WaitForChild("Cells"):GetChildren()

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
SPEED = 1 -- Default speed of the simulation

UpdateSpeedEvent.OnServerEvent:Connect(function(player, speedValue)
	SPEED = speedValue
end)

function runSimulation()
	while STATE do
		print("Simulation running...")
		local changes = {}
		for i, row in pairs(Cells) do
			for j, cell in pairs(row:GetChildren()) do

				local neighbors = getNeighbors(cell)
				if not neighbors then
					continue
				end

				local population = 0
				for _, neighbor in pairs(neighbors) do
					if getCellState(neighbor) then
						population += 1
					end
				end

				local cellState = getCellState(cell)
				if cellState then
					if population < 2 or population > 3 then
						changes[cell] = Color3.fromRGB(255, 255, 255) -- Cell dies (white)
					end
				else
					if population == 3 then
						changes[cell] = Color3.fromRGB(0, 0, 0) -- Cell becomes alive (black)
					end
				end
			end
		end
		task.wait(1/SPEED)
		for cell, newColor in pairs(changes) do
			cell.Color = newColor
		end
	end
end

function getCellState(cell)
	local cellState = false
	if cell.Color == Color3.fromRGB(0, 0, 0) then
		cellState = true
	end
	return cellState
end

function getNeighbors(cell)
	local row = cell.Parent
	local neighbors = {}

	if cell.Name == "1" or cell.Name == "64" then
		return -- Skip the first and last rows
	elseif row.Name == "1" or row.Name == "64" then
		return -- Skip the first and last columns
	else
		neighbors = {
			row:FindFirstChild(tostring(tonumber(cell.Name) + 1)), -- Right
			row:FindFirstChild(tostring(tonumber(cell.Name) - 1)), -- Left
			row.Parent:FindFirstChild(tostring(tonumber(row.Name) + 1)):FindFirstChild(cell.Name), -- Top
			row.Parent:FindFirstChild(tostring(tonumber(row.Name) - 1)):FindFirstChild(cell.Name), -- Bottom
			row.Parent:FindFirstChild(tostring(tonumber(row.Name) + 1)):FindFirstChild(tostring(tonumber(cell.Name) + 1)), -- Top Right
			row.Parent:FindFirstChild(tostring(tonumber(row.Name) + 1)):FindFirstChild(tostring(tonumber(cell.Name) - 1)), -- Top Left
			row.Parent:FindFirstChild(tostring(tonumber(row.Name) - 1)):FindFirstChild(tostring(tonumber(cell.Name) + 1)), -- Bottom Right
			row.Parent:FindFirstChild(tostring(tonumber(row.Name) - 1)):FindFirstChild(tostring(tonumber(cell.Name) - 1)), -- Bottom Left
		}
	end

	return neighbors
end