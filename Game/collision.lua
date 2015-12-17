local BoxCollider = require "boxcollider"
local Collison = {}

function Collison:make(startX, startY, width, height)

  collider = {x = startX, y = startY, oldX = startX, oldY = startY, width = width, height = height, isCollidable = true}

  function collider:update(player, colliders)
    self.x = player.x
    self.y = player.y
    self.oldX = player.oldX
    self.oldY = player.oldY
    self.width = player.width
    self.height = player.height

    for i, v in ipairs(colliders) do
      if BoxCollider:touching(self, v) then
        if math.abs(v.x-collider.oldX) < math.abs(v.y-collider.oldY) then
          if v.y-collider.oldY < 0 then
            collider.y = v.y+v.height
            self.velY = 0
            --top
          else
            collider.y = v.y-collider.height
            self.velY = 0
            --bot
          end
        elseif math.abs(v.x-collider.oldX) > math.abs(v.y-collider.oldY) then
          if v.x-collider.oldX < 0 then
            collider.x = v.x+v.width
            self.velX = 0
            --left
          else
            collider.x = v.x-collider.width
            self.velX = 0
            --right
          end
        end
      end
    end
  end
  return collider
end

return Collison
