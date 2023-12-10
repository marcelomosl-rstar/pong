WINDOW_WIDTH = 1000
WINDOW_HEIGHT = 600

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


PADDLE_SPEED = 200

Class = require 'class'

require 'Paddle'
require 'Ball'

push = require 'push'




function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    retroSmallFont = love.graphics.newFont('font.ttf', 8)

    retroLargeFont = love.graphics.newFont('font.ttf', 32)

    love.graphics.setFont(retroSmallFont)



    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })




    -- love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    --     fullscreen = false,
    --     resizable = false,
    --     vsync = true
    -- })


    player1Score = 0
    player2Score = 0

    
    player1 =  Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)


    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    gameState = 'start'

end

function love.update(dt)

    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)

end



local enterPressed = false

function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    end

    if key == 'return' or key == 'enter' then
       if gameState == 'start' then
        gameState = 'play'
        elseif gameState == 'play' then
            gameState = 'start'


            ball:reset()
       end

    end
end


function love.draw()


    push:apply("start")

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    if enterPressed then
        love.graphics.setFont(retroSmallFont)
        love.graphics.printf("Marcelo Mosl",
            0,
            VIRTUAL_HEIGHT / 2 - 20,
            VIRTUAL_WIDTH,
            "center"
        )
    end

    love.graphics.setFont(retroSmallFont)
    love.graphics.printf("Pong - Marcelo Mosl",
    0, 
    VIRTUAL_HEIGHT / 2 -120,
    VIRTUAL_WIDTH,
    "center")


    love.graphics.setFont(retroLargeFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, 
    VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, 
    VIRTUAL_HEIGHT / 3)




     player1:render()
     player2:render()
 
     ball:render()
 

    push:apply("end")
end