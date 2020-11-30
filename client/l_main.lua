--[[

	██╗░░░░░░█████╗░░█████╗░████████╗░░░██╗░██╗░░█████╗░░░███╗░░░█████╗░░░███╗░░
	██║░░░░░██╔══██╗██╔══██╗╚══██╔══╝██████████╗██╔══██╗░████║░░██╔══██╗░████║░░
	██║░░░░░███████║██║░░██║░░░██║░░░╚═██╔═██╔═╝██║░░██║██╔██║░░██║░░██║██╔██║░░
	██║░░░░░██╔══██║██║░░██║░░░██║░░░██████████╗██║░░██║╚═╝██║░░██║░░██║╚═╝██║░░
	███████╗██║░░██║╚█████╔╝░░░██║░░░╚██╔═██╔══╝╚█████╔╝███████╗╚█████╔╝███████╗
	╚══════╝╚═╝░░╚═╝░╚════╝░░░░╚═╝░░░░╚═╝░╚═╝░░░░╚════╝░╚══════╝░╚════╝░╚══════╝
	
]]


LAOT      			  = {}

LAOT.PlayerLoaded	  = false
LAOT.PlayerData 	  = {}

LAOT.Game   		  = {}
LAOT.Utils  		  = {}
LAOT.Streaming  	  = {}

AddEventHandler('LAOTCore:getSharedObject', function(cb)
	cb(LAOT)
end)

RegisterNetEvent("LAOTCore:playerLoaded")
AddEventHandler("LAOTCore:playerLoaded", function()
	LAOT.PlayerData["isBusy"] = false -- Kişi müsait mi, etkileşime girebilir mi? || Is player busy, is he/she can interact?
	TriggerServerEvent("LAOTCore:Server:CheckDiscordID")

	Citizen.Wait(250)
	LAOT.PlayerLoaded = true
end)

Citizen.CreateThread(function() -- After load
	TriggerEvent("LAOTCore:playerLoaded")
end)

function getSharedObject()
	return LAOT
end

LAOT.GetPlayerData = function()
	return LAOT.PlayerData
end

LAOT.SetPlayerData = function(data, val)
	LAOT.PlayerData[data] = val
end

LAOT.Streaming.LoadModel = function(hash)
	if C.Debug then return print(_U("LAOT_R_M_HASH").. ''.. hash) end
	model = GetHashKey(hash)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)
	end

	return model
end

LAOT.Streaming.LoadAnimDict = function(dict, cb)
	if C.Debug then return print(_U("LAOT_R_A_DICT").. ''.. dict) end
	while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
	end
	
	if cb ~= nil then
		cb()
	end
end

LAOT.DrawText3D = function(x, y, z, text, scale)
    if scale then SetTextScale(scale, scale) else SetTextScale(0.35, 0.35) end
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

LAOT.DrawSubtitle = function(text, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandPrint(time, 1)
end

LAOT.Game.Teleport = function(fadeTime, x, y, z, h, cb)
	local ply = GetPlayerServerId(PlayerId())
	local entity = GetPlayerFromServerId(ply)

	DoScreenFadeOut(fadeTime)
	Citizen.Wait(fadeTime)
	
	StartPlayerTeleport(entity, x, y, z, h, false, true, false)
	
	Citizen.Wait(fadeTime)
	DoScreenFadeIn(fadeTime)

	if cb ~= nil then
		cb()
	end
end

LAOT.Notification = function(type, text)
	if C.Myhtic_Notify then
		exports['mythic_notify']:DoHudText(type, text)
	end
end

LAOT.DefaultNotification = function(text)
	AddTextEntry('laotNotification', text)
	SetNotificationTextEntry('laotNotification')
	DrawNotification(false, true)
end


RegisterNetEvent("LAOTCore:Client:CheckDiscordID")
AddEventHandler("LAOTCore:Client:CheckDiscordID", function(discordID)
	LAOT.PlayerData["discord"] = discordID
end)

RegisterNetEvent("LAOTCore:Notification")
AddEventHandler("LAOTCore:Notification", function(type, text)
	LAOT.Notification(type, text)
end)
