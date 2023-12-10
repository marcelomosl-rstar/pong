Paddle = Class{}

function Paddle:init(xAxis, yAxis, width, height)
    self.xAxis = xAxis
    self.yAxis = yAxis
    self.width = width
    self.height = height
    self.dy = 0
end

function Paddle:update(dt)

    if self.dy < 0 then
        self.yAxis = math.max(0, self.yAxis + self.dy * dt)
    else
        self.yAxis = math.min(VIRTUAL_HEIGHT - self.height, self.yAxis + self.dy * dt)
    end

end

function Paddle:render()
    love.graphics.rectangle('fill',self.xAxis, self.yAxis, self.width, self.height)
end