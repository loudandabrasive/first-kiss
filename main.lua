require 'tile-maps'

local World = {}
local WorldObjects = {}
local PlayerSpeed = 300

function love.load()
	love.filesystem.load('field-map.lua')()
	loadPhysics()
	PlayerImage = love.graphics.newImage('assets/brave-hero.png')
end

function loadPhysics()
	love.physics.setMeter(32) --32px / m
	World = love.physics.newWorld(0, 0, true)
	player = {}
	player.body = love.physics.newBody(World,64,64, "dynamic")
	player.shape = love.physics.newRectangleShape(32,32)
	player.fixture = love.physics.newFixture(player.body, player.shape, 1)
	
	WorldObjects.player = player
end

function love.draw()
	drawMap()
	love.graphics.draw(PlayerImage, WorldObjects.player.body:getX(), WorldObjects.player.body:getY(), 0, 0.5)
end

function love.update(dt)
	World:update(dt)
end

function love.keypressed( key )
   if key == "right" then
	WorldObjects.player.body:applyForce(PlayerSpeed,0) 
   end
   if key == "left" then
	WorldObjects.player.body:applyForce(-PlayerSpeed,0)
   end
   if key == "up" then
	WorldObjects.player.body:applyForce(0,-PlayerSpeed)
   end
   if key == "down" then
	WorldObjects.player.body:applyForce(0,PlayerSpeed)
   end
end