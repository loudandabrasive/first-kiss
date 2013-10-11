require 'entity'

Player = Entity:new()

function Player:init()
	local player = Player:new()
	player.speed = 100
	player.body = love.physics.newBody(World,64,64, "dynamic")
	player.shape = love.physics.newRectangleShape(30,30)
	player.fixture = love.physics.newFixture(player.body, player.shape, 0.65)

	return player
end

function Player:draw()
	love.graphics.setColor( { 0, 255, 100 } )
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end

function Player:update(dt)
	self:updateInput()
end


function Player:updateInput()
   if love.keyboard.isDown("right") then
		self.body:applyForce(self.speed,0) 
   end
   if love.keyboard.isDown("left") then
		self.body:applyForce(-self.speed,0)
   end
   if love.keyboard.isDown("up") then
		self.body:applyForce(0,-self.speed)
   end
   if love.keyboard.isDown("down") then
		self.body:applyForce(0,self.speed)
   end
end