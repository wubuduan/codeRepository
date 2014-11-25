
local ShopScene = class("ShopScene", function()
	return display.newScene("ShopScene")
end)

function ShopScene:ctor()
  --添加背景
	local bg = display.newSprite("shop/shopBack.png")
	:pos(display.cx, display.cy)
	:addTo(self)

	--添加商品
	self._index = 1
	self._goods_tab = {
	{types = 1,texture = CCTextureCache:sharedTextureCache():addImage("qianglishui.png")},
	{types = 2,texture = CCTextureCache:sharedTextureCache():addImage("article_2001.png")}
}

--当前显示商品
local goods = display.newSprite(self._goods_tab[self._index].texture)
goods:setPosition(ccp(125, 90))
self:addChild(goods,0)

--下一关按钮
local nextBtn = cc.ui.UIPushButton.new({normal = "button/shopArrow.png"},{scale9 = true})
	:pos(display.width-70, 45)
	:addTo(self, 1)
	nextBtn:onButtonClicked(function(event)
  		MyData.setLevel(MyData.getLevel()+1)
  		local gameScene = GameScene.new()
  		CCDirector:sharedDirector():replaceScene(gameScene)
	end)

  --左按钮
  local leftBtn = cc.ui.UIPushButton.new({normal = "button/buyleftbtn.png"},{scale9 = true})
  	:pos(100, 45)
  	:addTo(self, 1)

  	leftBtn:onButtonClicked(function(event)
  		self._index = self._index -1
  		if self._index < 1 then
  			self._index = #self._goods_tab
  		end
  		goods:setTexture(self._goods_tab[self._index].texture)
  	end)

  	--购买按钮，功能未完成（购买物品时金币减少，物品数增加，当购买强力水时矿工速度加快，当购买炸药时，GameScene 出现炸药图片，及炸药个数）
  	local buyBtn = cc.ui.UIPushButton.new({normal = "button/buypowerbtn.png"},{scale9 = true})
  		:pos(125, 45)
  		:addTo(self, 1)

  	-- buyBtn:onButtonClicked(function(event)

  	-- end)

	--右按钮
	local rightBtn = cc.ui.UIPushButton.new({normal = "button/buyrightbtn.png"},{scale9 = true})
		:pos(150, 45)
		:addTo(self, 1)
	rightBtn:onButtonClicked(function(event)
		self._index = self._index+1
  		if self._index >#self._goods_tab then
  			self._index = 1
  		end
  		goods:setTexture(self._goods_tab[self._index].texture)

	end)

end

return ShopScene