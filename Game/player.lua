local Collision = require "collision"

Player = {}

function Player:make (x, y)
  player = {x=x, y=y, width=32, height=32, velX=0, velY=0, acc = 40, fric = 10}

  function player:load(colliders)
    self.collider = Collision:make(self.x, self.y, self.height, self.width)
  end

  function player:update(dt)

    self.oldX = self.x
    self.oldY = self.y

    if love.keyboard.isDown("w") then
      self.velY = self.velY - self.acc * dt
    end
    if love.keyboard.isDown("s") then
      self.velY = self.velY + self.acc * dt
    end
    if love.keyboard.isDown("a") then
      self.velX = self.velX - self.acc * dt
    end
    if love.keyboard.isDown("d") then
      self.velX = self.velX + self.acc * dt
    end
    self.x = self.x + self.velX
    self.y = self.y + self.velY

    self.velX = self.velX - (self.velX*self.fric*dt)
    self.velY = self.velY - (self.velY*self.fric*dt)

    collider:update(self, colliders)
    player.x = collider.x
    player.y = collider.y
  end

  function player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  end

  return player
end

return Player
