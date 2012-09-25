BlockView = {}
BlockView.__index = BlockView

function BlockView.new()
  local block_view = MOAIProp2D.new()

  block_view:setDeck(gfxQuad)
  block_view:setLoc(0, 0)
  block_view:setScl(0.8, 0.8)

  layer:insertProp(block_view)

  function block_view:update(x, y)
    -- Here we receive block model changes
    print('Model changed to: ', x, y)
    self:setLoc(x, y)
  end

  return block_view
end
