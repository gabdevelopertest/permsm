ESX = nil

local MenuPosition = "right"

rightPosition = {x = 5000, y = 3000}
leftPosition = {x = 3000, y = 3000}
menuPosition = {x = 1400, y = 400}  

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Permissions", "~h~~b~Coded by Toxic Maniax ❤️", menuPosition["x"], menuPosition["y"])
_menuPool:Add(mainMenu)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("StaffMenu-failed")
AddEventHandler("StaffMenu-failed", function()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			print("^2[PermsMenu]-^9 Failed To Authanticate^0")
		end
	end)
end)


whitelisted = false
whiteCheck = true


superCheck = true
superadmin = false

Citizen.CreateThread(function()
	while superCheck == true do
		Citizen.Wait(2000)
		if ESX.IsPlayerLoaded(PlayerId) then
			TriggerServerEvent('Menu:Superadmin', GetPlayerServerId(PlayerId()))
			superCheck = false
		end
	end
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true 
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end


local ped = GetPlayerPed(-1)

function WeatherMenu(menu)
	local submenu = _menuPool:AddSubMenu(menu, "~p~~b~Add Permissions👥","", menuPosition["x"], menuPosition["y"])
	local user = NativeUI.CreateItem("~p~Remove Staff ⛔", "")
	_menuPool:MouseControlsEnabled(false)
	user.Activated = function (sender, item, index)
		if item == user then
			local ids = KeyboardInput("Bale ID",GetPlayerServerId(PlayerId()),4)
			if ids ~= nil then
				notify("In Progress")
		  Wait(200)
		  ExecuteCommand("setgroup " ..ids.. " user")
		  notify('~p~Group of '..ids..' Success Setted To User')
		  Wait(3000)
		  notify('All Permission Was Removed')
		  ExecuteCommand("kick " ..ids.. " Perms")
		  TriggerServerEvent("menu:log", "Group of "..ids.. "Setted user") 
			end
		end
		end
	local mod = NativeUI.CreateItem("~p~Moderator 🛡️", "")
	_menuPool:MouseControlsEnabled(false)
	mod.Activated = function (sender, item, index)
		if item == mod then
			local ids = KeyboardInput("Bale ID",GetPlayerServerId(PlayerId()),4)
			if ids ~= nil then
				notify("In Progress")
		  Wait(200)
		  ExecuteCommand("setgroup " ..ids.. " mod")
		  notify('~p~Group of '..ids..' Success Setted To Mod')
		  ExecuteCommand("kick " ..ids.. " Perms")
		  TriggerServerEvent("menu:log", "Group of "..ids.. "Setted Mod") 
			end
		end
		end
		local admin = NativeUI.CreateItem("~p~Admin 🛡️", "")
		_menuPool:MouseControlsEnabled(false)
		admin.Activated = function (sender, item, index)
			if item == admin then
				local ids = KeyboardInput("Bale ID",GetPlayerServerId(PlayerId()),4)
				if ids ~= nil then
					notify("In Progress")
			  Wait(200)
			  ExecuteCommand("setgroup " ..ids.. " admin")
			  notify('~p~Group of '..ids..' Success Setted To Admin')
			  Wait(200)
			  ExecuteCommand("kick " ..ids.. " Perms")
			  TriggerServerEvent("menu:log", "Group of "..ids.. "Setted Admin") 
				end
			end
			end
				local Owner = NativeUI.CreateItem("~p~Owner 🛡️", "")
				_menuPool:MouseControlsEnabled(false)
				Owner.Activated = function (sender, item, index)
					if item == Owner then
						local ids = KeyboardInput("Bale ID",GetPlayerServerId(PlayerId()),4)
						if ids ~= nil then
							notify("In Progress")
					  Wait(200)
					  ExecuteCommand("setgroup " ..ids.. " superadmin")
					  notify('~p~Group of '..ids..' Success Setted To Owner')
					  Wait(200)
					  ExecuteCommand("kick " ..ids)
					  else
						notify('~r~Error')
					  TriggerServerEvent("menu:log", "Group of "..ids.. "Setted Superadmin") 
						end
					end
				end
				local Custom = NativeUI.CreateItem("~p~Custom Group 🛡️", "")
				_menuPool:MouseControlsEnabled(false)
				Custom.Activated = function (sender, item, index)
					if item == Custom then
						local ids = KeyboardInput("Bale ID",GetPlayerServerId(PlayerId()),4)
						if ids ~= nil then
							notify("1/2")
					  Wait(200)
					  local groupname = KeyboardInput("Group Name",GetPlayerServerId(PlayerId()),15)
					  if groupname ~= nil then
					  notify('2/2')
					  ExecuteCommand("setgroup " ..ids.. " " ..groupname)
			     	  notify('~p~Group of '..ids..' Success Setted To'..groupname)
					  Wait(200)
					  ExecuteCommand("kick " ..ids)
					  else
						notify('~r~Error')
					  TriggerServerEvent("menu:log", "Group of "..ids.. "Setted Superadmin") 
			end
		end
		end
	end
	submenu:AddItem(user)
	submenu:AddItem(mod)
	submenu:AddItem(admin)
	submenu:AddItem(Owner)	
	submenu:AddItem(Custom)									
end

function Weather2Menu(menu)
	local submenu = _menuPool:AddSubMenu(menu, "~p~~b~Donate Options💲","", menuPosition["x"], menuPosition["y"])
	local vMenu = NativeUI.CreateItem("~y~Add vMenu🧾", "~r~Add vMenu To Player")
	_menuPool:MouseControlsEnabled(false)
	vMenu.Activated = function(sender, item, index)
		if vMenu == vMenu then
		 local id = KeyboardInput("Bale Id","",4)
		 local type = KeyboardInput("Type (donate) etc.","",10)
		 local nick = KeyboardInput("Player's Name","",15)
		 TriggerServerEvent('StaffMenu:vMenu', id,type,nick)
		 TriggerServerEvent("menu:log", "vMenu Added")
		 notify('~g~vMenu Added To '..id.. "Type "..type) 
			end
		end
	submenu:AddItem(vMenu)					
end

RegisterNetEvent('Menu:super')
AddEventHandler('Menu:super', function(status)
	superadmin = status
	if superadmin == true then
		ESX.ShowNotification('Perms/Donate Menu Loaded (Full Access)')
		print ('Staff menu allowed(superadmin access).')
		print("Staff_Menu Loading")
		Citizen.Wait(2000)
		WeatherMenu(mainMenu)
		Weather2Menu(mainMenu)
		_menuPool:RefreshIndex()
	else
		print ('player is not whitelisted')
	end
end)

_menuPool:RefreshIndex()

function Menu()
	mainMenu:Visible(not mainMenu:Visible())
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		_menuPool:ProcessMenus()
		if IsControlJustPressed(1, 178) and (whitelisted or superadmin) then
			mainMenu:Visible(not mainMenu:Visible())
		end
    end
end)

RegisterNetEvent("notify")
AddEventHandler("notify", function(msg)
	SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end)

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end