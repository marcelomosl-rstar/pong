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


    servingPlayer = 1

    player1 = Paddle(10, 30, 5, 20)
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

        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.xAxis = player1.xAxis + 5


            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.xAxis = player2.xAxis - 4

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        if ball.yAxis <= 0 then
            ball.yAxis = 0
            ball.dy = -ball.dy
        end

        if ball.yAxis >= VIRTUAL_HEIGHT - 4 then
            ball.yAxis = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy
        end

        if ball.xAxis < 0 then
            servingPlayer = 1
            player2Score = player2Score + 1
            ball:reset()

            if player2Score == 10 then
                winningPlayer = 2
                gameState = 'done'
            else
                gameState = 'serve'
                -- places the ball in the middle of the screen, no velocity
                ball:reset()
            end
        end

        if ball.xAxis > VIRTUAL_WIDTH then
            servingPlayer = 2
            player1Score = player1Score + 1
            ball:reset()

            if player1Score == 10 then
                winningPlayer = 1
                gameState = 'done'
            else
                gameState = 'serve'
                -- places the ball in the middle of the screen, no velocity
                ball:reset()
            end
        end
    elseif gameState == 'serve' then
        ball.dy = math.random(-50, 50)
        if servingPlayer == 1 then
            ball.dx = math.random(140, 200)
        else
            ball.dx = -math.random(140, 200)
        end
    end

    player1:update(dt)
    player2:update(dt)
end

local mPressed = false

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'serve'
        elseif gameState == 'serve' then
            gameState = 'play'
        elseif gameState == 'done' then
            if player1Score == 10 then
                servingPlayer = 1
            else
                servingPlayer = 2
            end

            player1Score = 0
            player2Score = 0


            gameState = 'serve'
        end
    elseif key == 'm' then
        mPressed = not mPressed
    end
end

function love.draw()
    push:apply("start")

    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    if mPressed then
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
        VIRTUAL_HEIGHT / 2 - 120,
        VIRTUAL_WIDTH,
        "center")


    love.graphics.setFont(retroLargeFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)

    if gameState == 'done' then
        love.graphics.setFont(retroSmallFont)
        love.graphics.printf('Player ' .. tostring(winningPlayer) .. ' wins!',
            0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(retroSmallFont)
        love.graphics.printf('Press Enter to restart!', 0, 30, VIRTUAL_WIDTH, 'center')
    end





    player1:render()

    player2:render()

    ball:render()

    displayFPS()


    push:apply("end")
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(retroSmallFont)
    love.graphics.setColor(0, 255 / 255, 0, 255 / 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
