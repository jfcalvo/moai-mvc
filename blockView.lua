BlockView = {}
BlockView.__index = BlockView

function BlockView.new()
  local block_view = MOAIProp2D.new()

  block_view:setDeck(gfxQuad)
  block_view:setLoc(0, 0)
  block_view:setScl(0.8, 0.8)

  partition:insertProp(block_view)

  layer:insertProp(block_view)

  function block_view:update(x, y, xScl, yScl)
    -- Here we receive block model changes
    self:setLoc(x, y)
    self:setScl(xScl, yScl)
  end

  return block_view
end
