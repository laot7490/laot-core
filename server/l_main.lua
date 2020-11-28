LAOT = {}



Citizen.CreateThread( function()
    Citizen.Wait(1000)
    resourceName = GetCurrentResourceName()
    if resourceName ~= "laot-core" then 
        print("\n")
        print("^1[laot-core] ^0Lütfen script ismini değiştirmeyiniz.\n")
        print("https://github.com/laot7490/laot-core/releases/latest\n")
    end
  
    function laotVersionCheck(err,responseText, headers)
        local currentVersion = tonumber(C.Version)
        local newVersion = tonumber(responseText)

        if newVersion > currentVersion then
            print("\n")
            print("^1[laot-core] ^0En yeni versiyonu kullanmıyorsunuz lütfen en yeni versiyona güncelleyin.\n")
            print("https://github.com/laot7490/laot-core/releases/latest\n")
        end
        if newVersion < currentVersion then
            print("\n")
            print("^8[laot-core] Bozuk sistem dosyası, versiyon en yeni versiyondan yüksek veya bozulmuş.\n")
            print("https://github.com/laot7490/laot-core/releases/latest\n")
        end
        if newVersion == currentVersion then
            print("\n")
            print("^2[laot-core] ^0Sistem düzgün başlatıldı. Mevcut versiyon: v".. currentVersion)
        end
    end

    PerformHttpRequest("http://raw.githubusercontent.com/laot7490/versions/main/laot-core", laotVersionCheck, "GET")
end)

AddEventHandler('LAOTCore:getSharedObject', function(cb)
	cb(LAOT)
end)

function getSharedObject()
	return LAOT
end

RegisterNetEvent("LAOTCore:server:CheckDiscordID")
AddEventHandler("LAOTCore:server:CheckDiscordID", function(cb)
    local src = source
    local discordIdentifier

    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordIdentifier = tonumber(split(v, ":")[2])
            TriggerClientEvent("LAOTCore:client:CheckDiscordID", src, discordIdentifier)
        end
    end
end)

function split(str, pat)
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