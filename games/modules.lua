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
			return game:HttpGet('https://raw.githubusercontent.com/h4llstar/VapeV4ForRoblox/'..readfile('newvape/profiles/commit.txt')..'/'..select(1, path:gsub('newvape/', '')), true)
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
local run = function(func)
	func()
end
local queue_on_teleport = queue_on_teleport or function() end
local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local runService = cloneref(game:GetService('RunService'))
local inputService = cloneref(game:GetService('UserInputService'))
local tweenService = cloneref(game:GetService('TweenService'))
local lightingService = cloneref(game:GetService('Lighting'))
local marketplaceService = cloneref(game:GetService('MarketplaceService'))
local teleportService = cloneref(game:GetService('TeleportService'))
local httpService = cloneref(game:GetService('HttpService'))
local guiService = cloneref(game:GetService('GuiService'))
local groupService = cloneref(game:GetService('GroupService'))
local textChatService = cloneref(game:GetService('TextChatService'))
local contextService = cloneref(game:GetService('ContextActionService'))
local coreGui = cloneref(game:GetService('CoreGui'))

local isnetworkowner = identifyexecutor and table.find({'AWP', 'Nihon'}, ({identifyexecutor()})[1]) and isnetworkowner or function()
	return true
end
local gameCamera = workspace.CurrentCamera or workspace:FindFirstChildWhichIsA('Camera')
local lplr = playersService.LocalPlayer
local assetfunction = getcustomasset

local vape = shared.vape
local tween = vape.Libraries.tween
local targetinfo = vape.Libraries.targetinfo
local getfontsize = vape.Libraries.getfontsize
local getcustomasset = vape.Libraries.getcustomasset

InfiniteJump = vape.Categories.Blatant:CreateModule({
    Name = "InfiniteJump",
    Function = function(callback)
        if callback then
            local UserInputService = game:GetService("UserInputService")
            local player = game.Players.LocalPlayer
            local function setupInfiniteJump()
                local character = player.Character or player.CharacterAdded:Wait()
                local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if gameProcessed then return end
                    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Space then
                        while UserInputService:IsKeyDown(Enum.KeyCode.Space) do
                            humanoidRootPart.Velocity = Vector3.new(humanoidRootPart.Velocity.X, Velocity.Value, humanoidRootPart.Velocity.Z)
                            wait()
                        end
                    end
                end)
            end
            player.CharacterAdded:Connect(setupInfiniteJump)
            if player.Character then
                setupInfiniteJump()
            end
        end
    end,
    Tooltip = "Allows infinite jumping"
})
Velocity = InfiniteJump:CreateSlider({
    Name = 'Velocity',
    Min = 50,
    Max = 300,
    Default = 50
})

FPSUnlocker = vape.Categories.Utility:CreateModule({
    Name = "FPSUnlocker",
    Function = function(callback)
        if callback then
			setfpscap(99999999)
        end
    end,
    Tooltip = "Insanly Simple fps unlocker"
})

local BedTP
BedTP = vape.Categories.Blatant:CreateModule({
    Name = "BedTP",
    Description = "Teleports to enemy beds",
    Function = function(callback)
        if callback then
			BedTP:Toggle(false)
			local collection = game:GetService('CollectionService') :: CollectionService;
			local lplr = game.Players.LocalPlayer :: Player;
			local tween = game:GetService('TweenService') :: TweenService

			local isshield: (Model) -> boolean = function(obj: Model)
				return obj:GetAttribute('BedShieldEndTime') and obj:GetAttribute('BedShieldEndTime') > workspace:GetServerTimeNow() 
			end :: boolean
			local getbed: () -> Model? = function()
				for i: number, v: Model? in collection:GetTagged('bed') do
					if not isshield(v) and v.Bed.BrickColor ~= lplr.TeamColor then
						return v;
					end;
				end;
			end :: Model?;
			
			local bed = getbed() :: Model?;
			assert(bed, 'lmao');
			pcall(function()
				lplr.Character.Humanoid.Health = 0
			end)
			local con;
			con = lplr.CharacterAdded:Connect(function(v)
				con:Disconnect();
				task.wait(0.2)
				tween:Create(v.PrimaryPart, TweenInfo.new(0.75), {CFrame = bed.Bed.CFrame + Vector3.new(0, 6, 0)}):Play();
			end);
        end
    end
})

local PlayerTP
PlayerTP = vape.Categories.Blatant:CreateModule({
    Name = "PlayerTP",
    Description = "Teleports you to the nearest player",
    Function = function(callback)
        if callback then
			PlayerTP:Toggle(false)
			local Players = game:GetService("Players")
			local TweenService = game:GetService("TweenService")
			local LocalPlayer = Players.LocalPlayer
			
			local getClosestEnemy = function()
				local closestPlayer = nil
				local closestDistance = math.huge
			
				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= LocalPlayer and player.TeamColor ~= LocalPlayer.TeamColor and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
						if distance < closestDistance then
							closestDistance = distance
							closestPlayer = player
						end
					end
				end
			
				return closestPlayer
			end
			
			local targetPlayer = getClosestEnemy()
			assert(targetPlayer, "No enemy players found!")
			
			pcall(function()
				LocalPlayer.Character.Humanoid.Health = 0
			end)
			
			local connection
			connection = LocalPlayer.CharacterAdded:Connect(function(newCharacter)
				connection:Disconnect()
				task.wait(0.2)
			
				local targetPosition = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
				TweenService:Create(newCharacter.PrimaryPart, TweenInfo.new(0.85), {CFrame = targetPosition}):Play()
			end)
        end
    end
})

