require 'tile-maps'


function love.load()
	love.filesystem.load('field-map.lua')()
end

function love.draw()
	drawMap()
end