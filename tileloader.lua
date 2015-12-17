local TileLoader = {}

local tempBoxes = {}

local tiles = {}

function TileLoader:make(newMain)
  main = newMain
end

function TileLoader:addBox (Image, X, Y)
  return {image = Image, x = X, y = Y, width = 32, height = 32}
end

function TileLoader:addTile(r, g, b, image, collidable)
  table.insert(tiles, {r = r, g = g, b = b, image = image, width = 32, height = 32, isCollidable = collidable})
end

function TileLoader:loadFromImage(imageData)
  for x=1,imageData:getWidth() do
    for y=1,imageData:getHeight() do
      for i=1, table.getn(tiles) do
        r, g, b, a = imageData:getPixel(x-1, y-1)
        if r == tiles[i].r and g == tiles[i].g and b == tiles[i].b then
          table.insert(tempBoxes, {image = tiles[i].image, x = x*32-32, y = y*32-32, width = 32, height = 32, isCollidable = tiles[i].isCollidable})
        end
      end
    end
  end
  return tempBoxes, imageData:getHeight() * 32 + 400
end

return TileLoader
