
TileSet = {}
QuadConfig = {} -- { char, x, y }
GameTilesMap = {}
TileSize = 32

function love.load()
	TileSetImage = love.graphics.newImage('assets/countryside.png');
	
	QuadConfig = {	
		{' ',  0,  0 }, -- 1 = grass 
		{'#', 32,  0 }, -- 2 = box
		{'f',  0, 32 }, -- 3 = flowers
		{'X', 32, 32 }  -- 4 = boxTop
	}

	local tileSetWidth = TileSetImage:getWidth()
	local tileSetHeight = TileSetImage:getHeight()
	
	for _,tile in ipairs(QuadConfig) do
		TileSet[tile[1]] = love.graphics.newQuad(tile[2], tile[3], TileSize, TileSize, tileSetWidth, tileSetHeight)
	end
	
	local charMap = [[
X#######################X
X        f              X
X                f      X
X    #    #   f    ff   X
X          XX#          X
X          ##   f       X
X                  f#   X
X          #            X
X                       X
X    f     X            X
X    f     #            X
X                       X
X          #            X
X                       X
X    f          #     X X
X      #   f        X # X
X       f        f  X   X
X           f    f  #   X
#########################
]]
	
	parseMap(charMap, GameTilesMap)
	
end

function love.draw()
	for c,column in pairs(GameTilesMap) do
		for r,char in pairs(column) do
			local x,y = (c-1)*TileSize, (r-1)*TileSize
			love.graphics.print(char, x, y)
			love.graphics.drawq(TileSetImage, TileSet[char], x, y)
		end
	end
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