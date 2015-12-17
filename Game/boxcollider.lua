--[[
  Defines behavior of the box colliders.
]]--
local BoxCollider = {}

function BoxCollider:make(positionX, positionY, width, height, collidable)
  newbox = {}
  newbox.x = positionX
  newbox.y = positionY
  newbox.isCollidable = collidable

  newbox.width = width
  newbox.height = height

  return newbox
end

function BoxCollider:touching(box1, box2)
  return box1.x < box2.x + box2.width and
         box2.x < box1.x + box1.width and
         box1.y < box2.y + box2.height and
         box2.y < box1.y + box1.height and
         box1.isCollidable and box2.isCollidable
end

function BoxCollider:botTouching(box1, box2)
  return box1.x < box2.x + box2.width and
         box2.x < box1.x + box1.width and
         box1.y < box2.y + box2.height and
         box2.y <= box1.y + box1.height and
         box1.isCollidable and box2.isCollidable
end
return BoxCollider
