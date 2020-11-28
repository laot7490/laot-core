LAOT      			  = {}

LAOT.Player 		  = {}

LAOT.Game   		  = {}
LAOT.Utils  		  = {}
LAOT.Streaming  	  = {}

AddEventHandler('LAOTCore:getSharedObject', function(cb)
	cb(LAOT)
end)

RegisterNetEvent("LAOTCore:playerLoaded")
AddEventHandler("LAOTCore:playerLoaded", function()
	TriggerServerEvent("laot:server:CheckDiscordID")
end)

Citizen.CreateThread(function() -- After load
	TriggerEvent("LAOTCore:playerLoaded")
end)

function getSharedObject()
	return LAOT
end

LAOT.GetPlayerData = function()
	return LAOT.Player
end

LAOT.Streaming.LoadModel = function(hash)
	if C.Debug then print("Hash yukleniyor: " .. hash .."") end
	model = GetHashKey(hash)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)
	end

	return model
end

LAOT.Streaming.LoadAnimDict = function(dict, cb)
	if C.Debug then print("Anim dict yukleniyor: " .. dict .."") end
	while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
	end
	
	if cb ~= nil then
		cb()
	end
end

LAOT.DrawText3D = function(x, y, z, text)
    SetTextScale(0.35, 0.35)
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

RegisterNetEvent("laot:client:CheckDiscordID")
AddEventHandler("laot:client:CheckDiscordID", function(discordID)
	LAOT.Player["discord"] = discordID
end)

RegisterNetEvent("laot:Notification")
AddEventHandler("laot:Notification", function(type, text)
	LAOT.Notification(type, text)
end)