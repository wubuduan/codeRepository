
--关卡配置表

module("LevelConfig",package.seeall) --使全部内容对引用这个文件的文件可见

--获得物品信息
function getItemData(config)
	local itemData = ITEM[tonumber(config)]
	if not itemData then --当关数大于6的时候，就让矿石的摆放使用第config-6关的数据
		itemData = ITEM[config-6]
	end
	return itemData
end

--获得背景图片
function getBG_ITEM(config)
	local itemData = BG_ITEM[tonumber(config)]
	if not itemData then
	--当关数大于6的时候，就让背景的摆放使用第config-6关的数据
		itemData = BG_ITEM[config-6]
	end
	return itemData
end

--获得通关条件
function getLIMIT_ITEM( config )
	local itemData = LIMITE_ITEM[tonumber(config)]
	if not itemData then
	--当关数大于6的时候，通关分数在第六关的基础上加 (config-6)*1000
		itemData = LIMITE_ITEM[6]+(config-6)*1000 
	end
	return itemData
end


--通关分数
LIMITE_ITEM = {500,1000,1500,2000,3000,4000}

--背景图片
BG_ITEM = {
	"gameBg/mineBG1.png",
	"gameBg/mineBG2.png",
	"gameBg/mineBG3.png",
	"gameBg/mineBG4.png",
	"gameBg/mineBG5.png",
	"gameBg/mineBG6.png"
}

--物品图片，每种物品的重量和分值
local item_bg = {
	"goods/gold_large.png", --weight = 100  price = 200
	"goods/gold_middle.png", --weight = 50  price = 100
	"goods/gold_small.png", --weight = 10  price = 50
	"goods/stone_large.png", -- w = 100 p = 50
	"goods/stone_middle.png", --w = 50 p = 20
	"goods/stone_small.png", --w = 10 p = 10
	"goods/secret_large.png", --w = 10 p=300
	"goods/secret_middle.png", --w=10 p=200
	"goods/secret_small.png", --w=10  p=100
	"goods/diamond_large.png", --w=20 p=600
	"goods/diamond_middle.png", --w=15 p=300
	"goods/diamond_small.png", --w=5 p=200
}

ITEM = {}

--第一关物品
ITEM[1] = {}
ITEM[1][1] = {pic = item_bg[2],pos = ccp(80, 50),weight = 50,price = 100}
ITEM[1][2] = {pic = item_bg[2],pos = ccp(150, 55),weight = 50,price = 100}
ITEM[1][3] = {pic = item_bg[2],pos = ccp(220, 50),weight = 50,price = 100}
ITEM[1][4] = {pic = item_bg[2],pos = ccp(350, 55),weight = 50,price = 100}
ITEM[1][5] = {pic = item_bg[2],pos = ccp(430, 50),weight = 50,price = 100}
ITEM[1][6] = {pic = item_bg[3],pos = ccp(90, 130),weight = 10,price = 50}
ITEM[1][7] = {pic = item_bg[3],pos = ccp(160, 135),weight = 10,price = 50}
ITEM[1][8] = {pic = item_bg[3],pos = ccp(240, 130),weight = 10,price = 50}
ITEM[1][9] = {pic = item_bg[3],pos = ccp(360, 135),weight = 10,price = 50}
ITEM[1][10] ={pic = item_bg[3],pos = ccp(440, 130),weight = 10,price = 50}

--第二关物品信息
ITEM[2] = {}
ITEM[2][1] = {pic = item_bg[1],pos = ccp(80, 50),weight = 100,price = 200}
ITEM[2][2] = {pic = item_bg[2],pos = ccp(150, 55),weight = 50,price = 100}
ITEM[2][3] = {pic = item_bg[3],pos = ccp(220, 50),weight = 10,price = 50}
ITEM[2][4] = {pic = item_bg[4],pos = ccp(350, 55),weight = 100,price = 50}
ITEM[2][5] = {pic = item_bg[5],pos = ccp(430, 50),weight = 50,price = 20}
ITEM[2][6] = {pic = item_bg[6],pos = ccp(90, 130),weight = 10,price = 10}
ITEM[2][7] = {pic = item_bg[7],pos = ccp(160, 135),weight = 10,price = 300}
ITEM[2][8] = {pic = item_bg[8],pos = ccp(240, 130),weight = 10,price = 200}
ITEM[2][9] = {pic = item_bg[9],pos = ccp(360, 135),weight = 10,price = 100}
ITEM[2][10] ={pic = item_bg[12],pos = ccp(440, 130),weight = 5,price = 200}

--第三关物品信息
ITEM[3] = {}
ITEM[3][1] = {pic = item_bg[1],pos = ccp(80,50),weight = 100,price = 200}
ITEM[3][2] = {pic = item_bg[2],pos = ccp(150,55),weight = 50,price = 100}
ITEM[3][3] = {pic = item_bg[3],pos = ccp(220,50),weight = 10,price = 50}
ITEM[3][4] = {pic = item_bg[4],pos = ccp(350,55),weight = 100,price = 50}
ITEM[3][5] = {pic = item_bg[10],pos = ccp(430,50),weight = 20,price = 600}
ITEM[3][6] = {pic = item_bg[11],pos = ccp(90,130),weight = 15,price = 300}
ITEM[3][7] = {pic = item_bg[7],pos = ccp(160,135),weight = 10,price = 300}
ITEM[3][8] = {pic = item_bg[8],pos = ccp(240,130),weight = 10,price = 200}
ITEM[3][9] = {pic = item_bg[9],pos = ccp(360,135),weight = 10,price = 100}
ITEM[3][10] ={pic = item_bg[12],pos = ccp(440,130),weight = 5,price = 200}

ITEM[4] = {}
ITEM[4][1] = {pic = item_bg[1],pos = ccp(40,50),weight = 100,price = 200}
ITEM[4][2] = {pic = item_bg[2],pos = ccp(150, 55),weight = 50,price = 100}
ITEM[4][3] = {pic = item_bg[3],pos = ccp(220, 50),weight = 10,price = 50}
ITEM[4][4] = {pic = item_bg[4],pos = ccp(300, 55),weight = 100,price = 50}
ITEM[4][5] = {pic = item_bg[10],pos = ccp(380, 50),weight = 20,price = 600}
ITEM[4][6] = {pic = item_bg[11],pos = ccp(110, 150),weight = 15,price = 300}
ITEM[4][7] = {pic = item_bg[7],pos = ccp(210, 155),weight = 10,price = 300}
ITEM[4][8] = {pic = item_bg[8],pos = ccp(310, 150),weight = 10,price = 200}
ITEM[4][9] = {pic = item_bg[9],pos = ccp(410, 155),weight = 10,price = 100}
ITEM[4][10] ={pic = item_bg[12],pos = ccp(250, 150),weight = 5,price = 200}
ITEM[4][11] ={pic = item_bg[12],pos = ccp(80, 100),weight = 5,price = 200}
ITEM[4][12] = {pic = item_bg[12],pos = ccp(150, 80),weight = 5,price = 200}

ITEM[5] = {}
ITEM[5][1] = {pic = item_bg[1],pos = ccp(100, 50),weight = 100,price = 200}
ITEM[5][2] = {pic = item_bg[2],pos = ccp(200, 45),weight = 50,price = 100}
ITEM[5][3] = {pic = item_bg[3],pos = ccp(300, 30),weight = 10,price = 50}
ITEM[5][4] = {pic = item_bg[4],pos = ccp(400, 55),weight = 100,price = 50}
ITEM[5][5] = {pic = item_bg[10],pos = ccp(50, 50),weight = 20,price = 600}
ITEM[5][6] = {pic = item_bg[11],pos = ccp(110, 130),weight = 15,price = 300}
ITEM[5][7] = {pic = item_bg[7],pos = ccp(210, 145),weight = 10,price = 300}
ITEM[5][8] = {pic = item_bg[8],pos = ccp(310, 160),weight = 10,price = 200}
ITEM[5][9] = {pic = item_bg[9],pos = ccp(410, 155),weight = 10,price = 100}
ITEM[5][10] ={pic = item_bg[12],pos = ccp(350, 130),weight = 5,price = 200}
ITEM[5][11] ={pic = item_bg[12],pos = ccp(430, 100),weight = 5,price = 200}
ITEM[5][12] = {pic = item_bg[12],pos = ccp(350, 50),weight = 5,price = 200}

ITEM[6] = {}
ITEM[6][1] = {pic = item_bg[1],pos = ccp(100, 100),weight = 100,price = 200}
ITEM[6][2] = {pic = item_bg[2],pos = ccp(200, 105),weight = 50,price = 100}
ITEM[6][3] = {pic = item_bg[3],pos = ccp(300, 100),weight = 10,price = 50}
ITEM[6][4] = {pic = item_bg[4],pos = ccp(400, 105),weight = 100,price = 50}
ITEM[6][5] = {pic = item_bg[10],pos = ccp(80, 100),weight = 20,price = 600}
ITEM[6][6] = {pic = item_bg[11],pos = ccp(110, 150),weight = 15,price = 300}
ITEM[6][7] = {pic = item_bg[7],pos = ccp(210, 155),weight = 10,price = 300}
ITEM[6][8] = {pic = item_bg[8],pos = ccp(310, 160),weight = 10,price = 200}
ITEM[6][9] = {pic = item_bg[9],pos = ccp(410, 155),weight = 10,price = 100}
ITEM[6][10] ={pic = item_bg[12],pos = ccp(350, 130),weight = 5,price = 200}
ITEM[6][11] ={pic = item_bg[12],pos = ccp(430, 150),weight = 5,price = 200}
ITEM[6][12] = {pic = item_bg[12],pos = ccp(350, 80),weight = 5,price = 200}
