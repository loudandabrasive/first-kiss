require 'tile-maps'

World = {}
local WorldObjects = {}
local PlayerSpeed = 100

function love.load()
	loadPhysics()
	love.filesystem.load('maps.lua')()
	PlayerImage = love.graphics.newImage('assets/brave-hero.png')
end

function loadPhysics()
	love.physics.setMeter(32) --32px / m
	World = love.physics.newWorld(0, 0, true)
	player = {}
	player.body = love.physics.newBody(World,64,64, "dynamic")
	player.shape = love.physics.newRectangleShape(30,30)
	player.fixture = love.physics.newFixture(player.body, player.shape, 0.65)
	WorldObjects.player = player
end

function love.draw()
	drawMap()
	love.graphics.draw(PlayerImage, WorldObjects.player.body:getX(), WorldObjects.player.body:getY(), 0, 0.5)
end

function love.update(dt)
	World:update(dt)
	keyboardThePlayer()
end

function keyboardThePlayer()
   if love.keyboard.isDown("right") then
	WorldObjects.player.body:applyForce(PlayerSpeed,0) 
   end
   if love.keyboard.isDown("left") then
	WorldObjects.player.body:applyForce(-PlayerSpeed,0)
   end
   if love.keyboard.isDown("up") then
	WorldObjects.player.body:applyForce(0,-PlayerSpeed)
   end
   if love.keyboard.isDown("down") then
	WorldObjects.player.body:applyForce(0,PlayerSpeed)
   end
end