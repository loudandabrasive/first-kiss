local TileSize = 0
local TileSetImage = {}
local TileSet = {}
local GameTilesMap = {}

function newMap(tileSize, tileSetPath, mapString, quadConfig)
	TileSize = tileSize
	TileSetImage = love.graphics.newImage(tileSetPath);
	
	local tileSetWidth = TileSetImage:getWidth()
	local tileSetHeight = TileSetImage:getHeight()
	
	for _,tile in ipairs(quadConfig) do
		TileSet[tile[1]] = love.graphics.newQuad(tile[2], tile[3], tileSize, tileSize, tileSetWidth, tileSetHeight)
	end
	
	parseMap(mapString, GameTilesMap)
end

function parseMap(mapString, tileTable)
	local width = #(mapString:match("[^\n]+"))
	
	for rows = 1,width do tileTable[rows] = {} end

	local r,c = 1,1
	for row in mapString:gmatch("[^\n]+") do
		assert(#row == width, 'Map is not aligned: row ' .. tostring(r) .. ' expected ' .. tostring(width) .. ', actually is ' .. tostring(#row))
		c = 1
		for character in row:gmatch(".") do
			tileTable[c][r] = character
			c = c+1
		end
		r = r+1
	end
end

function drawMap()
	for c,column in pairs(GameTilesMap) do
		for r,char in pairs(column) do
			local x,y = (c-1)*TileSize, (r-1)*TileSize
			love.graphics.print(char, x, y)
			love.graphics.drawq(TileSetImage, TileSet[char], x, y)
		end
	end
end