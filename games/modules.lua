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

FPSUnlocker = vape.Categories.Utility:CreateModule({
    Name = "FPSUnlocker",
    Function = function(callback)
        if callback then
			setfpscap(99999999)
        end
    end,
    Tooltip = "Insanly Simple fps unlocker"
})
		
run(function()
	local ProjectileExploit = {Enabled = false}
	local old
	ProjectileExploit = vape.Categories.Modules:CreateModule({
		["Name"] = "ProjectileExploit",
		["Function"] = function(callback)
			if callback then
				old = hookmetamethod(game, "__namecall", function(self, ...)
					if self == replicatedStorage.rbxts_include.node_modules["@rbxts"].net.out._NetManaged.ProjectileFire and not checkcaller() then
						local args = {...}
						args[8].drawDurationSeconds = 0/0
					end
					return old(self, ...)
				end)
			else
				if old then
					hookmetamethod(game, '__namecall', old)
				end
			end
		end,
		["Description"] = "ProjectileExploit Thanks Retro.gone"
	})
end)

run(function()
    local anim
	local asset
	local lastPosition
    local NightmareEmote
	NightmareEmote = vape.Categories.World:CreateModule({
		Name = "NightmareEmote",
		Function = function(call)
			if call then
				local l__GameQueryUtil__8
				if (not shared.CheatEngineMode) then 
					l__GameQueryUtil__8 = require(game:GetService("ReplicatedStorage")['rbxts_include']['node_modules']['@easy-games']['game-core'].out).GameQueryUtil 
				else
					local backup = {}; function backup:setQueryIgnored() end; l__GameQueryUtil__8 = backup;
				end
				local l__TweenService__9 = game:GetService("TweenService")
				local player = game:GetService("Players").LocalPlayer
				local p6 = player.Character
				
				if not p6 then NightmareEmote:Toggle() return end
				
				local v10 = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Effects"):WaitForChild("NightmareEmote"):Clone();
				asset = v10
				v10.Parent = game.Workspace
				lastPosition = p6.PrimaryPart and p6.PrimaryPart.Position or Vector3.new()
				
				task.spawn(function()
					while asset ~= nil do
						local currentPosition = p6.PrimaryPart and p6.PrimaryPart.Position
						if currentPosition and (currentPosition - lastPosition).Magnitude > 0.1 then
							asset:Destroy()
							asset = nil
							NightmareEmote:Toggle()
							break
						end
						lastPosition = currentPosition
						v10:SetPrimaryPartCFrame(p6.LowerTorso.CFrame + Vector3.new(0, -2, 0));
						task.wait()
					end
				end)
				
				local v11 = v10:GetDescendants();
				local function v12(p8)
					if p8:IsA("BasePart") then
						l__GameQueryUtil__8:setQueryIgnored(p8, true);
						p8.CanCollide = false;
						p8.Anchored = true;
					end;
				end;
				for v13, v14 in ipairs(v11) do
					v12(v14, v13 - 1, v11);
				end;
				local l__Outer__15 = v10:FindFirstChild("Outer");
				if l__Outer__15 then
					l__TweenService__9:Create(l__Outer__15, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {
						Orientation = l__Outer__15.Orientation + Vector3.new(0, 360, 0)
					}):Play();
				end;
				local l__Middle__16 = v10:FindFirstChild("Middle");
				if l__Middle__16 then
					l__TweenService__9:Create(l__Middle__16, TweenInfo.new(12.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {
						Orientation = l__Middle__16.Orientation + Vector3.new(0, -360, 0)
					}):Play();
				end;
                anim = Instance.new("Animation")
				anim.AnimationId = "rbxassetid://9191822700"
				anim = p6.Humanoid:LoadAnimation(anim)
				anim:Play()
			else 
                if anim then 
					anim:Stop()
					anim = nil
				end
				if asset then
					asset:Destroy() 
					asset = nil
				end
			end
		end
	})
end)


run(function()
		local AntiLagback = {Enabled = false}
		local control_module = require(lplr:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")).controls
		local old = control_module.moveFunction
		local clone
		local connection
		local function clone_lplr_char()
			if not (lplr.Character ~= nil and lplr.Character.PrimaryPart ~= nil) then return nil end
			lplr.Character.Archivable = true
		
			local clone = lplr.Character:Clone()
		
			clone.Parent = game.Workspace
			clone.Name = "Clone"
		
			clone.PrimaryPart.CFrame = lplr.Character.PrimaryPart.CFrame
		
			gameCamera.CameraSubject = clone.Humanoid	
		
			task.spawn(function()
				for i, v in next, clone:FindFirstChild("Head"):GetDescendants() do
					v:Destroy()
				end
				for i, v in next, clone:GetChildren() do
					if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
						v.Transparency = 1
					end
					if v:IsA("Accessory") then
						v:FindFirstChild("Handle").Transparency = 1
					end
				end
			end)
			return clone
		end
		local function bypass()
			clone = clone_lplr_char()
			if not entitylib.isAlive then return AntiLagback:Toggle() end
			if not clone then return AntiLagback:Toggle() end
			control_module.moveFunction = function(self, vec, ...)
				local RaycastParameters = RaycastParams.new()
	
				RaycastParameters.FilterType = Enum.RaycastFilterType.Include
				RaycastParameters.FilterDescendantsInstances = {CollectionService:GetTagged("block")}
	
				local LookVector = Vector3.new(gameCamera.CFrame.LookVector.X, 0, gameCamera.CFrame.LookVector.Z).Unit
	
				if clone.PrimaryPart then
					local Raycast = game.Workspace:Raycast((clone.PrimaryPart.Position + LookVector), Vector3.new(0, -1000, 0), RaycastParameters)
					local Raycast2 = game.Workspace:Raycast(((clone.PrimaryPart.Position - Vector3.new(0, 15, 0)) + (LookVector * 3)), Vector3.new(0, -1000, 0), RaycastParameters)
	
					if Raycast or Raycast2 then
						clone.PrimaryPart.CFrame = CFrame.new(clone.PrimaryPart.Position + (LookVector / (GetSpeed())))
						vec = LookVector
					end
	
					if (not clone) and entitylib.isAlive then
						control_module.moveFunction = OldMoveFunction
						gameCamera.CameraSubject = lplr.Character.Humanoid
					end
				end
	
				return old(self, vec, ...)
			end
		end
		local function safe_revert()
			control_module.moveFunction = old
			if entitylib.isAlive then
				gameCamera.CameraSubject = lplr.Character:WaitForChild("Humanoid")
			end
			pcall(function()
				clone:Destroy()
			end)
		end
		AntiLagback = vape.Categories.Blatant:CreateModule({
			Name = "AntiLagback",
			Function = function(call)
				if call then
					connection = lplr:GetAttributeChangedSignal("LastTeleported"):Connect(function()
						if entitylib.isAlive and store.matchState ~= 0 and not lplr.Character:FindFirstChildWhichIsA("ForceField") and (not vape.Modules.BedTP.Enabled) and (not vape.Modules.PlayerTP.Enabled) then					
							bypass()
							task.wait(4.5)
							safe_revert()
						end 
					end)
				else
					pcall(function() connection:Disconnect() end)
					control_module.moveFunction = old
					if entitylib.isAlive then
						gameCamera.CameraSubject = lplr.Character:WaitForChild("Humanoid")
					end
					pcall(function() clone:Destroy() end)
				end
			end
		})
	end)

