require 'blockModel'
require 'blockView'
require 'blockController'

if MOAIEnvironment.osBrand == "iOS" then
  SIZE_WIDTH = 640
  SIZE_HEIGHT = 960
else
  SIZE_WIDTH = 320
  SIZE_HEIGHT = 480
end

SCALE_SIZE_WIDTH = 320
SCALE_SIZE_HEIGHT = 480

-- Open a Window (not needed in mobile platforms)
MOAISim.openWindow("moai-mvc", SIZE_WIDTH, SIZE_HEIGHT)

-- Set Clear Color to White
color = MOAIColor.new()
color:setColor(1, 1, 1, 1)
MOAIGfxDevice.setClearColor(color)

-- Create a Viewport
viewport = MOAIViewport.new()
viewport:setSize(SIZE_WIDTH, SIZE_HEIGHT)
viewport:setScale(SCALE_SIZE_WIDTH, SCALE_SIZE_HEIGHT)

-- Create a Layer and set its viewport
layer = MOAILayer2D.new()
layer:setViewport(viewport)

-- Create the Partition
partition = MOAIPartition.new()
layer:setPartition(partition)

-- Loading a example sprite
gfxQuad = MOAIGfxQuad2D.new()
gfxQuad:setTexture("moai.png")
gfxQuad:setRect(-64, -64, 64, 64)

-- Push the layer onto the render stack
MOAISim.pushRenderPass(layer)

----------
block_view = BlockView.new()
block_model = BlockModel.new(0, 0)
block_model:addObserver(block_view)
block_controller = BlockController.new(block_model, block_view)
----------

mouse_x = 0
mouse_y = 0

function pointerCallback(x, y)
  mouse_x, mouse_y = x, y
  touchCallback(MOAITouchSensor.TOUCH_MOVE, 0, mouse_x, mouse_y, 0)
end

function clickCallback(down)
  if down then
    touchCallback(MOAITouchSensor.TOUCH_DOWN, 0, mouse_x, mouse_y, 1)
  else
    touchCallback(MOAITouchSensor.TOUCH_UP, 0, mouse_x, mouse_y, 1)
  end
end

function touchCallback(eventType, idx, x, y, tapCount)
  world_x, world_y = layer:wndToWorld(x, y)
  block_controller:touchCallback(eventType, idx, world_x, world_y, tapCount)
end

if MOAIInputMgr.device.pointer then
  -- mouse input
  MOAIInputMgr.device.pointer:setCallback(pointerCallback)
  MOAIInputMgr.device.mouseLeft:setCallback(clickCallback)
else
  -- touch input
  MOAIInputMgr.device.touch:setCallback(touchCallback)
end

----------
