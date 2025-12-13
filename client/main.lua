--[[

made by

╭╮╱╱╭━━━┳━━━┳━━━━╮
┃┃╱╱┃╭━╮┃╭━╮┃╭╮╭╮┃
┃┃╱╱┃┃╱┃┃┃╱┃┣╯┃┃╰╯
┃┃╱╭┫╰━╯┃┃╱┃┃╱┃┃
┃╰━╯┃╭━╮┃╰━╯┃╱┃┃
╰━━━┻╯╱╰┻━━━╯╱╰╯

Discord: laot7490

--]]

LAOT      				= {}

LAOT.PlayerLoaded	    = false
LAOT.PlayerData 	    = {}
LAOT.CurrentRequestId   = 0
LAOT.ServerCallbacks    = {}
LAOT.Functions          = {}

LAOT.Game   		    = {}
LAOT.Utils  		    = {}
LAOT.Streaming  	    = {}
LAOT.UI					= {} -- up coming.

AddEventHandler('LAOTCore:GetObject', function(cb)
	cb(LAOT)
end)

RegisterNetEvent("LAOTCore:PlayerLoaded")
AddEventHandler("LAOTCore:PlayerLoaded", function()
	Citizen.Wait(0)
end)

Citizen.CreateThread(function() -- After load
	LAOT.PlayerData["Busy"] = false -- Kişi müsait mi, etkileşime girebilir mi? || Is player busy, is he/she can interact?
	TriggerServerEvent("LAOTCore:Server:CheckIdentifiers")

	Citizen.Wait(850)
	LAOT.PlayerLoaded = true
	TriggerEvent("LAOTCore:PlayerLoaded")
end)

function GetObject()
	return LAOT
end

LAOT.Functions.GetPlayerData = function()
	return LAOT.PlayerData
end

LAOT.Functions.SetPlayerData = function(data, val)
	LAOT.PlayerData[data] = val
end

LAOT.Functions.GetPlayerServerId = function()
	return GetPlayerServerId(PlayerId())
end

LAOT.Functions.TriggerCallback = function(name, cb, ...)
	LAOT.ServerCallbacks[LAOT.CurrentRequestId] = cb

	TriggerServerEvent('LAOTCore:Server:TriggerServerCallback', name, LAOT.CurrentRequestId, ...)

	if LAOT.CurrentRequestId < 65535 then
		LAOT.CurrentRequestId = LAOT.CurrentRequestId + 1
	else
		LAOT.CurrentRequestId = 0
	end
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

LAOT.Functions.DrawText3D = function(x, y, z, text, scale) -- Font ve arkaplan değiştirildi. || Changed font and rect
	SetTextScale(0.30, 0.30)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0125, 0.025+ factor, 0.03, 15, 16, 17, 100)
end

LAOT.Functions.DrawSubtitle = function(text, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandPrint(time, 1)
end

LAOT.Functions.Teleport = function(fadeTime, x, y, z, h, cb)
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

LAOT.Functions.Notify = function(color, text, playsound)
	if color == "inform" then color = "#375EDA" end
	if color == "error" then color = "#A32C2F" end
	if color == "success" then color = "#22C054" end
    SendNUIMessage({
        type = "custom",
        color = color or "#eb4034",
		text = text or "Mesaj yok."
    })
    
	if playsound == true or playsound == nil then
		PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
	end
end

LAOT.Functions.ShowHelpNotification = function(msg, onlyThisFrame, sound, duration)
	AddTextEntry('LAOTHelpNotification', msg)

	if onlyThisFrame then
		DisplayHelpTextThisFrame('LAOTHelpNotification', false)
	else
		if sound == nil then 
			sound = true 
		end
		BeginTextCommandDisplayHelp('LAOTHelpNotification')
		EndTextCommandDisplayHelp(0, false, sound, duration or -1)
	end
end

RegisterNetEvent("LAOTCore:Client:CheckIdentifiers")
AddEventHandler("LAOTCore:Client:CheckIdentifiers", function(identifiers)
	if identifiers.steamid and identifiers.license then
		LAOT.PlayerData["identifiers"] = identifiers
		Citizen.Wait(500)
	end
end)

RegisterNetEvent("LAOTCore:Client:Notify")
AddEventHandler("LAOTCore:Client:Notify", function(type, text)
	LAOT.Functions.Notify(type, text)
end)

RegisterNetEvent('LAOTCore:Client:ServerCallback')
AddEventHandler('LAOTCore:Client:ServerCallback', function(requestId, ...)
	LAOT.ServerCallbacks[requestId](...)
	LAOT.ServerCallbacks[requestId] = nil
end)
