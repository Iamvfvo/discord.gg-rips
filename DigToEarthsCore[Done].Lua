--local IlIlIIlIIlIlIlIIlIlIIlIlIlIIlIIlIl = true -- Comment this out if you're going to release
--getgenv().EnableKeyTabOverride = false
--local PlaceIDs = {}
if not game:IsLoaded() then
	game.Loaded:Wait()
end
local ScriptCreationDate = os.time({
	year = 2025,
	month = 2,
	day = 10
})
if not cloneref then
	getgenv().cloneref = function(obj)
		return obj
	end
end
local S = {
	Players = cloneref(game:GetService("Players")),
	GUIService = cloneref(game:GetService("GuiService")),
	VirtualInputManager = cloneref(game:GetService("VirtualInputManager")),
	Replicated = cloneref(game:GetService("ReplicatedStorage")),
	RunService = cloneref(game:GetService("RunService")),
	StarterGui = cloneref(game:GetService("StarterGui")),
	MarketplaceInfo = cloneref(game:GetService("MarketplaceService")):GetProductInfo(game.PlaceId),
	HTTPService = cloneref(game:GetService("HttpService")),
	CoreGui = cloneref(game:GetService("CoreGui")),
	Stats = cloneref(game:GetService("Stats")),
	Tween = cloneref(game:GetService("TweenService")),
	UserInputService = cloneref(game:GetService("UserInputService"))
}
local ExecFuncs = {
	httpreq = (http and http.request) or http_request or request or nil,
	setclip = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set) or nil,
	getcons = getconnections or get_signal_cons or nil,
	hookfunc = clonefunction and clonefunction(hookfunction) or hookfunction or nil,
	restorefunc = clonefunction and clonefunction(restorefunction) or restorefunction or nil
}
local GetRoot, GetHumanoid
local ME = setmetatable({}, {
    __index = function(t, key)
        if key == "C" then
            return S.Players.LocalPlayer.Character or S.Players.LocalPlayer.CharacterAdded:Wait()
        elseif key == "BP" then
            return S.Players.LocalPlayer:WaitForChild("Backpack", 5)
		elseif key == "Root" then
			return GetRoot(S.Players.LocalPlayer.Character)
		elseif key == "Humanoid" then
			return GetHumanoid(S.Players.LocalPlayer.Character)
		elseif key == "Mouse" then
			return S.Players.LocalPlayer:GetMouse()
        else
            return S.Players.LocalPlayer[key]
        end
    end
})
ME.GetTool = function(name, parent)
	local tool = (ME.C:FindFirstChild(name) or ME.BP:FindFirstChild(name))
	if tool then
		if parent then
			tool.Parent = parent
		end
		return tool
	else
		return nil
	end
end
GetRoot = function(value)
	if value == ME.C and not (ME.C:FindFirstChild("HumanoidRootPart") or ME.C:FindFirstChild("Torso") or ME.C:FindFirstChild("UpperTorso") or ME.C:IsA("Model") and ME.C.PrimaryPart) then
		repeat
			wait()
		until ME.C:FindFirstChild("HumanoidRootPart") or ME.C:FindFirstChild("Torso") or ME.C:FindFirstChild("UpperTorso") or ME.C:IsA("Model") and ME.C.PrimaryPart
	end
	if value:IsA("Player") then
		if value.Character and (value.Character:FindFirstChild("HumanoidRootPart") or value.Character:FindFirstChild("Torso") or value.Character:FindFirstChild("UpperTorso") or value.Character:IsA("Model") and value.Character.PrimaryPart) then
			return value.Character:FindFirstChild("HumanoidRootPart") or value.Character:FindFirstChild("Torso") or value.Character:FindFirstChild("UpperTorso") or value.Character:IsA("Model") and value.Character.PrimaryPart
		else
			return nil
		end
	elseif value:IsA("Model") then
		if value:FindFirstChild("HumanoidRootPart") or value:FindFirstChild("Torso") or value:FindFirstChild("UpperTorso") or value.PrimaryPart then
			return value:FindFirstChild("HumanoidRootPart") or value:FindFirstChild("Torso") or value:FindFirstChild("UpperTorso") or value.PrimaryPart
		else
			return nil
		end
	end
end
GetHumanoid = function(value, health)
	if value == ME.C and not ME.C:FindFirstChildOfClass("Humanoid") then
		repeat
			wait()
		until ME.C:FindFirstChildOfClass("Humanoid")
	end
	if value:IsA("Player") then
		if value.Character and value.Character:FindFirstChildOfClass("Humanoid") then
			if health then
				if value.Character:FindFirstChildOfClass("Humanoid").Health >= health then
					return value.Character:FindFirstChildOfClass("Humanoid")
				else
					return nil
				end
			end
			return value.Character:FindFirstChildOfClass("Humanoid")
		elseif value.Character and not value.Character:FindFirstChildOfClass("Humanoid") then
			for i, v in pairs(value.Character:GetDescendants()) do
				if v:IsA("Humanoid") then
					if health then
						if v.Health >= health then
							return v
						else
							return nil
						end
					end
					return v
				end
			end
		else
			return nil
		end
	elseif value:IsA("Model") then
		if value:FindFirstChildOfClass("Humanoid") then
			if health then
				if value:FindFirstChildOfClass("Humanoid").Health >= health then
					return value:FindFirstChildOfClass("Humanoid")
				else
					return nil
				end
			end
			return value:FindFirstChildOfClass("Humanoid")
		elseif not value:FindFirstChildOfClass("Humanoid") then
			for i, v in pairs(value:GetDescendants()) do
				if v:IsA("Humanoid") then
					if health then
						if v.Health >= health then
							return v
						else
							return nil
						end
					end
					return v
				end
			end
		else
			return nil
		end
	end
end
local function RandomString(size)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local str = ""
    for i = 1, size do
        local randIndex = math.random(1, #chars)
        str = str .. chars:sub(randIndex, randIndex)
    end
    return str
end
local EncrytionKey = RandomString(32)
local function KickME(Reason)
    ME:Kick("Detected by Anti-Tamper")
    wait()
    repeat until false
    while true do end
end
if isfunctionhooked then
    pcall(function() restorefunction(isfunctionhooked) end)
    if hookfunction and isfunctionhooked(hookfunction) and not IlIlIIlIIlIlIlIIlIlIIlIlIlIIlIIlIl then
        KickME("HookFunction is hooked before launch")
    end
    if isfunctionhooked(wait) and not IlIlIIlIIlIlIlIIlIlIIlIlIlIIlIIlIl then
        KickME("Wait is hooked before launch")
    end
    for i, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") and not IlIlIIlIIlIlIlIIlIlIIlIlIlIIlIIlIl then
            if isfunctionhooked(v.FireServer) then
                KickME(v:GetFullName() .. "." .. v.Name .. " FireServer is hooked before launch")
            end
        elseif v:IsA("RemoteFunction") and not IlIlIIlIIlIlIlIIlIlIIlIlIlIIlIIlIl then
            if isfunctionhooked(v.InvokeServer) then
                KickME(v:GetFullName() .. "." .. v.Name .. " InvokeServer is hooked before launch")
            end
        end
    end
    if http and http.request then
        if isfunctionhooked(http.request) and not IlIlIIlIIlIlIlIIlIlIIlIlIlIIlIIlIl then
            KickME("HTTP.Request is hooked before launch")
        end
    end
    if syn and syn.request then
        if isfunctionhooked(syn.request) and not IlIlIIlIIlIlIlIIlIlIIlIlIlIIlIIlIl then
            KickME("Syn Request is hooked before launch")
        end
    end
    if http_request then
        if isfunctionhooked(http_request) and not IlIlIIlIIlIlIlIIlIlIIlIlIlIIlIIlIl then
            KickME("HTTP_Request is hooked before launch")
        end
    end
    if request then
        if isfunctionhooked(request) and not IlIlIIlIIlIlIlIIlIlIIlIlIlIIlIIlIl then
            KickME("Request is hooked before launch")
        end
    end
    local RobloxHTTPFuncs = {
        "HttpGet",
        "HttpGetAsync"
    }
    for i, v in pairs(({"HttpGet", "HttpGetAsync"})) do
        if isfunctionhooked(game[v]) and not IlIlIIlIIlIlIlIIlIlIIlIlIlIIlIIlIl then
            KickME("game." .. v .. " is hooked before launch")
        end
    end
end
local function Notify(title, text, duration, buttons, callback)
	local Notification = {
		Title = title or "Title",
		Text = text or "Text",
		Duration = duration or 10
	}
	if callback then
		local tempbind = Instance.new("BindableFunction")
		tempbind.OnInvoke = callback
		Notification.Callback = tempbind
	end
	if buttons then
		for i, v in ipairs(buttons) do
			Notification["Button" .. i] = v
		end
	end
	S.StarterGui:SetCore("SendNotification", Notification)
end
local function RIP_Hub_V2Key(state, newkey)
	if isfile and writefile and readfile then
		if state == "set" then
			script_key = script_key or newkey
			writefile("RIP_HUB_V2_KEY.json", S.HTTPService:JSONEncode({key = script_key}))
		elseif state == "get" then
			if isfile("RIP_HUB_V2_KEY.json") then
				local key = S.HTTPService:JSONDecode(readfile("RIP_HUB_V2_KEY.json")).key
				return key
			else
				return nil
			end
		end
	else
		Notify("Error", "Your exploit is missing the necessary functions to save your key", math.huge, {"Close"})
	end
end
local api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
api.script_id = "7d5a63c68c86b3d20598cea6fa90f2be"
local function IsKeyValid(key)
	local status = api.check_key(key)
	if status.code == "KEY_VALID" then
		return true
	else
		return false
	end
end
_G.a8Fj2LmQp9Xz4Yw7Vr6Tz5Bn = true
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/Premium/UniversalVehicleGUI.lua"))()
local MaterialModule = _G.Material
_G.Material = nil
local function JoinDiscord(Invite)
	coroutine.wrap(pcall)(function()
		ExecFuncs.setclip("https://discord.gg/" .. Invite)
		coroutine.wrap(ExecFuncs.httpreq)({
			Url = "http://127.0.0.1:6463/rpc?v=1",
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json",
				Origin = "https://discord.com"
			},
			Body = S.HTTPService:JSONEncode({
				cmd = "INVITE_BROWSER",
				nonce = S.HTTPService:GenerateGUID(false),
				args = {
					code = Invite
				}
			})
		})
	end)
end
local function CustomJSON(t, indent)
    indent = indent or 0
    local x, a = {}, {}
    local indentStr = string.rep("\t", indent)
    for i in next, t do
        a[#a + 1] = i
    end
    -- Sort keys with a custom comparator to handle mixed types
    table.sort(a, function(a, b)
        if type(a) == type(b) then
            return a < b
        end
        return type(a) < type(b)
    end)
    for _, v in next, a do
        local value = t[v]
        local valueType = typeof(value)
        if valueType == "string" then
            value = ("%q"):format(value)
        elseif valueType == "table" then
            value = CustomJSON(value, indent + 1)
        else
            value = tostring(value)
        end
        x[#x + 1] = ("%s%q: %s"):format(indentStr, v, value)
    end
    return (#x <= 0 and "{}") or ("{\n%s\n%s}"):format(table.concat(x, ",\n"), indentStr:sub(1, -2))
end
local function checkif(func, msg)
	if not func then
		warn(msg)
		Notify("Error", "Your exploit is missing " .. msg, math.huge, {"Close"})
		return false
	else
		return func
	end
end
local InfiniteJump = false--ReturnFSValue("InfiniteJump", false)
ME.Mouse.KeyDown:Connect(function(Key)
	if InfiniteJump and Key == " " and ME.Humanoid then
		xpcall(function()
			ME.Humanoid:ChangeState(3)
		end, warn)
	end
end)
if not _G.Credits then
	JoinDiscord(_G.Vanities.RIP)
elseif _G.Credits and _G.Credits ~= "discord.gg/" .. _G.Vanities.RIP then
	coroutine.wrap(pcall)(function()
		ME.P:Kick("\nInvalid Credits\nPlease use discord.gg/" .. _G.Vanities.RIP)
	end)
	wait(.5)
	coroutine.wrap(function()
		while true do
		end
	end)()
	coroutine.wrap(function()
		repeat
		until false
	end)()
end
if _G[S.MarketplaceInfo.Name] then
	local WaitingUntilResponse = true
	Notify("Already Loaded", "Would you like to reload it?", math.huge, {"Yes", "No"}, function(selected)
		if selected == "Yes" then
			WaitingUntilResponse = false
		end
	end)
	repeat wait() until WaitingUntilResponse == false
end
_G[S.MarketplaceInfo.Name] = true
local TweenSpeed = 60--ReturnFSValue("TweenSpeed", 60)
local function TweenTP(cf, dur, dowait)
	if not cf or typeof(cf) ~= "CFrame" then
		if cf and typeof(cf) == "Vector3" then
			cf = CFrame.new(cf)
		else
			return warn("Invalid argument #1 for 'TweenTP'")
		end
	end
    local BodyVel = nil
	local HRP = ME.Root
    if dowait then
        BodyVel = Instance.new("BodyVelocity", HRP)
        BodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    end
	local Moving = S.Tween:Create(HRP, TweenInfo.new(tonumber(dur) or ((cf.p - HRP.CFrame.p).Magnitude / TweenSpeed), 0), {
		CFrame = cf
	})
	Moving:Play()
	if dowait then
		Moving.Completed:Wait()
        if BodyVel and BodyVel.Parent then
            BodyVel:Destroy()
        end
	end
	return Moving
end
local ForceMethod, ForcedMethod = false, "CFrame"
local function TeleportTo(CFrame, Method, IfNotWithinDistance)
	if typeof(CFrame) == "Instance" then
		CFrame = CFrame.CFrame
	elseif typeof(CFrame) == "Vector3" then
		CFrame = CFrame.new(CFrame)
	end
    if ForceMethod then
        Method = ForcedMethod
    end
	if not Method or Method == "CFrame" and (IfNotWithinDistance and (ME.Root.Position - CFrame.Position).magnitude > IfNotWithinDistance or not IfNotWithinDistance) then
		ME.Root.CFrame = CFrame
	elseif Method == "MoveTo" and (IfNotWithinDistance and (ME.Root.Position - CFrame.Position).magnitude > IfNotWithinDistance or not IfNotWithinDistance) then
		ME.C:MoveTo(CFrame.Position)
	elseif Method == "SetPrimaryPartCFrame" and (IfNotWithinDistance and (ME.Root.Position - CFrame.Position).magnitude > IfNotWithinDistance or not IfNotWithinDistance) then
		ME.C:SetPrimaryPartCFrame(CFrame)
	elseif Method == "Tween" and (IfNotWithinDistance and (ME.Root.Position - CFrame.Position).magnitude > IfNotWithinDistance or not IfNotWithinDistance) then
		TweenTP(CFrame, false, true)
	elseif Method == "Walk To" and (IfNotWithinDistance and (ME.Root.Position - CFrame.Position).magnitude > IfNotWithinDistance or not IfNotWithinDistance) then
		ME.Humanoid.WalkToPoint = CFrame.Position
	end
	return CFrame
end
local function fire(instance, instance2, number)
	if instance:IsA("ClickDetector") and checkif(fireclickdetector, "fireclickdetector.") then
		--warn("Firing " .. instance.ClassName .. ": " .. instance.Parent:GetFullName() .. "[\"" .. instance.Name .. "\"]")
		fireclickdetector(instance)
	elseif instance:IsA("TouchTransmitter") and checkif(firetouchinterest, "firetouchinterest.") then
		--warn("Firing " .. instance.ClassName .. ": " .. instance.Parent:GetFullName() .. "[\"" .. instance.Name .. "\"]")
		if not number then
			number = 3
		end
		if instance.Parent:IsA("BasePart") then
			if number == 3 then
				firetouchinterest(instance2 or ME.Root, instance.Parent, 0)
				return firetouchinterest(instance2 or ME.Root, instance.Parent, 1)
			else
				return firetouchinterest(instance2 or ME.Root, instance.Parent, number)
			end
		else
			if number == 3 then
				firetouchinterest(instance2 or ME.Root, instance:FindFirstAncestorWhichIsA("BasePart"), 0)
				return firetouchinterest(instance2 or ME.Root, instance:FindFirstAncestorWhichIsA("BasePart"), 1)
			else
				return firetouchinterest(instance2 or ME.Root, instance:FindFirstAncestorWhichIsA("BasePart"), number)
			end
		end
	elseif instance:IsA("ProximityPrompt") and ME.Root and checkif(fireproximityprompt, "fireproximityprompt.") then
		--warn("Firing " .. instance.ClassName .. ": " .. instance.Parent:GetFullName() .. "[\"" .. instance.Name .. "\"]")
		local Saved = ME.Root.CFrame
		local instanceTriggered = false
		local TriggeredConnection
		TriggeredConnection = instance.Triggered:Connect(function(plr)
            if plr == ME then
                instanceTriggered = true
                TriggeredConnection:Disconnect()
            end
		end)
    	repeat
            TeleportTo((instance2 and instance2.CFrame) or (instance:FindFirstAncestorWhichIsA("BasePart") and instance:FindFirstAncestorWhichIsA("BasePart").CFrame), "CFrame", instance.MaxActivationDistance)
            wait(number or .2)
            fireproximityprompt(instance)
        until instanceTriggered or not ME.C or ME.C and not ME.C:FindFirstChild("HumanoidRootPart") or not instance or not instance.Parent
        if number then
            delay(number or .3, function()
                TeleportTo(Saved, "CFrame", 10)
            end)
        end
	elseif instance:IsA("BasePart") and checkif(firetouchinterest, "firetouchinterest.") then
		--warn("Firing " .. instance.ClassName .. ": " .. instance.Parent:GetFullName() .. "[\"" .. instance.Name .. "\"]")
		if not number then
			number = 3
		end
		if number == 3 then
			firetouchinterest(instance2 or ME.Root, instance, 0)
			return firetouchinterest(instance2 or ME.Root, instance, 1)
		else
			return firetouchinterest(instance2 or ME.Root, instance, number)
		end
	end
end
local CheckWithin = 1 -- in minutes
local Start = nil
local Fastest = nil
local ForceOne = false
local CurrentFastest = nil
local CurrentFastestNumber = 0
local function FastestWait()
    if Fastest and (ForceOne or Start and os.time() - Start <= CheckWithin * 60) then
        if Fastest == "task.wait" then
            return task.wait()
        elseif Fastest == "wait" then
            return wait()
        elseif Fastest == "Heartbeat" then
            return S.RunService.Heartbeat:Wait()
        elseif Fastest == "RenderStepped" then
            return S.RunService.RenderStepped:Wait()
        elseif Fastest == "Stepped" then
            return S.RunService.Stepped:Wait()
        end
    end
    local Waits = {}
    coroutine.wrap(function()
        Waits["task.wait"] = task.wait()
    end)()
    coroutine.wrap(function()
        Waits["wait"] = wait()
    end)()
    coroutine.wrap(function()
        Waits.Heartbeat = S.RunService.Heartbeat:Wait()
    end)()
    coroutine.wrap(function()
        Waits.RenderStepped = S.RunService.RenderStepped:Wait()
    end)()
    coroutine.wrap(function()
        Waits.Stepped = ({S.RunService.Stepped:Wait()})[2]
    end)()
    repeat task.wait() until Waits["task.wait"] and Waits["wait"] and Waits.Heartbeat and Waits.RenderStepped and Waits.Stepped
    local low, lowest = nil, 9e9
    for i, v in pairs(Waits) do
        --print(i .. " = " .. v)
        if v < lowest then
            low = i
            lowest = v
        end
    end
    CurrentFastest = low
    CurrentFastestNumber = lowest
    Fastest = low
    Start = os.time()
    return FastestWait()
end
local function FindFirstWith(path, property, value)
	for i, v in pairs(path:GetChildren()) do
		if v[property] == value then
			return v
		end
	end
end
local function ActiveDropdown(dropdown, tab, ignore)
	local nt = {}
	for i, v in pairs((tab.Descendants and tab.Path:GetDescendants() or tab.Path:GetChildren())) do
		if v:IsA(tab.ClassName) and (tab.Duplicates or not table.find(nt, v[tab.Property])) and (not ignore or not table.find(ignore, v)) then
			nt[#nt + 1] = v[tab.Property]
		end
	end
	dropdown:SetOptions(nt)
	tab.Path[tab.Descendants and "DescendantAdded" or "ChildAdded"]:Connect(function(v)
		if v:IsA(tab.ClassName) and (tab.Duplicates or not table.find(nt, v[tab.Property])) and (not ignore or not table.find(ignore, v)) then
			nt[#nt + 1] = v[tab.Property]
			dropdown:SetOptions(nt)
		end
	end)
	tab.Path[tab.Descendants and "DescendantRemoving" or "ChildRemoved"]:Connect(function(v)
		if v:IsA(tab.ClassName) and table.find(nt, v[tab.Property]) and not FindFirstWith(tab.Path, tab.Property, v[tab.Property]) then
			table.remove(nt, table.find(nt, v[tab.Property]))
			dropdown:SetOptions(nt)
		end
	end)
end
local function parse_json_date(json_date)
	local year, month, day, hour, minute, seconds, offsetsign, offsethour, offsetmin = json_date:match("(%d+)%-(%d+)%-(%d+)%a(%d+)%:(%d+)%:([%d%.]+)([Z%+%-])(%d?%d?)%:?(%d?%d?)")
	local timestamp = os.time({
		year = year,
		month = month,
		day = day,
		hour = hour,
		min = minute,
		sec = seconds
	})
	local offset = 0
	if offsetsign ~= "Z" then
		offset = tonumber(offsethour) * 60 + tonumber(offsetmin)
	end
	return timestamp + offset
end
local pingValues = {}
local maxPingValues = 100 -- Number of ping values to store
local thresholdMultiplier = 1.5 -- Pause if ping is 1.5 times the average
local consecutiveChecks = 5 -- Number of consecutive checks below threshold to resume
local function GetPing()
    return S.Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
end
local function CalculateAveragePing()
    local sum = 0
    for _, ping in ipairs(pingValues) do
        sum = sum + ping
    end
    return sum / #pingValues
end
local OriginalTime = os.clock()
local function MonitorPing()
	if os.clock() - OriginalTime >= 1 then
		OriginalTime = os.clock()
		local belowThresholdCount = 0
		local currentPing = GetPing()
		table.insert(pingValues, currentPing)
		if #pingValues > maxPingValues then
			table.remove(pingValues, 1)
		end
		local averagePing = CalculateAveragePing()
		if currentPing > averagePing * thresholdMultiplier then
			print("Ping too high, pausing...(" .. currentPing .. "ms)")
			repeat
				currentPing = GetPing()
				if currentPing <= averagePing * thresholdMultiplier then
					belowThresholdCount = belowThresholdCount + 1
				else
					belowThresholdCount = 0
				end
				wait(1)
			until belowThresholdCount >= consecutiveChecks
			print("Ping back to normal, resuming...(" .. currentPing .. "ms)")
		end
	end
end
Notify("Last Updated", "Script Last Updated:\n" .. math.floor((os.time() - ScriptCreationDate) / 86400) .. " days ago", math.huge, {"Close"})
if ScriptCreationDate < parse_json_date(S.MarketplaceInfo.Updated) then
	local WaitingUntilResponse = false--ReturnFSValue("DisableVersionCheck", false)
	Notify("Outdated", "Game has been updated since the script was created and options may not work.\nUSE AT YOUR OWN RISK", math.huge, {"Continue", "Cancel"}, function(response)
		if response == "Continue" then
			WaitingUntilResponse = true
		end
	end)
	repeat
		wait()
	until WaitingUntilResponse == true
else
	Notify("Up To Date", "Script is up to date please report bugs in discord.gg/" .. _G.Vanities.RIP, 10, {"Close"})
end
local GUIName = string.sub(S.MarketplaceInfo.Name, 1, 40)-- .. " | discord.gg/" .. _G.Vanities.RIP .. " | <font color='rgb(255,0,0)'>RIP V2</font>"
local MaterialGUI = MaterialModule.Load({
	Title = GUIName,
	Style = 1,
	SizeX = 500,
	SizeY = 350,
	WatermarkRight = true,
	Theme = _G.RedGUI and "Red" or _G.Theme or "Dark"
})
local Logo = [[        _.---,._,'                             '._,---._        
       /' _.--.<                                >.--._ `\       
         /'     `'                             '`     `\        
       /' _.---._____                       _____,---._ `\       
       \.'   ___, .-'`                       `'-, ___, './       
           /'    \\             .             //    `\       
         /'       `-.          -|-          .-'       `\        
        |                       |                       |        
        |                   .-'~~~`-.                   |        
        |                 .'         `.                 |        
        |                 |  R  I  P  |                 |        
        |                 |           |                 |        
        |                 |  RIP#6666 |                 |        
        |                 |  gg/]] .. _G.Vanities.RIP .. [[  |                 |        
         \              \\| From 2020 |//              /        
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

]]
MaterialGUI.Banner({
	Text = Logo .. "		  CREATED BY RI.P (RIP#6666) for DISCORD.GG/" .. _G.Vanities.RIP:upper(),
	Options = {
		["Join Discord Server"] = function()
			JoinDiscord(_G.Vanities.RIP)
		end,
		["Copy Discord Link"] = function()
			if not ExecFuncs.setclip then
				Notify("Error", "Copy to clipboard is not supported by your executor")
			else
				ExecFuncs.setclip("https://discord.gg/" .. _G.Vanities.RIP)
				Notify("Success", "Copied to clipboard")
			end
		end
	}
})
local LocalPlayer = MaterialGUI.New({
	Title = "Client",
	Icon = "rbxassetid://10747373176"
})
LocalPlayer.TabTitle({
	Text = "LocalPlayer"
})
LocalPlayer.Label({
	Text = "WalkSpeed"
})
local LocalPlayerWalkSpeed = ME.Humanoid.WalkSpeed or 16
LocalPlayer.Slider({
	Text = "Walkspeed",
	Callback = function(Value)
		LocalPlayerWalkSpeed = Value
	end,
	Min = 0,
	Max = (ME.Humanoid.WalkSpeed >= 200 and ME.Humanoid.WalkSpeed + 200) or 200,
	Def = LocalPlayerWalkSpeed,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Changes your walkspeed"
			})
		end
	}
})
local SetPlayerWalkSpeed = false
LocalPlayer.Toggle({
	Text = "Set Walkspeed",
	Callback = function(Value)
		SetPlayerWalkSpeed = Value
		while SetPlayerWalkSpeed and FastestWait() do
			pcall(function()
				ME.Humanoid.WalkSpeed = LocalPlayerWalkSpeed
			end)
		end
	end,
	Enabled = false,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Automatically sets your walkspeed to the value above"
			})
		end
	}
})
LocalPlayer.Label({
	Text = "JumpPower"
})
local LocalPlayerJumppower = ME.Humanoid.JumpPower or 50
LocalPlayer.Slider({
	Text = "Jumppower",
	Callback = function(Value)
		LocalPlayerJumppower = Value
	end,
	Min = 0,
	Max = (ME.Humanoid.JumpPower >= 200 and ME.Humanoid.JumpPower + 200),
	Def = LocalPlayerJumppower,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Changes your jumppower"
			})
		end
	}
})
local LocalPlayerSetJumppower = false
LocalPlayer.Toggle({
	Text = "Set Jumppower",
	Callback = function(Value)
		LocalPlayerSetJumppower = Value
		while LocalPlayerSetJumppower and FastestWait() do
			pcall(function()
				ME.Humanoid.JumpPower = LocalPlayerJumppower
			end)
		end
	end,
	Enabled = false,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Automatically sets your jumppower to the value above"
			})
		end
	}
})
LocalPlayer.Toggle({
	Text = "Infinite Jump",
	Callback = function(Value)
		InfiniteJump = Value
	end,
	Enabled = InfiniteJump,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Allows you to jump infinitely"
			})
		end
	}
})
LocalPlayer.TabTitle({
	Text = "NoClip"
})
local CollidingParts = {}
local NoClipping = false
LocalPlayer.Toggle({
	Text = "Disable Character Collisions",
	Callback = function(Value)
		NoClipping = Value
		if NoClipping then
			CollidingParts = {}
		end
		while NoClipping and FastestWait() do
			for i, v in pairs(ME.C:GetDescendants()) do
				if v:IsA("BasePart") and v.CanCollide == true then
                    table.insert(CollidingParts, v)
					v.CanCollide = false
				end
			end
		end
		if not NoClipping then
            for i, v in pairs(CollidingParts) do
                if v and v.Parent then
                    v.CanCollide = true
                end
            end
		end
	end,
	Enabled = false,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Allows you to walk through walls"
			})
		end
	}
})
LocalPlayer.TabTitle({
	Text = "AFK"
})
LocalPlayer.Button({
	Text = "Anti AFK",
	Callback = function()
		if ExecFuncs.getcons then
			for _, v in pairs(ExecFuncs.getcons(ME.Idled)) do
				if v["Disable"] then
					v["Disable"](v)
				elseif v["Disconnect"] then
					v["Disconnect"](v)
				end
			end
			Notify("Success", "Anti AFK enabled", math.huge, {"Close"})
		else
			MaterialGUI.Banner({
				Text = Logo .. "Your exploit does not support this command (missing getconnections)",
				Options = {
					["What is getconnections?"] = function()
						MaterialGUI.Banner({
							Text = Logo .. "getconnections is a function that allows you to get the connections of a signal"
						})
					end,
					["How do I fix this?"] = function()
						MaterialGUI.Banner({
							Text = Logo .. "You can fix this by using an exploit that supports getconnections. (Nihon, Wave, Synapse Z, etc.)"
						})
					end
				}
			})
		end
	end,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Prevents you from being kicked for being AFK"
			})
		end
	}
})
LocalPlayer.TabTitle({
	Text = "Tools"
})
local SpamHeldTool = false
LocalPlayer.Toggle({
	Text = "Spam Held Tool",
	Callback = function(Value)
		SpamHeldTool = Value
		while SpamHeldTool and wait() do
			local tool = ME.C:FindFirstChildOfClass("Tool")
			if tool then
				tool:Activate()
			end
		end
	end,
	Enabled = false,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Spams the tool you are holding"
			})
		end
	}
})
ActiveDropdown(LocalPlayer.Dropdown({
	Text = "Teleport to Player",
	Callback = function(Value)
		GetRoot(ME.C).CFrame = GetRoot(S.Players[Value]).CFrame
	end,
	Options = {},
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Teleports you to the player selected"
			})
		end
	}
}), {
	Path = S.Players,
	ClassName = "Player",
	Property = "Name",
	Descendants = false,
	Duplicates = false
}, {ME})
LocalPlayer.TabTitle({
	Text = "Reset"
})
LocalPlayer.Button({
	Text = "Reset",
	Callback = function()
		local pos, pos1 = ME.Root.CFrame, workspace.CurrentCamera.CFrame
		ME.C:BreakJoints()
		ME.Humanoid.Health = 0
		ME.Humanoid:ChangeState(15)
		ME.CharacterAdded:Wait():WaitForChild("HumanoidRootPart").CFrame, workspace.CurrentCamera.CFrame = pos, pos1
	end,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Resets your character and teleports you back to your original position"
			})
		end
	}
})
LocalPlayer.Button({
	Text = "Reset Animations",
	Callback = function()
		for i, v in pairs(ME.Humanoid:GetPlayingAnimationTracks()) do
			v:Stop()
		end
	end,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Stops all animations currently playing"
			})
		end
	}
})
LocalPlayer.TabTitle({
	Text = "Infinite Yield"
})
LocalPlayer.Button({
	Text = "Execute Infinite Yield",
	Callback = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"), "InfiniteYield"),
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Executes Infinite Yield's FE admin\ndiscord.gg/" .. _G.Vanities.RIP .. " is not responsible for bans resulting from this"
			})
		end
	}
})






local function parseCost(costText)
    if not costText or costText == "" then return nil end
    if type(costText) == "number" then
        return costText
    end
    -- Only gsub if there is a comma or period
    if string.find(costText, ",") or string.find(costText, "%.") then
        costText = costText:gsub(",", "")
    end
    local number, suffix = costText:match("(%d+%.?%d*)(%a+)")
    number = tonumber(number)
    if not number then return nil end
    if suffix == "K" or suffix == "k" then
        return number * 1e3
    elseif suffix == "M" or suffix == "m" then
        return number * 1e6
    elseif suffix == "B" or suffix == "b" then
        return number * 1e9
    elseif suffix == "T" or suffix == "t" then
        return number * 1e12
    elseif suffix == "Qa" or suffix == "qa" then
        return number * 1e15
    elseif suffix == "Qi" or suffix == "qi" then
        return number * 1e18
    elseif suffix == "Sx" or suffix == "sx" then
        return number * 1e21
    elseif suffix == "Sp" or suffix == "sp" then
        return number * 1e24
    elseif suffix == "Oc" or suffix == "oc" then
        return number * 1e27
    elseif suffix == "No" or suffix == "no" then
        return number * 1e30
    elseif suffix == "Dc" or suffix == "dc" then
        return number * 1e33
    elseif suffix == "Qt" or suffix == "qt" then
        return number * 1e18 -- alternate for quintillion
    else
        return number -- No suffix or unknown suffix
    end
end
local ActiveDropdowns = {}
local Selloptoins = "Triple Dominous"
local worldoptions = "World1"
local FarmTab = MaterialGUI.New({
	Title = "Farm"
})	
FarmTab.TabTitle({
    Text = "AutoFarm Options"
})
FarmTab.TabTitle({
	Text = "Auto Win"
})
local function teleportoncetotop(World, Value)
	if workspace[World]:FindFirstChild('SurfacePart2') and Value then
		ME.Root.CFrame = workspace[World].SurfacePart2.CFrame
	end
end
local function gototop(World, Value)
    if workspace[World]:FindFirstChild("WinPart") and Value then
        local winPart = workspace[World].WinPart
        workspace[World].WinPart.Touched:Connect(function(hit)
            if hit.Parent and hit.Parent:FindFirstChild("Humanoid") and hit.Parent == ME.C and Value then
				wait(0.5)
				ME.Root.CFrame = workspace[World].SurfacePart2.CFrame
            end
        end)
    end
end
FarmTab.Toggle({
	Text = "Win",
	Callback = function(Value)
		wintroph = Value
		if worldoptions == "World1" then
			teleportoncetotop("World1", wintroph)
		elseif worldoptions == "World2" then
			teleportoncetotop("World2", wintroph)
		elseif worldoptions == "World3" then
			teleportoncetotop("World3", wintroph)
		elseif worldoptions == "World4" then
			teleportoncetotop("World4", wintroph)
		elseif worldoptions == "World5" then
			teleportoncetotop("World5", wintroph)
		elseif worldoptions == "World6" then
			teleportoncetotop("World6", wintroph)
		elseif worldoptions == "World7" then
			teleportoncetotop("World7", wintroph)
		elseif worldoptions == "World8" then
			teleportoncetotop("World8", wintroph)
		elseif worldoptions == "World9" then
			teleportoncetotop("World9", wintroph)
		elseif worldoptions == "World10" then
			teleportoncetotop("World10", wintroph)
		end
		while wintroph and Wait() do
            if wintroph then
				for i, v in pairs(ME.C:GetChildren()) do
					if v:IsA('Tool') and wintroph then
						v:Activate()
						if worldoptions == "World1" then
							gototop("World1", wintroph)
						elseif worldoptions == "World2" then
							gototop("World2", wintroph)
						elseif worldoptions == "World3" then
							gototop("World3", wintroph)
						elseif worldoptions == "World4" then
							gototop("World4", wintroph)
						elseif worldoptions == "World5" then
							gototop("World5", wintroph)
						elseif worldoptions == "World6" then
							gototop("World6", wintroph)
						elseif worldoptions == "World7" then
							gototop("World7", wintroph)
						elseif worldoptions == "World8" then
							gototop("World8", wintroph)
						elseif worldoptions == "World9" then
							gototop("World9", wintroph)
						elseif worldoptions == "World10" then
							gototop("World10", wintroph)
						end
					end
				end
            end
		end
	end,
	Enabled = false
})
FarmTab.Dropdown({
	Text = "Auto Win Options",
	Callback = function(Value)
		worldoptions = Value
	end,
	Options = {"World1", "World2", "World3", "World4", "world5", "World6", "World7", "World8", "World9", "World10"},
})

FarmTab.TabTitle({
	Text = "Auto Collect"
})
FarmTab.Toggle({
	Text = "Infinite Money",
	Callback = function(Value)
		collectmoney = Value
		while collectmoney and Wait() do
            if collectmoney then
	        	S.Replicated.Remotes.DigEvent:FireServer("hello")
            end
		end
	end,
	Enabled = false
})
FarmTab.Toggle({
	Text = "Infinite Gems",
	Callback = function(Value)
		collectgems = Value
		while collectgems and Wait() do
            if collectgems then
	         	S.Replicated.Remotes.GemEvent:FireServer(11, "bye")
            end
		end
	end,
	Enabled = false
})
FarmTab.Toggle({
	Text = "Infinite",
	Callback = function(Value)
		Infiniteitems = Value
		while Infiniteitems and Wait() do
			if Infiniteitems then
                if infiniteoptions == "Triple Dominous" then
                    S.Replicated.Remotes.SpinPrizeEvent:FireServer(4)
                elseif infiniteoptions == "Spins" then
                    S.Replicated.Remotes.SpinPrizeEvent:FireServer(10)
                elseif infiniteoptions == "Cash" then
                    S.Replicated.Remotes.SpinPrizeEvent:FireServer(2)
                elseif infiniteoptions == "Gems" then
                    S.Replicated.Remotes.SpinPrizeEvent:FireServer(1)
                elseif infiniteoptions == "x10 cash" then
                    S.Replicated.Remotes.SpinPrizeEvent:FireServer(8)
                end
			end
		end
	end,
	Enabled = false
})
FarmTab.Dropdown({
	Text = "Infinite Options",
	Callback = function(Value)
		infiniteoptions = Value
	end,
	Options = {"Triple Dominous", "Spins", "Cash", "Gems", "x10 cash"},
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = "Select the option to disable or enable teleporting to the sell area!"
			})
		end
	}
})
local function getcurrentcoinammount()
    for i, v in pairs(ME.PlayerGui.MainGui.UILeft.CashGui:GetChildren()) do
        if v.Name == 'CashAmount' then
            print(parseCost(v.Text))
            return parseCost(v.Text)
        end
    end
end
local function autobuypickixe(Value)
    getcurrentcoinammount()
    wait(0.3)
    local excludeNames = {"UIGridLayout", "UIPadding", "Hover", "PopulatePickaxes", "Temp"}
    for i, v in pairs(ME.PlayerGui.MainGui.PickaxesFrame.ScrollingFrame:GetChildren()) do
        if not table.find(excludeNames, v.Name) and Value then
            if v.Frame.CostFrame:FindFirstChild('TextLabel') and v.Frame.CostFrame.TextLabel.Text == "Owned" and v.Frame.CostFrame.TextLabel.Text == "Active" then
            elseif v.Frame.CostFrame:FindFirstChild('TextLabel') and Value then
                print(parseCost(v.Frame.CostFrame.TextLabel.Text))
                if parseCost(v.Frame.CostFrame.TextLabel.Text) and parseCost(v.Frame.CostFrame.TextLabel.Text) <= parseCost(getcurrentcoinammount()) and Value then
                    S.Replicated.Remotes.BuyPickaxeEvent:FireServer(v.Name)
                end
            end
        end
    end
end
FarmTab.TabTitle({
	Text = "Auto Buy Cheapest Pickaxe"
})
FarmTab.Toggle({
	Text = "Buy Pickaxes",
	Callback = function(Value)
		BuyPickaxe = Value
		while BuyPickaxe and Wait() do
			if BuyPickaxe then
                autobuypickixe(BuyPickaxe)
			end
		end
	end,
	Enabled = false
})
FarmTab.TabTitle({
	Text = "Auto Hatch/Buy Eggs"
})
local eggoptions = "Basic Egg"
FarmTab.Toggle({
	Text = "Hatch Eggs",
	Callback = function(Value)
		egghatch = Value
		while egghatch and Wait() do
			if egghatch then
                if eggoptions == "Basic Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World1.Prompts.Eggs.Egg1)
                elseif eggoptions == "Crystal Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World1.Prompts.Eggs.Egg2)
                elseif eggoptions == "Metal Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World1.Prompts.Eggs.Egg3)
                elseif eggoptions == "Bone Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World2.Prompts.Eggs.Egg4)
                elseif eggoptions == "Desert Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World2.Prompts.Eggs.Egg5)
                elseif eggoptions == "Mythic Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World2.Prompts.Eggs.RobuxEgg)
                elseif eggoptions == "Glacier Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World3.Prompts.Eggs.Egg6)
                elseif eggoptions == "Ocean Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World3.Prompts.Eggs.Egg7)
                elseif eggoptions == "Demon Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World4.Prompts.Eggs.Egg8)
                elseif eggoptions == "Devil Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World4.Prompts.Eggs.Egg9)
                elseif eggoptions == "Jungle Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World5.Prompts.Eggs.Egg10)
                elseif eggoptions == "Brick Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World5.Prompts.Eggs.Egg11)
                elseif eggoptions == "Rainbow Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World6.Prompts.Eggs.Egg12)
                elseif eggoptions == "Wizard Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World6.Prompts.Eggs.Egg13)
                elseif eggoptions == "Ocean Egg2" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World7.Prompts.Eggs.Egg14)
                elseif eggoptions == "Coral Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World7.Prompts.Eggs.Egg15)
                elseif eggoptions == "Night Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World8.Prompts.Eggs.Egg16)
                elseif eggoptions == "Space Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World8.Prompts.Eggs.Egg17)
                elseif eggoptions == "Jewel Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World9.Prompts.Eggs.Egg18)
                elseif eggoptions == "Mine Egg" then
                    S.Replicated.PetRemotes.HatchServer:InvokeServer(workspace.World9.Prompts.Eggs.Egg19)
                end
			end
		end
	end,
	Enabled = false
})
FarmTab.Dropdown({
	Text = "Eggs",
	Callback = function(Value)
		eggoptions = Value
	end,
	Options = {"Basic Egg", "Crystal Egg", "Metal Egg", "Bone Egg", "Desert Egg", "Mythic Egg", "Glacier Egg", "Ocean Egg", "Demon Egg", "Devil Egg", "Jungle Egg", "Brick Egg", "Rainbow Egg", "Wizard Egg", "Ocean Egg2", "Coral Egg", "Night Egg", "Space Egg", "Jewel Egg", "Mine Egg"}
})
















local DropdownsWithSamePath = {}
for i, v in pairs(ActiveDropdowns) do
	if not DropdownsWithSamePath[v.Path] then
		DropdownsWithSamePath[v.Path] = {}
	end
	table.insert(DropdownsWithSamePath[v.Path], v)
end
 
for path, dropdowns in pairs(DropdownsWithSamePath) do
	path.ChildAdded:Connect(function(instance)
		for _, dropdown in pairs(dropdowns) do
			dropdown.Callbacks.Added(dropdown, instance)
		end
	end)
 
	path.ChildRemoved:Connect(function(instance)
		for _, dropdown in pairs(dropdowns) do
			dropdown.Callbacks.Removed(dropdown, instance)
		end
	end)
 
	for _, instance in pairs(path:GetChildren()) do
		for _, dropdown in pairs(dropdowns) do
			dropdown.Callbacks.Added(dropdown, instance)
		end
    end
end
 
 -- Periodically update the dropdowns if needed
S.RunService.Heartbeat:Connect(function()
	for _, dropdown in pairs(ActiveDropdowns) do
		if dropdown.NeedsUpdate and tick() - dropdown.LastUpdate >= dropdown.RateLimit then
			dropdown.dropdown:SetOptions(dropdown.Data)
			dropdown.LastUpdate = tick()
			dropdown.NeedsUpdate = false
		end
	end
end)

local LiveStats = {}
local PlayerStats = MaterialGUI.Stats.New({
	Title = "Player"
})
PlayerStats.TabTitle({
	Text = "Player"
})
PlayerStats.Label({
	Text = "Player Name: " .. ME.Name
})
PlayerStats.Label({
	Text = "Player ID: " .. ME.UserId
})
LiveStats["Team"] = {
	Label = PlayerStats.Label({
		Text = "Team: " .. (ME.Team and ME.Team.Name or ME.Neutral and "Neutral" or "None")
	}),
	Callback = function()
		LiveStats["Team"].Label.SetText("Team: " .. (ME.Team and ME.Team.Name or ME.Neutral and "Neutral" or "None"))
	end
}
PlayerStats.TabTitle({
	Text = "Character"
})
LiveStats["Health"] = {
	Label = PlayerStats.Label({
		Text = "Health: " .. ME.Humanoid.Health
	}),
	Callback = function()
		LiveStats["Health"].Label.SetText("Health: " .. ME.Humanoid().Health)
	end
}
LiveStats["WalkSpeed"] = {
	Label = PlayerStats.Label({
		Text = "Walkspeed: " .. ME.Humanoid.WalkSpeed
	}),
	Callback = function()
		LiveStats["WalkSpeed"].Label.SetText("Walkspeed: " .. ME.Humanoid().WalkSpeed)
	end
}
LiveStats["JumpPower"] = {
	Label = PlayerStats.Label({
		Text = "Jumppower: " ..  ME.Humanoid.JumpPower
	}),
	Callback = function()
		LiveStats["JumpPower"].Label.SetText("Jumppower: " .. ME.Humanoid().JumpPower)
	end
}
LiveStats["Equipped Tool"] = {
	Label = PlayerStats.Label({
		Text = "Equipped Tool: " .. (ME.C:FindFirstChildOfClass("Tool") and ME.C:FindFirstChildOfClass("Tool").Name or "None")
	}),
	Callback = function()
		LiveStats["Equipped Tool"].Label.SetText("Equipped Tool: " .. (ME.C:FindFirstChildOfClass("Tool") and ME.C:FindFirstChildOfClass("Tool").Name or "None"))
	end
}
PlayerStats.TabTitle({
	Text = "Position"
})
LiveStats["PositionX"] = {
	Label = PlayerStats.Label({
		Text = "Position X: " .. ME.Root.Position.X
	}),
	Callback = function()
		LiveStats["PositionX"].Label.SetText("Position X: " .. ME.Root.Position.X)
	end
}
LiveStats["PositionY"] = {
	Label = PlayerStats.Label({
		Text = "Position Y: " .. ME.Root.Position.Y
	}),
	Callback = function()
		LiveStats["PositionY"].Label.SetText("Position Y: " .. ME.Root.Position.Y)
	end
}
LiveStats["PositionZ"] = {
	Label = PlayerStats.Label({
		Text = "Position Z: " .. ME.Root.Position.Z
	}),
	Callback = function()
		LiveStats["PositionZ"].Label.SetText("Position Z: " .. ME.Root.Position.Z)
	end
}
local GameStats = MaterialGUI.Stats.New({
	Title = "Game"
})
GameStats.TabTitle({
	Text = "Game"
})
GameStats.Label({
	Text = "Game Name: " .. S.MarketplaceInfo.Name
})
GameStats.Label({
	Text = "Place ID: " .. game.PlaceId
})
GameStats.Label({
	Text = "Job ID: " .. game.JobId
})
GameStats.Label({
	Text = "Game Last Updated: " .. math.floor((os.time() - parse_json_date(S.MarketplaceInfo.Updated)) / 86400) .. " days ago"
})
local ScriptCounterTimer = 1
local GameCounterTimer = math.floor(S.RunService.Stepped:Wait()) or 0
local function SecondstoYear(number)
	local years = math.floor(number / 31536000)
	local days = math.floor((number / 86400) - (years * 365))
	local hours = math.floor((number / 3600) - (years * 365 * 24) - (days * 24))
	local minutes = math.floor((number / 60) - (years * 365 * 24 * 60) - (days * 24 * 60) - (hours * 60))
	local seconds = math.floor(number - (years * 365 * 24 * 60 * 60) - (days * 24 * 60 * 60) - (hours * 60 * 60) - (minutes * 60))
	if years > 0 then
		return string.format("%d year" .. (years == 1 and "" or "s") .. ", %d day" .. (days == 1 and "" or "s") .. ", %d hour" .. (hours == 1 and "" or "s") .. ", %d minute" .. (minutes == 1 and "" or "s") .. " and %d second" .. (seconds == 1 and "" or "s"), years, days, hours, minutes, seconds)
	elseif days > 0 then
		return string.format("%d day" .. (days == 1 and "" or "s") .. ", %d hour" .. (hours == 1 and "" or "s") .. ", %d minute" .. (minutes == 1 and "" or "s") .. " and %d second" .. (seconds == 1 and "" or "s"), days, hours, minutes, seconds)
	elseif hours > 0 then
		return string.format("%d hour" .. (hours == 1 and "" or "s") .. ", %d minute" .. (minutes == 1 and "" or "s") .. " and %d second" .. (seconds == 1 and "" or "s"), hours, minutes, seconds)
	elseif minutes > 0 then
		return string.format("%d minute" .. (minutes == 1 and "" or "s") .. " and %d second" .. (seconds == 1 and "" or "s"), minutes, seconds)
	else
		return string.format("%d second" .. (seconds == 1 and "" or "s"), seconds)
	end
end
local ScriptCounter = GameStats.Label({
	Text = "Script Used For: "  .. SecondstoYear(ScriptCounterTimer)
})
local GameCounter = GameStats.Label({
	Text = "Game Played For: " .. SecondstoYear(GameCounterTimer)
})
coroutine.wrap(function()
	while wait(1) and ScriptCounter and GameCounter do
		ScriptCounterTimer = ScriptCounterTimer + 1
		ScriptCounter.SetText("Script Used For: " .. SecondstoYear(ScriptCounterTimer))
		GameCounterTimer = math.floor(S.RunService.Stepped:Wait()) or 0
		GameCounter.SetText("Game Played For: " .. SecondstoYear(GameCounterTimer))
	end
end)()

local NetworkStats = MaterialGUI.Stats.New({
	Title = "Network"
})
NetworkStats.TabTitle({
	Text = "Network"
})
LiveStats["Data Ping"] = {
	Label = NetworkStats.Label({
		Text = "Data Ping: " .. S.Stats.Network.ServerStatsItem["Data Ping"]:GetValue() .. "ms"
	}),
	Callback = function()
		LiveStats["Data Ping"].Label.SetText("Data Ping: " .. S.Stats.Network.ServerStatsItem["Data Ping"]:GetValue() .. "ms")
	end
}
LiveStats["Ping"] = {
	Label = NetworkStats.Label({
		Text = "Ping: " .. S.Stats.Network.ServerStatsItem["Ping"]:GetValue() .. "ms"
	}),
	Callback = function()
		LiveStats["Ping"].Label.SetText("Ping: " .. S.Stats.Network.ServerStatsItem["Ping"]:GetValue() .. "ms")
	end
}
local StatsRefreshDelay = 10--ReturnFSValue("StatsRefreshDelay", 10)
coroutine.wrap(function()
	while wait(StatsRefreshDelay/10) do
		for i, v in pairs(LiveStats) do
			coroutine.wrap(pcall)(v.Callback)
		end
	end
end)()
MaterialGUI.FPSTab()
local Settings = MaterialGUI.New({
	Title = "Settings",
	--ID = "9595271137",
	Icon = "rbxassetid://10734950309"
})
Settings.TabTitle({
	Text = "Created by vfvo (.vfvo)"
})
Settings.TabTitle({
	Text = "Discord: https://discord.gg/" .. _G.Vanities.RIP
})
Settings.Button({
	Text = "Copy RIP Discord Link",
	Callback = function()
		if not ExecFuncs.setclip then
			Notify("Error", "Copy to clipboard is not supported on this exploit")
		else
			ExecFuncs.setclip("https://discord.gg/" .. _G.Vanities.RIP)
			Notify("Success", "Copied to clipboard")
		end
	end,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Copies the discord link to your clipboard"
			})
		end
	}
})
Settings.Button({
	Text = "Join RIP Discord Server",
	Callback = function()
		JoinDiscord(_G.Vanities.RIP)
	end,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Joins the discord server"
			})
		end
	}
})
Settings.TabTitle({
	Text = "Partnered with SirHurt V5"
})
Settings.TabTitle({
	Text = "Discord: https://discord.gg/" .. _G.Vanities.SirHurt
})
Settings.Button({
	Text = "Copy SirHurt V5 Discord Link",
	Callback = function()
		if not ExecFuncs.setclip then
			Notify("Error", "Copy to clipboard is not supported on this exploit")
		else
			ExecFuncs.setclip("https://discord.gg/" .. _G.Vanities.SirHurt)
			Notify("Success", "Copied to clipboard")
		end
	end,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Copies the SirHurt V5 discord link to your clipboard\n\nSirHurt V5 is a paid exploit that has been around since 2015, it is the cheapest paid exploit out there at $2 a week and definitely worth the cost, it can keep up with all the other executors and if not their developers are open ears to adding anything you need."
			})
		end
	}
})
Settings.Button({
	Text = "Join SirHurt V5 Discord Server",
	Callback = function()
		JoinDiscord(_G.Vanities.SirHurt)
	end,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Joins the SirHurt V5 discord server\n\nSirHurt V5 is a paid exploit that has been around since 2015, it is the cheapest paid exploit out there at $2 a week and definitely worth the cost, it can keep up with all the other executors and if not their developers are open ears to adding anything you need."
			})
		end
	}
})
Settings.TabTitle({
	Text = "Settings"
})
Settings.Slider({
	Text = "Stats Refresh Delay",
	Callback = function(Value)
		StatsRefreshDelay = Value
		--SetFSValue("StatsRefreshDelay", Value)
	end,
	Min = 0,
	Max = 10,
	Def = StatsRefreshDelay,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Sets the delay for the stats to refresh (in milliseconds)"
			})
		end
	}
})
local FastestWaitLabel = Settings.Label({
	Text = "Fastest Wait"
})
local FastestWaitSpeedLabel = Settings.Label({
    Text = "Fastest Wait Speed: 0"
})
coroutine.wrap(function()
    while wait(1) and FastestWaitLabel and FastestWaitSpeedLabel do
        if CurrentFastest then
            FastestWaitLabel.SetText("Fastest Wait (Currently): " .. CurrentFastest)
        end
        if CurrentFastestNumber ~= 0 then
            FastestWaitSpeedLabel.SetText("Fastest Wait Speed: " .. CurrentFastestNumber)
        end
    end
end)()
Settings.Slider({
	Text = "Check Fastest Speed Every Amount Of Minutes",
	Callback = function(Value)
		CheckWithin = Value
	end,
	Min = 1,
	Max = 30,
	Def = CheckWithin,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Checks the fastest wait speed every amount of minutes"
			})
		end
	}
})
Settings.Dropdown({
	Text = "Set Fastest Wait To",
	Callback = function(Value)
		Fastest = Value
		Notify("Fastest Wait", "Switching Method to " .. Value)
	end,
	Options = {"task.wait", "RenderStepped", "Stepped", "Heartbeat", "wait"},
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Sets the fastest wait speed to the method selected"
			})
		end
	}
})
Settings.Toggle({
	Text = "Force Fastest Wait",
	Callback = function(Value)
		ForceOne = Value
	end,
	Enabled = false,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Forces the fastest wait speed to the method selected"
			})
		end
	}
})
Settings.TabTitle({
    Text = "Teleport Method"
})
Settings.Toggle({
    Text = "Force Teleport Method",
    Callback = function(Value)
        ForceMethod = Value
    end,
    Enabled = false,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Forces the teleport method to the method selected below"
			})
		end
	}
})
Settings.Dropdown({
    Text = "Teleport Method",
    Callback = function(Value)
        ForcedMethod = Value
    end,
    Options = {"CFrame", "MoveTo", "SetPrimaryPartCFrame", "Tween", "Walk To"},
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Sets the teleport method to the method selected"
			})
		end
	}
})
Settings.Label({
    Text = "Tween"
})
Settings.Slider({
    Text = "Tween Speed",
    Callback = function(Value)
        TweenSpeed = Value
    end,
    Min = 1,
    Max = 1000,
    Def = TweenSpeed,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Sets the tween speed"
			})
		end
	}
})
Settings.TextField({
    Text = "Custom Input Tween Speed",
    Callback = function(Value)
        TweenSpeed = tonumber(Value)
    end,
	Menu = {
		Description = function()
			MaterialGUI.Banner({
				Text = Logo .. "Sets the tween speed to the value inputted"
			})
		end
	}
})
if hookfunction and not IlIlIIlIIlIlIlIIlIlIIlIlIlIIlIIlIl then
    local origHookFunction = clonefunction(hookfunction)
    origHookFunction(hookfunction, function(func, newfunc, key)
        if key and key == EncrytionKey then
            return origHookFunction(func, newfunc)
        else
            KickME("HookFunction being used after launch")
        end
    end)
end
if restorefunction and not IlIlIIlIIlIlIlIIlIlIIlIlIlIIlIIlIl then
    local origRestoreFunction = clonefunction(restorefunction)
    hookfunction(restorefunction, function(func, key)
        if key and key == EncrytionKey then
            return origRestoreFunction(func)
        else
            KickME("RestoreFunction used hooked after launch")
        end
    end, EncrytionKey)
end