require 'camera'
require 'box'
require 'player'

World = {}
local Boxes = {}
local player = {}

local screenWidth = 0
local screenHeight = 0

function love.load()
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()

	love.physics.setMeter(32)
	World = love.physics.newWorld(0, 20, true)
	
	player = Player:init()
	loadBodies()
end

function loadBodies()
	local floor = Box:create(0, screenHeight-100, screenWidth, 60)
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

function love.draw()
	camera:set()
	player:draw()
	for _, o in pairs(Boxes) do
    	o:draw()
  	end
	camera:unset()
end

function love.update(dt)
	World:update(dt)
	player:update(dt)
	
	camera:setPosition(player.body:getX() - screenWidth/2, player.body:getY() - screenHeight/2)
end