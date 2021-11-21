ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function SendWebhookMessageMenuStaff(webhook,message)
	if Config.webhook ~= "none" then
		PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

RegisterServerEvent("menu:log") 
AddEventHandler("menu:log", function(reason)
  	local name = GetPlayerName(source)
      local connect = {
            {
                ["color"] = 47479,
                ["title"] = reason,
                ["description"] = "Admin: "..name.."\n ID: "..source.." ",
                ["footer"] = {
                ["text"] = "StaffMenu-Menu",
                },
            }
        }
      PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({username = "StaffMenu-Menu-Logs", embeds = connect, avatar_url = Config.image}), { ['Content-Type'] = 'application/json' })  
end)

RegisterServerEvent("Menu:Superadmin")
AddEventHandler("Menu:Superadmin", function(playerId)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
		TriggerClientEvent("Menu:super", _source, true)
	end
end)

function inArray(value, array)
	for _,v in pairs(array) do
		if v == value then
			return true
		end
	end
	return false
end

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]
		return {
			identifier = identity['identifier'],
			name = identity['name'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height'],
			job = identity['job'],
			group = identity['group']
		}
	else
		return nil
	end
end

RegisterServerEvent("setgroup")
AddEventHandler("setgroup", function(USER, GROUP)
	local _source = source
	local name = GetPlayerName(_source)
	local target = GetPlayerName(USER)
	TriggerClientEvent('es_admin:setGroup', USER, GROUP)
end)

RegisterServerEvent("StaffMenu:vMenu")
AddEventHandler("StaffMenu:vMenu", function(target, type, nick)
	local identifier = GetPlayerIdentifiers(target)[1]
	local name = GetPlayerName(source)
	local targetp = GetPlayerName(target)
	local data = LoadResourceFile("vMenu", "/config/permissions.cfg")
	local data = data .."\nadd_principal identifier."..identifier.." group."..type.." #"..nick 
	SaveResourceFile("vMenu", "/config/permissions.cfg", data, -1)
	local name = GetPlayerName(source)
    local connect = {
        {
            ["color"] = 47479,
            ["title"] = "vMenu Add\nTo Player: "..targetp.."\nType: "..type.."",
            ["description"] = "Admin: "..name.."\n ID: "..source.." ",
            ["footer"] = {
            ["text"] = "StaffMenu",
            },
        }
    }
end)

function GetSteamID(source)
    local sid = false

    for _,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            sid = v
        end
    end

	return sid
end