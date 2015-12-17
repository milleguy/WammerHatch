local BoxCollider = require "boxcollider"
local Collison = {}

function Collison:make(startX, startY, width, height)

  collider = {x = startX, y = startY, oldX = startX, oldY = startY, width = width, height = height, isCollidable = true}

  function collider:update(x, y, colliders, width, height)
    --self.grounded = false

    for i, v in ipairs(colliders) do
      --if BoxCollider:botTouching(self,v) and math.abs(v.x-collider.oldX) < math.abs(v.y-collider.oldY) then
      --  self.grounded = true
      --end
      if BoxCollider:touching(self, v) then
        if math.abs(v.x-collider.oldX) < math.abs(v.y-collider.oldY) then
          if v.y-collider.oldY < 0 then
            collider.y = v.y+v.height
            --top
          else
            collider.y = v.y-collider.height
            --bot
          end
        elseif math.abs(v.x-collider.oldX) > math.abs(v.y-collider.oldY) then
          if v.x-collider.oldX < 0 then
            collider.x = v.x+v.width
            --left
          else
            collider.x = v.x-collider.width
            --right
          end
        end
      end
    end
  end
  return collider
end

return Collison
