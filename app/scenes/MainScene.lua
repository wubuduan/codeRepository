
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
   local startNode = StartNode.new()
    self:addChild(startNode,0)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
