local vape = shared.vape
local loadstring = function(...)
	local res, err = loadstring(...)
	if err and vape then 
		vape:CreateNotification('Vape', 'Failed to load : '..err, 30, 'alert') 
	end
	return res
end
local isfile = isfile or function(file)
	local suc, res = pcall(function() 
		return readfile(file) 
	end)
	return suc and res ~= nil and res ~= ''
end
local function downloadFile(path, func)
	if not isfile(path) then
		local suc, res = pcall(function() 
<<<<<<< HEAD
			return game:HttpGet('https://raw.githubusercontent.com/h4llstar/VapeV4ForRoblox/'..readfile('newvape/profiles/commit.txt')..'/'..select(1, path:gsub('newvape/', '')), true) 
=======
			return game:HttpGet('https://raw.githubusercontent.com/qyroke2/VapeV4ForRoblox/'..readfile('newvape/profiles/commit.txt')..'/'..select(1, path:gsub('newvape/', '')), true) 
>>>>>>> 8e8603dd015281f0a2fdf99afacf1b0ddb33d052
		end)
		if not suc or res == '404: Not Found' then 
			error(res) 
		end
		if path:find('.lua') then 
			res = '--This watermark is used to delete the file if its cached, remove it to make the file persist after vape updates.\n'..res 
		end
		writefile(path, res)
	end
	return (func or readfile)(path)
end

vape.Place = 8768229691
if isfile('newvape/games/'..vape.Place..'.lua') then
	loadstring(readfile('newvape/games/'..vape.Place..'.lua'), 'skywars')()
else
	if not shared.VapeDeveloper then
		local suc, res = pcall(function() 
<<<<<<< HEAD
			return game:HttpGet('https://raw.githubusercontent.com/h4llstar/VapeV4ForRoblox/'..readfile('newvape/profiles/commit.txt')..'/games/'..vape.Place..'.lua', true) 
=======
			return game:HttpGet('https://raw.githubusercontent.com/qyroke2/VapeV4ForRoblox/'..readfile('newvape/profiles/commit.txt')..'/games/'..vape.Place..'.lua', true) 
>>>>>>> 8e8603dd015281f0a2fdf99afacf1b0ddb33d052
		end)
		if suc and res ~= '404: Not Found' then
			loadstring(downloadFile('newvape/games/'..vape.Place..'.lua'), 'skywars')()
		end
	end
<<<<<<< HEAD
end
=======
end
>>>>>>> 8e8603dd015281f0a2fdf99afacf1b0ddb33d052
