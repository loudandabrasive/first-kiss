require 'entity'

Box = Entity:new({
	x = 0,
	y = 0,
	width =0,
	height =0
})

function Box:create(x, y, width, height)
	box = Box:new()
	box.x = x;	box.y = y
	box.width = width;
	box.height = height

	box.body = love.physics.newBody(World,x,y,"static")
	box.shape = love.physics.newRectangleShape(width,height)
	box.fixture = love.physics.newFixture(box.body, box.shape)

	return box
end

function Box:draw()
	love.graphics.setColor( { 255, 255, 255 } )
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end