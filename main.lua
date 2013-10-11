require 'camera'
require 'box'

World = {}
local Boxes = {}
local PlayerSpeed = 100

local screenWidth = 0
local screenHeight = 0

function love.load()
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()

	love.physics.setMeter(32)
	World = love.physics.newWorld(0, 20, true)
	
	loadBodies()
	loadPlayer()
end

function loadBodies()
	floor = Box:create(0, screenHeight-100, screenWidth, 60)
    table.insert(Boxes, floor)

    for i = 1, 10 do
		local x = math.random(0, screenWidth  * 2)
		local y = math.random(100, screenHeight * 2)
		local width = math.random(100, 300)
		local height = math.random(100, 300)
		local envBox = Box:create(x,y,width,height)
		table.insert(Boxes, envBox)
	end
end

function loadPlayer()
	player = {}
	player.body = love.physics.newBody(World,64,64, "dynamic")
	player.shape = love.physics.newRectangleShape(30,30)
	player.fixture = love.physics.newFixture(player.body, player.shape, 0.65)
end

function drawPlayer()
	love.graphics.setColor( { 0, 255, 100 } )
	love.graphics.polygon("fill", player.body:getWorldPoints(player.shape:getPoints()))
end

function love.draw()
	camera:set()
	drawPlayer()
	for _, o in pairs(Boxes) do
    	o:draw()
  	end
	camera:unset()
end

function love.update(dt)
	World:update(dt)
	keyboardThePlayer()
	
	camera:setPosition(player.body:getX() - screenWidth/2, player.body:getY() - screenHeight/2)
end

function keyboardThePlayer()
   if love.keyboard.isDown("right") then
		player.body:applyForce(PlayerSpeed,0) 
   end
   if love.keyboard.isDown("left") then
		player.body:applyForce(-PlayerSpeed,0)
   end
   if love.keyboard.isDown("up") then
		player.body:applyForce(0,-PlayerSpeed)
   end
   if love.keyboard.isDown("down") then
		player.body:applyForce(0,PlayerSpeed)
   end
end