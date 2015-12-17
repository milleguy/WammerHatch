local Camera = require "camera"

local LevelEditor  = {boxes = {},tiles = {},oldX=0,oldY=0, hasLoaded = false, selID}

local selTile = 1

function LevelEditor:load()
  camera = Camera:make(0, 0, 1, 1, 0)
end

function LevelEditor:update()
  if love.mouse.isDown("l") then
    if love.mouse.getY() > 32 and camera:mouseX()>0 and camera:mouseY()>0 then
      for i, v in ipairs(self.boxes) do
        tempX, tempY = camera:mousePosition()
        tempX = (tempX-tempX%32)
        tempY = (tempY-tempY%32)
        if tempX == v.x and tempY == v.y then
          table.remove(self.boxes, i)
        end
      end
      table.insert(self.boxes, {image = self.tiles[selTile].image, x = camera:mouseX()-camera:mouseX()%32, y = camera:mouseY()-camera:mouseY()%32, width = self.tiles[selTile].width, height = self.tiles[selTile].height, isCollidable = self.tiles[selTile].isCollidable, r=self.tiles[selTile].r, g=self.tiles[selTile].g, b=self.tiles[selTile].b, a=self.selID})
    end
  elseif love.mouse.isDown("r") then
    if love.mouse.getY() > 32 then
      tempX, tempY = camera:mousePosition()
      tempX = (tempX-tempX%32)
      tempY = (tempY-tempY%32)
      for i, v in ipairs(self.boxes) do
        if tempX == v.x and tempY == v.y then
          table.remove(self.boxes, i)
        end
      end
    end
  elseif love.mouse.isDown("m") then
    camera:move((self.oldX-love.mouse.getX()) * camera.scaleX, (self.oldY-love.mouse.getY()) * camera.scaleY)
  end
  self.oldX = love.mouse.getX()
  self.oldY = love.mouse.getY()
end

function LevelEditor:draw()
  camera:set()
  love.graphics.setBackgroundColor(255, 255, 255)
  love.graphics.setColor(0, 0, 0, 122)
  for i=0, love.graphics.getWidth()*camera.scaleX+camera.x, 32 do
    love.graphics.line(i, 0+camera.y, i, love.window.getHeight()*camera.scaleY+camera.y)
  end
  for i=0, love.graphics.getHeight()*camera.scaleY+camera.y, 32 do
    love.graphics.line(0+camera.x, i, love.window.getWidth()*camera.scaleX+camera.x, i)
  end
  love.graphics.setColor(255, 255, 255, 255)
  for i,v in ipairs(self.boxes) do
    love.graphics.draw(v.image, v.x, v.y, 0)
  end
  love.graphics.setColor(255, 120, 255, 200)

  love.graphics.draw(self.tiles[selTile].image, camera:mouseX()-camera:mouseX()%32, camera:mouseY()-camera:mouseY()%32)

  camera:unset()
  --love.graphics.setColor(90, 90, 90)
  --love.graphics.rectangle("fill", 0, 0, love.window:getWidth(), 32)
  --love.graphics.setColor(100, 100, 100)
  --love.graphics.rectangle("fill", 0, 0, love.window:getWidth(), 28)
  --love.graphics.setColor(255, 255, 255)
end

function LevelEditor:mousepressed(x,y,button)
  maxScale = 10
  minScale = 0.1
  currentScale = 1
  if button == "wu" then
    currentScale = currentScale - 0.04
  elseif button == "wd" then
    currentScale = currentScale + 0.04
  end
  if currentScale > maxScale then
    currentScale = maxScale
  end
  if currentScale < minScale then
    currentScale = minScale
  end
  camera:scale(currentScale, currentScale)
end

function LevelEditor:addTile(r, g, b, image, collidable)
  table.insert(self.tiles, {r=r, g=g, b=b, image = image, width = 32, height = 32, isCollidable = collidable})
end

function LevelEditor:saveMap()
  maxX, maxY = 1,1
  for i,v in ipairs(self.boxes) do
    if v.x/32>maxX then
      maxX = v.x/32
    end
    if v.y/32>maxY then
      maxY = v.y/32
    end
  end
  tempLevel = love.image.newImageData(maxX+1, maxY+1)
  for i,v in ipairs(self.boxes) do
    tempLevel:setPixel(v.x/32, v.y/32, v.r, v.g, v.b, v.a)
  end
  if not love.filesystem.exists("Maps") then
    love.filesystem.createDirectory("Maps")
  end
  tempLevel:encode("Maps/Map".. os.time() .. ".png")
end

function LevelEditor:loadMap(imageData)
  tempBoxes = {}
  for x=1,imageData:getWidth() do
    for y=1,imageData:getHeight() do
      for i=1, table.getn(self.tiles) do
        r, g, b, a = imageData:getPixel(x-1, y-1)
        if r == self.tiles[i].r and g == self.tiles[i].g and b == self.tiles[i].b then
          table.insert(tempBoxes, {image = self.tiles[i].image, x = x*32-32, y = y*32-32, width = 32, height = 32, isCollidable = self.tiles[i].isCollidable, r=r, g=g, b=b, a=a})
        end
      end
    end
  end
  self.boxes = tempBoxes
end

return LevelEditor
