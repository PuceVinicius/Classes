function love.load()
	local chunk = love.filesystem.load("test.lua")
	result = chunk()
	img = love.graphics.newImage(result.tilesets[1].image)
	quad = {}

	col = result.tilesets[1].columns
	tw = result.tilesets[1].tilewidth
	th = result.tilesets[1].tileheight

	x = 0
	prop = 0

	quad[0] = love.graphics.newQuad(0, 0, 0, 0, 0, 0)
	while x < result.tilesets[1].tilecount do
		--print("x = ", math.floor(x/col), ", y = ", x%col)
		prop = math.floor(x/col)*th
		quad[x+1] = love.graphics.newQuad(x%col*tw, prop, tw, th, img:getDimensions())
		x = x + 1
	end

	cam = {}
	for i = 1, #result.layers do
		la = result.layers[i]
		if (la.type == "objectgroup") then
			for i = 1, #la.objects do
				if la.objects[i].type == "camera" then
					cam[tonumber(la.objects[i].name)] = la.objects[i]
					cam[tonumber(la.objects[i].name)].offsety = la.offsety
				end
			end
		end
	end

	start = love.timer.getTime()
	c1 = 1
	c2 = 2
	progress = 0
	xbase = 0
	ybase = 0
end

function next_cam(cam, number)
	if cam[number+1] == nil then
		return 1
	else
		return number+1
	end
end

function love.draw()
	--love.graphics.translate(1600/2,100) 
	love.graphics.setBackgroundColor(result.backgroundcolor)
	love.graphics.setDefaultFilter("nearest")
	--camerazinha

	progress = progress + (love.timer.getTime() - start)/cam[c1].properties.duration

	--local x_init = (cam[c1].y/cam[c1].width-cam[c1].x/cam[c1].height)*result.width/2
	--(cam[c1].x/cam[c1].width+cam[c1].y/cam[c1].height)*result.height/2 + cam[c1].offsety
	--local x_final = (cam[c2].y/cam[c2].width-cam[c2].x/cam[c2].height)*result.width/2
	--(cam[c2].x/cam[c2].width+cam[c2].y/cam[c2].height)*result.height/2 + cam[c2].offsety

	local x_init = cam[c1].x - cam[c1].y
	local y_init = cam[c1].x + cam[c1].y + cam[c1].offsety
	local x_final = cam[c2].x - cam[c2].y
	local y_final = cam[c2].x + cam[c2].y + cam[c2].offsety
	local x_target = x_final*progress + x_init*(1-progress)
	local y_target = y_final*progress + y_init*(1-progress)

	love.graphics.translate(math.floor(x_target)+400, math.floor(y_target)-900)
	if progress > 1 then
		--print(x_final, "    ", y_final)
		c1 = next_cam(cam, c1)
		c2 = next_cam(cam, c1)
		progress = 0
	end
	start = love.timer.getTime()

	for i = 1, #result.layers do
		la = result.layers[i]
		if (la.type == "tilelayer") then
			z = la.offsety
			w = result.tilewidth
			h = result.tileheight
			for x = 1, #la.data do
				y = x%20
				fww = math.floor(x/20)
				xbase = math.floor((y-fww)*w/2)
				ybase = math.floor((fww+y)*h/2 + z)
				love.graphics.draw(img, quad[la.data[x]], xbase, ybase)
			end
		end
		a = 0
		if (la.type == "objectgroup") then
			a = 0
		end
	end
end