
local StartNode = class("StartNode",function()
	return display.newNode()
end)

function StartNode:ctor()
	--背景图片
 	local bg = display.newSprite("MainMenu.png")
	:pos(display.cx, display.cy) 
	:addTo(self,0)

   --添加 play 按钮
    local playItem = cc.ui.UIPushButton.new({normal = "button/PlayMenu.png"}, {scale9 = true})
    :scale(1.3)
    :pos(display.cx-130, display.cy+70)
    :addTo(self, 1)

   playItem:onButtonClicked(function(evenrt)
 	  local gameScene = GameScene.new()
 	  CCDirector:sharedDirector():replaceScene(gameScene)
   end)

   --音乐开关按钮
   local musicBtn = cc.ui.UICheckBoxButton.new({on = "button/soundController.png",
   	off = "button/soundController2.png"})
    musicBtn:setPosition(ccp(50, 50))
    musicBtn:onButtonStateChanged(function(event)
    	if event.state == "on" then
    		print("on")
        audio.playMusic("backMusic.mp3", true)
    	elseif event.state == "off" then
    		print("off")
        audio.stopMusic(true)

    	end

    end)
    musicBtn:setButtonSelected(true)
    self:addChild(musicBtn,0)
end

return StartNode