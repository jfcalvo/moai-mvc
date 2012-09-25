BlockController = {}
BlockController.__index = BlockController

function BlockController.new(block_model, block_view)
  local block_controller = {block_model = block_model,
                            block_view = block_view}
  setmetatable(block_controller, BlockController)

  return block_controller
end

function BlockController:touchCallback(eventType, idx, x, y, tapCount)
  if eventType == MOAITouchSensor.TOUCH_DOWN then 
    self:touchDownCallback(idx, x, y, tapCount)
  elseif eventType == MOAITouchSensor.TOUCH_UP then 
    self:touchUpCallback(idx, x, y, tapCount)
  elseif eventType == MOAITouchSensor.TOUCH_MOVE then
    self:touchMoveCallback(idx, x, y, tapCount)    
  end
end

function BlockController:touchDownCallback(idx, x, y, tapCount)
  local pick = partition:propForPoint(x, y)
  if pick == self.block_view then
    self.block_model:setPicked(true)
    self.block_model:setLocation(x, y)
    self.block_model:setScl(1.3, 1.3)
  end
end

function BlockController:touchUpCallback(idx, x, y, tapCount)
  self.block_model:setScl(1.0, 1.0)
  self.block_model:setPicked(false)
end

function BlockController:touchMoveCallback(idx, x, y, tapCount)
  if self.block_model:getPicked() == true then
    self.block_model:setLocation(x, y)
  end
end
