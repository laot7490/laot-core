CheckVersion = function(Resource, CurVersion, Banner)
    Citizen.Wait(1500)       

    local function CheckVersionFromGithub(err, result, headers)
        if result then
            local Data = json.decode(result)
            local Cur = GetCurrentResourceName()

            if Banner then                                                      
                print(Banner)
            end

            if Data[Cur] then
                if Data[Cur] ~= CurVersion then
                    print("^3Script is not up-to-date, please update to newest version.")
                    print("^1v".. CurVersion .." ^0> ^2v".. Data[Cur] .."")
                else
                    print("^0Script is up-to-date.")
                end
            end
        end
    end

    PerformHttpRequest("https://raw.githubusercontent.com/laot7490/laot-versions/refs/heads/master/check.json", CheckVersionFromGithub, "GET")
end