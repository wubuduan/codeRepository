local GameScene = class("GameScene", function()
	return display.newScene("GameScene")
end)
require("app.LevelConfig")
require("app.MyData")

function  GameScene:ctor()

	--获取当前关卡数据
	local levelData = LevelConfig.getItemData(MyData.getLevel())
	--背景
	local bg = display.newSprite(LevelConfig.getBG_ITEM(MyData.getLevel()))
	bg:setPosition(ccp(display.cx, display.cy+80))
	self:addChild(bg,0)

	--金币数
	self._goldenLabel = ui.newTTFLabel({text = "$ : "..MyData.getGolden(),size = 25,color = ccc3(255, 255, 0)})
	:pos(80, display.height-50)
	:addTo(self, 1)

	--目标分数label
	self._goalLabel = ui.newTTFLabel({text = "Goal : "..LevelConfig.getLIMIT_ITEM(MyData.getLevel()),size = 25,color = ccc3(100,0,255)})
	:pos(80, display.height-20)
	:addTo(self, 1)

	--设置关卡时间
	self._times = 60

	--时间label
	self._timeLabel = ui.newTTFLabel({text = "Time : "..self._times,size = 25,color = ccc3(255, 50, 255)})
	:pos(display.width- 80,display.height-50)
	:addTo(self, 1)

	--添加关卡数label
	self._levelLabel = ui.newTTFLabel({text = "第 "..MyData:getLevel().." 关",size = 25, color = ccc3(255, 10, 255)})
		:pos(display.width-100, display.height-20)
		:addTo(self, 1)

	--创建物品
	self.goods_tab = {}
	for k,v in pairs(levelData) do
		local goods = Goods.new({path = v.pic,weight = v.weight,price = v.price})
		goods:setPosition(v.pos)
		self:addChild(goods,0)
		table.insert(self.goods_tab, goods)
	end

	


	--添加矿工
	local hero = Hero.new()
	hero:setPosition(ccp(display.cx,display.cy+80))
	self:addChild(hero)

	--添加钩子
	self._hook = Hook.new({
		funcL = function( ... ) --设置发射钩子的回调
			self:startTimerTask()
			hero:startAction()
		end,
		funcBE = function(goods) --设置钩子回收完成的回调
			self:stopTimerTask()
			hero:endAction()
			 --print(goods)

			if goods then
				MyData.setGolden(MyData.getGolden()+goods._price)
				self._goldenLabel:setString("$ : "..MyData.getGolden())
			end
		end,

		funcBB = function( goods ) --设置钩子刚开始回收的回调
			--print("BBB")
			self:stopTimerTask()

			local index = 0
			for k,v in pairs(self.goods_tab) do
				if v == goods then
					index = k
					--print(index)
					break
				end
			end

			if index ~= 0 then --钩到物品时，物品随钩子移动，然后消失

				local time = 1
				if goods then
					time = goods._weight/10
				end
				--print(goods)
				goods:runAction(getSequence({CCMoveTo:create(time, ccp(display.cx-5, display.cy+60)),CCCallFunc:create(function(...)
					goods:removeFromParentAndCleanup(true)
				end)}))

				table.remove(self.goods_tab,index)
			end

		end
		})
	self._hook:setPosition(ccp(display.cx-5, display.cy+60))
	self:addChild(self._hook)

	self._hook:startToRotation()--钩子开始转动

	--创建用于接收触摸事件的层
	local touchLayer = TouchLayer.new({func = function(...)
		if not self._hook._launchFlag then
			self._hook:hookLaunch()
		end
	end})
	self:addChild(touchLayer,0)

	--开始计时器 ----倒计时
	local sharedScheduler =  CCDirector:sharedDirector():getScheduler()
	self._schedule1 = sharedScheduler:scheduleScriptFunc(function ( ... )
		self:timeDeal1()
	end,1,false)

	--时间调度 画线
	self._schedule2 = sharedScheduler:scheduleScriptFunc(function ( ... )
		self:DrawLine()
	end, 0.1, false)
end

--开始碰撞检测
function GameScene:startTimerTask(...)
	local sharedScheduler = CCDirector:sharedDirector():getScheduler()
	self._schedule = sharedScheduler:scheduleScriptFunc(function( ... )
		self:timeDeal()
	end, 0.01, false)

end

--停止检测碰撞
function GameScene:stopTimerTask()
	local sharedScheduler = CCDirector:sharedDirector():getScheduler()
	if self._schedule then
		sharedScheduler:unscheduleScriptEntry(self._schedule)
		self._schedule = nil
	end
end

--碰撞检测
function GameScene:timeDeal( ... )
	--print("123456")
	local hPosX = self._hook:getPositionX()
	local hPosY = self._hook:getPositionY()

	for k,v in pairs(self.goods_tab) do
		local posX = v:getPositionX()
		local posY = v:getPositionY()

		if math.abs(hPosX - posX)< v:getContentSize().width*0.3 and math.abs(hPosY - posY) < v:getContentSize().height*0.3 then
			self:stopTimerTask()
			self._hook:setGoods(v)
			self._hook:hookBack()

		end
	end

end


--游戏倒计时
function GameScene:timeDeal1( ... )
	self._times = self._times - 1
	self._timeLabel:setString("Time : "..self._times)
	if self._times <= 0 then
		self._times = 0
		local sharedScheduler = CCDirector:sharedDirector():getScheduler()
		if self._schedule1 then
			sharedScheduler:unscheduleScriptEntry(self._schedule1)
			self._schedule1 = nil
	    end
	    self:stopTimerTask()
		local scene = nil

		--判断是否达成通过条件
		if LevelConfig.getLIMIT_ITEM(MyData.getLevel())<=MyData.getGolden() then
			scene = ShopScene.new()
		else
			MyData.setGolden(0)
			MyData.setLevel(1)
			scene = MainScene.new()
		end
		CCDirector:sharedDirector():replaceScene(scene)
	end
	
end

--画线
function GameScene:DrawLine(...)
	--移除之前的画线
	if  self._polygon then
		self:removeChild(self._polygon, true)
	end

	local points = {{display.cx-5,display.cy+60},{self._hook:getPosition()}}
	self._polygon = display.newPolygon(points)
	self._polygon:setLineColor(ccc4FFromccc4B(ccc4(255,0,0,255)))
	self._polygon:setLineWidth(3)
	self._polygon:setLineStippleEnabled(true)
	self:addChild(self._polygon,1)
end

function GameScene:onEnter()	
end

function GameScene:onExit()
	--退出界面时，停掉画线的时间调度 ******（如果是unscheduleAll(),则会出错，不明原因）****
	 CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(self._schedule2)

end

return GameScene