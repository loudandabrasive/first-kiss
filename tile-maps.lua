local TileSize = 0
local TileSetImage = {}
local TileChars = {}
local MapToDraw = {}

function newMap(tileSize, tileSetPath, drawString, objectString, quadConfig)
	TileSize = tileSize
	TileSetImage = love.graphics.newImage(tileSetPath);
	
	local tileSetWidth = TileSetImage:getWidth()
	local tileSetHeight = TileSetImage:getHeight()
	
	for _,tile in ipairs(quadConfig) do
		TileChars[tile[1]] = love.graphics.newQuad(tile[2], tile[3], tileSize, tileSize, tileSetWidth, tileSetHeight)
	end
	
	local objectMap = {}
	parseMap(objectString, objectMap)
	loadObjects(objectMap)
	parseMap(drawString, MapToDraw)
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

function loadObjects(objectMap)
	for c,column in pairs(objectMap) do
		for r,char in pairs(column) do
			if(char == '#' or char == 'X') then
				local x,y = (c-1)*TileSize, (r-1)*TileSize
				local box = {}
				box.body = love.physics.newBody(World,x,y, "static")
				box.shape = love.physics.newRectangleShape(TileSize,TileSize)
				box.fixture = love.physics.newFixture(box.body, box.shape, 1)
			end
		end
	end
end

function drawMap()
	for c,column in pairs(MapToDraw) do
		for r,char in pairs(column) do
			local x,y = (c-1)*TileSize, (r-1)*TileSize
			love.graphics.drawq(TileSetImage, TileChars[char], x, y)
			--love.graphics.print(char, x, y)
		end
	end
end