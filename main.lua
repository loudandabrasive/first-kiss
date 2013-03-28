require 'tile-maps'

local World = {}
local WorldObjects = {}
local PlayerSpeed = 100

function love.load()
	love.filesystem.load('field-map.lua')()
	loadPhysics()
	PlayerImage = love.graphics.newImage('assets/brave-hero.png')
	BoxImage = love.graphics.newImage('assets/countryside.png')
	BoxQuad = love.graphics.newQuad(32, 0, 32, 32, 64, 64) --hard coded
end

function loadPhysics()
	love.physics.setMeter(32) --32px / m
	World = love.physics.newWorld(0, 0, true)
	player = {}
	player.body = love.physics.newBody(World,64,64, "dynamic")
	player.shape = love.physics.newRectangleShape(32,32)
	player.fixture = love.physics.newFixture(player.body, player.shape, 1)
	
	box = {}
	box.body = love.physics.newBody(World,128,128, "static")
	box.shape = love.physics.newRectangleShape(32,32)
	box.fixture = love.physics.newFixture(box.body, box.shape, 1)
	
	WorldObjects.player = player
	WorldObjects.box = box
end

function love.draw()
	drawMap()
	love.graphics.draw(PlayerImage, WorldObjects.player.body:getX(), WorldObjects.player.body:getY(), 0, 0.5)
	love.graphics.drawq(BoxImage, BoxQuad, WorldObjects.box.body:getX(), WorldObjects.box.body:getY())
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