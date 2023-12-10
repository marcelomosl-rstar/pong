Ball = Class{}


function Ball:init(xAxis, yAxis, width, height)

    self.xAxis = xAxis
    self.yAxis = yAxis
    self.width = width
    self.height = height

    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end


function Ball:reset()
    self.xAxis = VIRTUAL_WIDTH / 2 - 2
    self.yAxis = VIRTUAL_HEIGHT / 2 - 2

    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50) *1.5
end

function Ball:update(dt)
    self.xAxis = self.xAxis + self.dx * dt
    self.yAxis = self.yAxis + self.dy * dt
end

function Ball:render()
   love.graphics.rectangle('fill', self.xAxis, self.yAxis, self.width, self.height)
end