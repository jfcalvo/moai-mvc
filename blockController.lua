BlockController = {}
BlockController.__index = BlockController

function BlockController.new(block)
  local block_controller = {block = block}
  setmetatable(block_controller, BlockController)

  return block_controller
end

function BlockController:touchCallback(eventType, idx, x, y, tapCount)
  self.block:setLocation(x, y)
end
