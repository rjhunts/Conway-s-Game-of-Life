local cells = workspace:WaitForChild("Cells"):GetChildren()

for i, row in pairs(cells) do
    for j, cell in pairs(row:GetChildren()) do
        cell.AddTag("Cell")
    end
end