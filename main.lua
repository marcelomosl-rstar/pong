WINDOW_WIDTH = 1270 
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

push = require 'push'




function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')



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

function love.keypressed(key)
    -- keys can be accessed by string name
    if key == 'escape' then
        -- function LÖVE gives us to terminate application
        love.event.quit()
    end
end





function love.draw()


    push:apply("start")


    love.graphics.printf("Pong Virtual Dimensions", 
    0, 
    VIRTUAL_HEIGHT / 2 -6, 
    VIRTUAL_WIDTH, 
    "center")

    push:apply("end")
end