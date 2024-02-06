-- Credits to uTrain https://github.com/u-train

local fs = require("@lune/fs")
local serde = require("@lune/serde")
local roblox = require("@lune/roblox")
local process = require("@lune/process")


local function mergeStudMap(unmergedMap)
	-- This is a list of chunks.
	-- A chunk is defined with (x1, y1), (x2, y2), depth, and color.
	local mergedMap = {}

	-- We need to first keep track of all the studs that have been merged.
	-- We don't want to merge a stud more than once.
	local hits = {}

	local function markAsHit(x, y)
		if hits[y] == nil then
			hits[y] = {}
		end

		hits[y][x] = true
	end

	local function wasHit(x, y)
		return hits[y] and hits[y][x]
	end

	for y = 1, #unmergedMap do
		for x = 1, #unmergedMap[y] do
			-- If it was already merged, then don't do anything.
			if wasHit(x, y) then
				continue
			end

			-- Save the starting position of this new chunk.
			local startingX = x
			local startingY = y

			-- What we're merging.
			local markedDepth = unmergedMap[y][x].d
			local markedColor = unmergedMap[y][x].h

			-- This algorithm works incrementally. We start merging across the x-axis. Then across the y-axis.
			local endingX = x
			local endingY = y

			-- Start across the X
			while
				-- Bounds check here.
				endingX + 1 <= #unmergedMap[endingY]

				-- We cap the size of each chunk to adhere to Roblox's limits.
				and startingX - (endingX + 1) < 2048

				-- Make sure the next stud over have matching properties.
				and unmergedMap[endingY][endingX + 1].d == markedDepth
				and unmergedMap[endingY][endingX + 1].h == markedColor

				-- Make sure that the next stud wasn't already merged.
				and not wasHit(endingX + 1, endingY)
			do
				-- Merge the stud in.
				endingX += 1
			end

			-- Then let's go across the Y.
			while endingY + 1 <= #unmergedMap do
				-- We must check every new row to make sure it all matches.
				-- Let's assume optimistically that it does.
				local matchingRow = true

				for rowX = startingX, endingX do
					local row = unmergedMap[endingY + 1]

					if
						row == nil
						or row[rowX].d ~= markedDepth
						or row[rowX].h ~= markedColor
						or wasHit(rowX, endingY + 1)
						or startingY - (endingY + 1) => 2048
					then
						matchingRow = false
						break
					end
				end

				if matchingRow then
					endingY += 1
				else
					break
				end
			end

			for localX = startingX, endingX do
				for localY = startingY, endingY do
					markAsHit(localX, localY)
				end
			end

			table.insert(mergedMap, {
				x1 = startingX,
				y1 = startingY,
				x2 = endingX,
				y2 = endingY,
				d = markedDepth,
				h = markedColor,
			})
		end
	end
	
	return mergedMap
end

local function map(x, x1, x2, y1, y2)
	assert(x >= x1, "x is less than the lower bound x1")
	assert(x <= x2, "x is higher than the upper bound x2")
	return (((x - x1) / math.abs(x1 - x2)) * math.abs(y1 - y2)) + y1
end

local function round(v, bracket)
	bracket = bracket or 1
	return math.floor(v / bracket + math.sign(v) * 0.5) * bracket
end
--Not in use due to it ruining colors when generated -Tuna
local function convertCompressedHex(hex)
	local r = hex:sub(2, 3)
	local g = hex:sub(4, 5)
	local b = hex:sub(6, 7)
	return roblox.Color3.new(tonumber(r, 16) / 255, tonumber(g, 16) / 255, tonumber(b, 16) / 255)
end

local sourcePath = process.args[1]
assert(sourcePath, "Missing singular argument, path to a json file.")

local mergedStudMap = mergeStudMap(serde.decode("json", fs.readFile(sourcePath)))
print(#mergedStudMap)

local game = roblox.Instance.new("DataModel")
local workspace = game:GetService("Workspace")

local root = roblox.Instance.new("Model")
root.Parent = workspace
root.Name = "Map"
local Enum = roblox.Enum

local scriptIns = roblox.Instance.new("Script")

scriptIns.Source = [[
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
    -- Wait for the player's character to load
    player.CharacterAdded:Connect(function(character)
        -- Set the player's walk speed
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = 70
    end)
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 70
        end
    end
end
]]
scriptIns.Name = "Script"
scriptIns.Parent = workspace

local spawnPlate = roblox.Instance.new("SpawnLocation")
spawnPlate.Name = "Spawn"
spawnPlate.Parent = workspace
spawnPlate.CFrame = roblox.CFrame.new(529, 27.4, 221.2)

for _, run in mergedStudMap do
	local part = roblox.Instance.new("Part")
	part.Color = convertCompressedHex(run.h)
	local mappedHeight = round(map(run.d, 0, 255, 1, 25), 0.5)
	local width = run.x2 - run.x1 + 1
	local height = run.y2 - run.y1 + 1

	part.Size = roblox.Vector3.new(width, mappedHeight, height)
	part.CFrame = roblox.CFrame.new(run.x1 + width / 2, mappedHeight / 2, run.y1 + height / 2)
	part.Parent = root
	part.Anchored = true
	part.TopSurface = Enum.SurfaceType.Smooth
	part.Material = Enum.Material.Concrete
end

print(process.cwd)
local placeFile = roblox.serializePlace(game)
fs.writeFile(process.args[2], placeFile)
-- Same issue with Main2.py, where it tried to double connect to main because main was selected, so I removed main/ -Tuna
-- I hate this, why isnt there any getDir or getFile? I have to build my own Lune version... -Tuna
