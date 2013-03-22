require 'tile-maps'

Player = {}


function love.load()
	love.filesystem.load('field-map.lua')()
	Player = {love.graphics.newImage('assets/brave-hero.png'),0,0}
end

function love.draw()
	drawMap()
	love.graphics.draw(Player[1], Player[2], Player[3], 0, 0.5)
end

function love.keypressed( key )
   if key == "right" then
		Player[2] = Player[2] + 32
   end
   if key == "left" then
		Player[2] = Player[2] - 32
   end
   if key == "up" then
		Player[3] = Player[3] - 32
   end
   if key == "down" then
		Player[3] = Player[3] + 32
   end
end