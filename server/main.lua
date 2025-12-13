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

LAOT                 = {}

LAOT.ServerCallbacks = {}
LAOT.Functions       = {}
LAOT.JSON            = {}
LAOT.JSONData        = {}

AddEventHandler('LAOTCore:GetObject', function(cb)
	cb(LAOT)
end)

function GetObject()
	return LAOT
end

LAOT.Functions.CreateServerCallback = function(name, cb)
	LAOT.ServerCallbacks[name] = cb
end

LAOT.Functions.TriggerCallback = function(name, requestId, source, cb, ...)
	if LAOT.ServerCallbacks[name] then
		LAOT.ServerCallbacks[name](source, cb, ...)
	else
		print(('[laot-core] "%s" callback bulunmamasına rağmen oynatıldı.'):format(name))
	end
end

LAOT.JSON.Create = function(scriptName, fileName)
    if not LAOT.JSONData[scriptName .. "__".. fileName] then
        if scriptName and fileName then
            SaveResourceFile("laot-core", "/jsons/".. scriptName .."__".. fileName ..".json", json.encode({}), -1)
            LAOT.JSONData[scriptName .. "__".. fileName] = json.encode({})
        end
    else
        print(('^1[laot-core] ^0"%s" adlı bir json verisi zaten var olmasına rağmen oluşturulmaya çalışıldı.'):format(fileName))
    end
end

LAOT.JSON.GetData = function(scriptName, fileName)
    if scriptName and fileName then
        local jsonData = LoadResourceFile("laot-core", "/jsons/".. scriptName .."__".. fileName ..".json")
        return jsonData or "404"
    else
        print(('^1[laot-core] ^0"%s" adlı bir json verisi olmamasına rağmen verileri alınmaya çalışıldı.'):format(fileName))
    end
end

LAOT.JSON.Insert = function(scriptName, fileName, data)
    if scriptName and fileName then
        local jsonData = LoadResourceFile("laot-core", "/jsons/".. scriptName .."__".. fileName ..".json")
        if jsonData then
            local convertedData = json.decode(jsonData)
            table.insert(convertedData, data)
            SaveResourceFile("laot-core", "/jsons/".. scriptName .."__".. fileName ..".json", json.encode(convertedData), -1)
        end
    else
        print(('^1[laot-core] ^0"%s" adlı bir json verisi olmamasına rağmen verileri alınmaya çalışıldı.'):format(fileName))
    end
end

LAOT.JSON.Remove = function(scriptName, fileName, data_id)
    if scriptName and fileName then
        local jsonData = LoadResourceFile("laot-core", "/jsons/".. scriptName .."__".. fileName ..".json")
        if jsonData then
            local convertedData = json.decode(jsonData)
            table.remove(convertedData, data_id)
            SaveResourceFile("laot-core", "/jsons/".. scriptName .."__".. fileName ..".json", json.encode(convertedData), -1)
        end
    else
        print(('^1[laot-core] ^0"%s" adlı bir json verisi olmamasına rağmen verileri alınmaya çalışıldı.'):format(fileName))
    end
end

LAOT.Functions.GetPlayerIdentifiers = function(id)
    if id then
        data = {
            steamid  = "N/A",
            license  = "N/A",
            discord  = "N/A",
            xbl      = "N/A",
            liveid   = "N/A",
            ip       = "N/A",
        }
    
        for k,v in pairs(GetPlayerIdentifiers(id))do    
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                data.steamid = v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then
                data.license = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                data.xbl  = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                data.ip = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                data.discord = tonumber(LAOT.Functions.Split(v, ":")[2])
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                data.liveid = v
            end
        end
    
        return data
    end
end

RegisterServerEvent('LAOTCore:Server:TriggerServerCallback')
AddEventHandler('LAOTCore:Server:TriggerServerCallback', function(name, requestId, ...)
	local playerId = source

	LAOT.Functions.TriggerCallback(name, requestId, playerId, function(...)
		TriggerClientEvent('LAOTCore:Client:ServerCallback', playerId, requestId, ...)
	end, ...)
end)

RegisterNetEvent("LAOTCore:Server:CheckIdentifiers")
AddEventHandler("LAOTCore:Server:CheckIdentifiers", function(cb)
    local src = source
    local identifiers = LAOT.Functions.GetPlayerIdentifiers(src)

    TriggerClientEvent("LAOTCore:Client:CheckIdentifiers", src, identifiers)
end)

LAOT.Functions.Split = function(str, pat)
    local t = {}
    local fpat = "(.-)" .. pat
    local last_end = 1
    local s, e, cap = str:find(fpat, 1)
    while s do
       if s ~= 1 or cap ~= "" then
          table.insert(t,cap)
       end
       last_end = e+1
       s, e, cap = str:find(fpat, last_end)
    end
    if last_end <= #str then
       cap = str:sub(last_end)
       table.insert(t, cap)
    end
    return t
end

Citizen.CreateThread( function()
    Citizen.Wait(1000)
    resourceName = GetCurrentResourceName()
    if resourceName ~= "laot-core" then 
        print("\n")
        print("^1[laot-core] ^0Lütfen script ismini değiştirmeyiniz.\n")
        print("https://github.com/LAOT7490/LAOT-core/releases/latest\n")
    end
  
    CheckVersion = function(err, result, headers)

        if result then

            local data = json.decode(result)

            if data.latestVersion ~= C.Version then
                print("\n")
                if C.Locale == 'tr' then
                    print("^8[laot-core] ^0En yeni versiyonu kullanmıyorsunuz lütfen en yeni versiyona güncelleyin.\n")
                    print("^2[laot-core] ^0Güncel Sürüm v".. data.latestVersion .." Yenilikleri: \n".. data.news .. "\n")
                elseif C.Locale == 'en' then
                    print("^8[laot-core] ^0You are not using the latest version, please update.\n")
                    print("^2[laot-core] ^0Latest version v".. data.latestVersion .." News: \n".. data.newsEN .. "\n")
                end
                print("https://github.com/laot7490/laot-core/releases/latest\n")
            end
            if data.latestVersion == C.Version then
                print("\n")
                if C.Locale == 'tr' then
                    print("^2[laot-core] ^0Sistem düzgün başlatıldı. Mevcut versiyon: v".. data.latestVersion)
                elseif C.Locale == 'en' then
                    print("^2[laot-core] ^0System started successfully. Current version: v".. data.latestVersion)
                end
            end

        end
    end


    PerformHttpRequest("http://api.laot.online/core.json", CheckVersion, "GET")
end)