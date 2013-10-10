require 'camera'

World = {}
local WorldObjects = {}
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
	floor = {}
	floor.body = love.physics.newBody(World,0,screenHeight-100,"static")
	floor.shape = love.physics.newRectangleShape(screenWidth,60)
	floor.fixture = love.physics.newFixture(floor.body, floor.shape)
    table.insert(WorldObjects, floor)

    for i = 1, 10 do
		x = math.random(0, screenWidth  * 2)
		y = math.random(100, screenHeight * 2)
		width = math.random(100, 300)
		height = math.random(100, 300)
		envBox = {}
		envBox.body = love.physics.newBody(World,x,y,"static")
		envBox.shape = love.physics.newRectangleShape(width,height)
		envBox.fixture = love.physics.newFixture(envBox.body, envBox.shape)
		table.insert(WorldObjects, envBox)
	end
end

function loadPlayer()
	player = {}
	player.body = love.physics.newBody(World,64,64, "dynamic")
	player.shape = love.physics.newRectangleShape(30,30)
	player.fixture = love.physics.newFixture(player.body, player.shape, 0.65)
	WorldObjects.player = player
end

function love.draw()
	camera:set()
	love.graphics.setColor( { 255, 255, 255 } )
	for _, o in pairs(WorldObjects) do
    love.graphics.polygon("fill", o.body:getWorldPoints(o.shape:getPoints()))
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