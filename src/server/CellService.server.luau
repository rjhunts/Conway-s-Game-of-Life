local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpdateCellEvent = ReplicatedStorage:WaitForChild("UpdateCellEvent")

UpdateCellEvent.OnServerEvent:Connect(function(player, cell)
    checkCell(cell)
end)

function checkCell(cell)

	local white = Color3.fromRGB(255, 255, 255)
	local black = Color3.fromRGB(0, 0, 0)

	if cell.Color == white then
		cell.Color = black -- Change cell to black
	else
		cell.Color = white -- Change cell to white
	end
end