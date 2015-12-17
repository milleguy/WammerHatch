local Player = require "player"

function love.load()
  player = Player:make(100, 100)
  colliders = {{x=0,y=0,width=32,height=32,isCollidable=true}}
  player:load()
end

function love.update(dt)
  player:update(dt)
end

function love.draw()
  player:draw()
end
