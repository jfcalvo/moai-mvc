BlockModel = {}
BlockModel.__index = BlockModel

function BlockModel.new(x, y)
  local block_model = {state = false,
                       observers = {},
                       x = x,
                       y = y,
                       xScl = 1,
                       yScl = 1,
                       picked = false}
  setmetatable(block_model, BlockModel)

  return block_model
end

function BlockModel:getChanged()
  return self.state
end

function BlockModel:setChanged(state)
  self.state = state
end

function BlockModel:addObserver(observer)
  table.insert(self.observers, observer)
end

function BlockModel:deleteObserver(observer)
  for i, v in ipairs(self.observers) do
    if v == observer then
      table.remove(self.observers, i)
    end
  end
end

function BlockModel:notifyObservers()
  if self:getChanged() == true then
    for i, observer in ipairs(self.observers) do
      observer:update(self.x, self.y, self.xScl, self.yScl)
    end
    self:setChanged(false)
  end
end

--

function BlockModel:getPicked()
  return self.picked
end

function BlockModel:setPicked(state)
  self.picked = state
end

function BlockModel:setLocation(x, y)
  if x ~= self.x or y ~= self.y then
    self.x, self.y = x, y
    self:setChanged(true)
    self:notifyObservers()
  end
end

function BlockModel:setScl(xScl, yScl)
  if xScl ~= self.xScl or yScl ~= yScl then
    self.xScl, self.yScl = xScl, yScl
    self:setChanged(true)
    self:notifyObservers()
  end
end
