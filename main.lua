WINDOW_WIDTH = 1270 
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

push = require 'push'




function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    retroSmallFont = love.graphics.newFont('font.ttf', 8)

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
end

local enterPressed = false


function love.keypressed(key)
    -- keys can be accessed by string name
    if key == 'escape' then
        -- function LÖVE gives us to terminate application
        love.event.quit()
    end

    if key == 'return' then  -- 'return' is the correct name for the enter key
        enterPressed = not enterPressed
    end
end





function love.draw()


    push:apply("start")

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    if enterPressed then
        love.graphics.printf("Marcelo Mosl", 
            0, 
            VIRTUAL_HEIGHT / 2 - 20, 
            VIRTUAL_WIDTH, 
            "center"
        )
    end


    love.graphics.printf("Pong Virtual Dimensions", 
    0, 
    VIRTUAL_HEIGHT / 2 -120, 
    VIRTUAL_WIDTH, 
    "center")


    -- settings order mode, positionX, positionY, width, height
    -- LEFT
    love.graphics.rectangle("fill" , 5, 30, 5, 20)


    --RIGTH
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)

    -- render ball (center)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    push:apply("end")
end