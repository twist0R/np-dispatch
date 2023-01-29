local police_table = {}
local dispatch_table = {}
local playername
local playercode
local menu = false
local enable_coord = false
local html
PlayerData  = {}

-- Converted and optmized by ~ Ghost 

RegisterNetEvent("np-jobmanager:playerBecameJob")
AddEventHandler("np-jobmanager:playerBecameJob", function(job, name, notify)
    if job ~= "police" then
        TriggerServerEvent("dispatch:delete-police", playercode)
    end
end)

--- nui callback --- 

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    menu = false

    TriggerServerEvent("dispatch:police_tableSave")
end)

RegisterNUICallback('close-callsign', function(data, cb)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    TriggerServerEvent("dispatch:force:closeithink")
end)

RegisterNUICallback('set-coords', function(data, cb)
    local number2 = tonumber(data.number)
    local x = dispatch_table[number2].x
    local y = dispatch_table[number2].y

    SetNewWaypoint(x, y)
end)

RegisterNetEvent("dispatch:tasima-force-yeter")
AddEventHandler("dispatch:tasima-force-yeter", function()
    SendNUIMessage({
        action = "close-force"
    })

    Citizen.Wait(500)

    openMenuForce()
end)

RegisterNUICallback('save', function(data, cb)
    html = data.html
    Citizen.Wait(500)
    TriggerServerEvent("dispatch:html", html)
end)


RegisterNUICallback('table_ayril', function(data, cb)
    local name = data.name
    TriggerServerEvent("dispatch:table_ayril", name)
end)



RegisterNUICallback('change-vehicle', function(data, cb)
    TriggerServerEvent("dispatch:change-police", data)
end)

RegisterNUICallback('under-police', function(data, cb)
    TriggerServerEvent("dispatch:table_sv", data.owner, data.player)
end)

RegisterNUICallback('delete', function(data, cb)
    local name = data.name
    TriggerServerEvent("dispatch:delete-police", name)
end)

RegisterNUICallback('create_call', function(data, cb)
    TriggerServerEvent("dispatch:create-call", data.number)
end)

RegisterNUICallback('create_call-2', function(data, cb)
    TriggerServerEvent("dispatch:create-call", data.number)
end)

RegisterNUICallback('dismiss_call-2', function(data, cb)
    TriggerServerEvent("dispatch:dismiss-call-2", data.number)
end)

RegisterNUICallback('dismiss_call-1', function(data, cb)
    TriggerServerEvent("dispatch:dismiss-call-1", data.number)
end)

RegisterNUICallback('remove-call', function(data, cb)
    TriggerServerEvent("dispatch:remove-call", data.number)
end)

RegisterNUICallback('add_police-assign', function(data, cb)
    TriggerServerEvent("dispatch:add_police-assign", data.ronin)
end)

RegisterNUICallback('delete_police-assign', function(data, cb)
    TriggerServerEvent("dispatch:delete_police-assign", data.ronin)
end)

---- dmb fkcs
RegisterNetEvent("dispatch:add_police-assign_cl")
AddEventHandler("dispatch:add_police-assign_cl", function(osurcam)
    SendNUIMessage({
        action = "add_police-assign",
        allah = osurcam
    })
end)

RegisterNetEvent("dispatch:delete_police-assign_cl")
AddEventHandler("dispatch:delete_police-assign_cl", function(sus)
    SendNUIMessage({
        action = "delete_police-assign"
    })
end)

RegisterNetEvent("dispatch:create-call_cl")
AddEventHandler("dispatch:create-call_cl", function(test, test2, test3, test4)
    SendNUIMessage({
        action = "create_call",
        html = test2,
        call = test,
        c3value = test3,
        c4value = test4
    })
end)

RegisterNetEvent("dispatch:remove-ping")
AddEventHandler("dispatch:remove-ping", function(alah)
    SendNUIMessage({
        action = "remove-ping",
        number = alah
    })
end)


RegisterNetEvent("dispatch:remove-call_cl")
AddEventHandler("dispatch:remove-call_cl", function()
    SendNUIMessage({
        action = "remove-call"
    })
end)

RegisterNetEvent("dispatch:dismiss-call-2_cl")
AddEventHandler("dispatch:dismiss-call-2_cl", function()
    SendNUIMessage({
        action = "dismiss_call-2"
    })
end)

RegisterNetEvent("dispatch:close_ui_cl")
AddEventHandler("dispatch:close_ui_cl", function()
    if menu then 
        SendNUIMessage({
            action = "close-callsign"
        })
    end
    Citizen.Wait(300)

    if menu then
        SetNuiFocus(true, true)
        SetNuiFocusKeepInput(true)

        TriggerServerEvent("dispatch:get-police")
        TriggerServerEvent("dispatch:osurcam-html")

        Citizen.Wait(1000)
        SendNUIMessage({
            action = "open",
            table = police_table,
            player_code = playercode,
            player_name = playername,
            html = html
        })
    end
end)

RegisterNetEvent("getname-cl")
AddEventHandler("getname-cl", function(name)
    playername = name
end)

RegisterNetEvent("dispatch:delete-player")
AddEventHandler("dispatch:delete-player", function(name)
    SendNUIMessage({
        action = "delete-player",
        code = name
    })
end)

RegisterNetEvent("dispatch:get-police-cl")
AddEventHandler("dispatch:get-police-cl", function(allah, allah2)
    police_table = allah
    dispatch_table = allah2
end)

RegisterNetEvent("dispatch:get-html")
AddEventHandler("dispatch:get-html", function(dataa)
    html = dataa
    SendNUIMessage({
        action = "update-html",
        code = html
    })
end)

RegisterNetEvent("dispatch:delete-police_cl")
AddEventHandler("dispatch:delete-police_cl", function(allah)
    SendNUIMessage({
        action = "deleteallah",
        player_code = allah
    })
end)


function callsign_command(pCallsign, pName)
    if playercode == nil then 
        callSing(pCallsign, pName)
    else
        TriggerServerEvent("dispatch:delete-police_sv", playercode)

        callSing(pCallsign, pName)
    end
end

RegisterCommand("call-sing2", function(source, args)
    TriggerServerEvent("dispatch:add-police-to-dispatch", args[1], args[2], args[3] , GetEntityCoords(PlayerPedId()))
    Citizen.Wait(550)
    TriggerServerEvent("dispatch:get-police")
end)

-- functions ---

RegisterNetEvent("np-dispatch:openFull")
AddEventHandler("np-dispatch:openFull", function()
    print("test")
-- function openMenu()
    local job = exports["isPed"]:isPed("myJob")
    print("test1")
    if job == 'police' or job == "ems" then
        print("test2")
        TriggerServerEvent("dispatch:get-police")
        TriggerServerEvent("dispatch:osurcam-html")
        Citizen.Wait(250)
        SetNuiFocus(true, true)
        SetNuiFocusKeepInput(true)
    
        menu = not menu
            
        if menu then
            SendNUIMessage({
                action = "open",
                table = police_table,
                player_code = playercode,
                player_name = exports["isPed"]:isPed("fullname"),
                html = html
            })
        else
            SendNUIMessage({
                action = "close"
            })
        end

        for k,v in pairs(dispatch_table) do
            if dispatch_table[k].mod == 1 then  
                if dispatch_table[k].mode == "custom" then 

                    SendNUIMessage({
                        action = "create_dispatch-menu",
                        mod = "custom",
                        alertname = dispatch_table[k].name,
                        street = dispatch_table[k].street,
                        coordx = dispatch_table[k].alertcoordx,
                        coordy = dispatch_table[k].alertcoordy,
                        time = dispatch_table[k].time,
                        code = k,
                        code1 = dispatch_table[k].code
                    })
    
                elseif dispatch_table[k].mode == "full" then 
    
                    SendNUIMessage({
                        action = "create_dispatch-menu",
                        mod = "vehicle",
                        color = dispatch_table[k].color,
                        plate = dispatch_table[k].plate,
                        car = dispatch_table[k].vehicle,
                        alertname = dispatch_table[k].name,
                        street = dispatch_table[k].street,
                        coordx = dispatch_table[k].alertcoordx,
                        coordy = dispatch_table[k].alertcoordy,
                        time = dispatch_table[k].time,
                        code = k,
                        code1 = dispatch_table[k].code
                    })
    
                elseif dispatch_table[k].mode == "normal" then 
    
                    SendNUIMessage({
                        action = "create_dispatch-menu",
                        mod = "normal",
                        car = dispatch_table[k].car,
                        alertname = dispatch_table[k].name,
                        street = dispatch_table[k].street,
                        coordx = dispatch_table[k].alertcoordx,
                        coordy = dispatch_table[k].alertcoordy,
                        time = dispatch_table[k].time,
                        code = k,
                        code1 = dispatch_table[k].code
                    })
                elseif dispatch_table[k].mode == "police" then 
    
                    SendNUIMessage({
                        action = "create_dispatch-menu",
                        mod = "police",
                        car = dispatch_table[k].car,
                        alertname = dispatch_table[k].name,
                        street = dispatch_table[k].street,
                        coordx = dispatch_table[k].alertcoordx,
                        coordy = dispatch_table[k].alertcoordy,
                        time = dispatch_table[k].time,
                        code = k,
                        code1 = dispatch_table[k].code
                    })
                end
            elseif dispatch_table[k].mod == 2 then 
                SendNUIMessage({
                    action = "create_dispatch-menu",
                    mod = "create_call",
                    car = dispatch_table[k].car,
                    alertname = dispatch_table[k].name,
                    street = dispatch_table[k].street,
                    coordx = dispatch_table[k].alertcoordx,
                    coordy = dispatch_table[k].alertcoordy,
                    time = dispatch_table[k].time,
                    code = k,
                    code1 = dispatch_table[k].code
                })
            elseif dispatch_table[k].mod == 3 then 
                SendNUIMessage({
                    action = "create_dispatch-menu",
                    mod = "dismiss_call",
                    car = dispatch_table[k].car,
                    alertname = dispatch_table[k].name,
                    street = dispatch_table[k].street,
                    coordx = dispatch_table[k].alertcoordx,
                    coordy = dispatch_table[k].alertcoordy,
                    time = dispatch_table[k].time,
                    code = k,
                    code1 = dispatch_table[k].code
                })
            end
        end
    
        CreateThread(function()
            while menu do
                DisableDisplayControlActions()
                Wait(1)
            end
        end)
    end
-- end
end)

function openMenuForce()
    TriggerServerEvent("dispatch:get-police")
    TriggerServerEvent("dispatch:osurcam-html")
    Citizen.Wait(300)
    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)

    if menu then
        SendNUIMessage({
            action = "open",
            table = police_table,
            player_code = playercode,
            player_name = playername,
            html = html
        })
    else
        SendNUIMessage({
            action = "close"
        })
    end

    CreateThread(function()
        while menu do
            DisableDisplayControlActions()
            Wait(1)
        end
    end)
end

function callSing(code, icon)

    if playername == nil then 
        TriggerServerEvent("getname")
    end

    Citizen.Wait(250)
    local string = code .. " " .. playername
    playercode = string
    local coord = GetEntityCoords(PlayerPedId())
    
    TriggerServerEvent("dispatch:add-police-to-dispatch", string, playername, icon, false, coord)

    --TriggerServerEvent("dispatch:add-police-to-dispatch", code, playername, icon , GetEntityCoords(PlayerPedId()))

    Citizen.Wait(550)

    TriggerServerEvent("dispatch:get-police")

    enable_coord = true
end

CreateThread(function()
    while true do
        local sleep = 1000

        TriggerServerEvent("dispatch:get-police")

        Citizen.Wait(1100)

        for k,v in pairs(police_table) do

            if v.x and v.y and v.whounder == "" or v.whounder == false then 

                local icon
                
                if v.vehicle == 'fa-car-side' then
                    icon = 'car'
                elseif v.vehicle == 'fa-helicopter' then
                    icon = 'heli'
                elseif v.vehicle == 'fa-motorcycle' then
                    icon = 'motor'
                elseif v.vehicle == 'fa-bicycle' then
                    icon = 'bicycle'
                end

                -- if v.code == playercode then 
                local myjob = exports["isPed"]:isPed("myJob")
                -- else
                if myjob == "police" or myjob == 'state' or myjob == 'sheriff' then
                    if v.code ~= playercode then 
                        RemoveBlip(blip)
                        blip = AddBlipForCoord(v.x, v.y, 5.0)
                        SetBlipSprite(blip, 1)
                        SetBlipDisplay(blip, 2)
                        SetBlipScale(blip, 0.8)
                        SetBlipColour(blip, 3)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(v.code)
                        EndTextCommandSetBlipName(blip)
                        
                        ShowHeadingIndicatorOnBlip(blip, true)
                        SetBlipRotation(blip, v.heading)
                    end
                end
                -- end

                
                SendNUIMessage({
                    action = "update-coord",
                    code = v.code,
                    x = v.x,
                    y = v.y,
                    vehicle = icon
                }) 
            elseif v.whounder then 
                SendNUIMessage({
                    action = "deleteallah",
                    player_code = v.code
                })
            end   
        end
        
        if enable_coord then
            local coord = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())

            local s = IsPedInAnyVehicle(PlayerPedId())

            if s then 
                heading = GetEntityHeading(GetVehiclePedIsIn(PlayerPedId()))
            end

            TriggerServerEvent("dispatch:coords-police", playercode, coord, heading)
        end

        Citizen.Wait(sleep)
    end
end)

---- dispatch --- 

local map = false

local colors = {
    ['0'] = "Metallic Black",
    ['1'] = "Metallic Graphite Black",
    ['2'] = "Metallic Black Steal",
    ['3'] = "Metallic Dark Silver",
    ['4'] = "Metallic Silver",
    ['5'] = "Metallic Blue Silver",
    ['6'] = "Metallic Steel Gray",
    ['7'] = "Metallic Shadow Silver",
    ['8'] = "Metallic Stone Silver",
    ['9'] = "Metallic Midnight Silver",
    ['10'] = "Metallic Gun Metal",
    ['11'] = "Metallic Anthracite Grey",
    ['12'] = "Matte Black",
    ['13'] = "Matte Gray",
    ['14'] = "Matte Light Grey",
    ['15'] = "Util Black",
    ['16'] = "Util Black Poly",
    ['17'] = "Util Dark silver",
    ['18'] = "Util Silver",
    ['19'] = "Util Gun Metal",
    ['20'] = "Util Shadow Silver",
    ['21'] = "Worn Black",
    ['22'] = "Worn Graphite",
    ['23'] = "Worn Silver Grey",
    ['24'] = "Worn Silver",
    ['25'] = "Worn Blue Silver",
    ['26'] = "Worn Shadow Silver",
    ['27'] = "Metallic Red",
    ['28'] = "Metallic Torino Red",
    ['29'] = "Metallic Formula Red",
    ['30'] = "Metallic Blaze Red",
    ['31'] = "Metallic Graceful Red",
    ['32'] = "Metallic Garnet Red",
    ['33'] = "Metallic Desert Red",
    ['34'] = "Metallic Cabernet Red",
    ['35'] = "Metallic Candy Red",
    ['36'] = "Metallic Sunrise Orange",
    ['37'] = "Metallic Classic Gold",
    ['38'] = "Metallic Orange",
    ['39'] = "Matte Red",
    ['40'] = "Matte Dark Red",
    ['41'] = "Matte Orange",
    ['42'] = "Matte Yellow",
    ['43'] = "Util Red",
    ['44'] = "Util Bright Red",
    ['45'] = "Util Garnet Red",
    ['46'] = "Worn Red",
    ['47'] = "Worn Golden Red",
    ['48'] = "Worn Dark Red",
    ['49'] = "Metallic Dark Green",
    ['50'] = "Metallic Racing Green",
    ['51'] = "Metallic Sea Green",
    ['52'] = "Metallic Olive Green",
    ['53'] = "Metallic Green",
    ['54'] = "Metallic Gasoline Blue Green",
    ['55'] = "Matte Lime Green",
    ['56'] = "Util Dark Green",
    ['57'] = "Util Green",
    ['58'] = "Worn Dark Green",
    ['59'] = "Worn Green",
    ['60'] = "Worn Sea Wash",
    ['61'] = "Metallic Midnight Blue",
    ['62'] = "Metallic Dark Blue",
    ['63'] = "Metallic Saxony Blue",
    ['64'] = "Metallic Blue",
    ['65'] = "Metallic Mariner Blue",
    ['66'] = "Metallic Harbor Blue",
    ['67'] = "Metallic Diamond Blue",
    ['68'] = "Metallic Surf Blue",
    ['69'] = "Metallic Nautical Blue",
    ['70'] = "Metallic Bright Blue",
    ['71'] = "Metallic Purple Blue",
    ['72'] = "Metallic Spinnaker Blue",
    ['73'] = "Metallic Ultra Blue",
    ['74'] = "Metallic Bright Blue",
    ['75'] = "Util Dark Blue",
    ['76'] = "Util Midnight Blue",
    ['77'] = "Util Blue",
    ['78'] = "Util Sea Foam Blue",
    ['79'] = "Uil Lightning blue",
    ['80'] = "Util Maui Blue Poly",
    ['81'] = "Util Bright Blue",
    ['82'] = "Matte Dark Blue",
    ['83'] = "Matte Blue",
    ['84'] = "Matte Midnight Blue",
    ['85'] = "Worn Dark blue",
    ['86'] = "Worn Blue",
    ['87'] = "Worn Light blue",
    ['88'] = "Metallic Taxi Yellow",
    ['89'] = "Metallic Race Yellow",
    ['90'] = "Metallic Bronze",
    ['91'] = "Metallic Yellow Bird",
    ['92'] = "Metallic Lime",
    ['93'] = "Metallic Champagne",
    ['94'] = "Metallic Pueblo Beige",
    ['95'] = "Metallic Dark Ivory",
    ['96'] = "Metallic Choco Brown",
    ['97'] = "Metallic Golden Brown",
    ['98'] = "Metallic Light Brown",
    ['99'] = "Metallic Straw Beige",
    ['100'] = "Metallic Moss Brown",
    ['101'] = "Metallic Biston Brown",
    ['102'] = "Metallic Beechwood",
    ['103'] = "Metallic Dark Beechwood",
    ['104'] = "Metallic Choco Orange",
    ['105'] = "Metallic Beach Sand",
    ['106'] = "Metallic Sun Bleeched Sand",
    ['107'] = "Metallic Cream",
    ['108'] = "Util Brown",
    ['109'] = "Util Medium Brown",
    ['110'] = "Util Light Brown",
    ['111'] = "Metallic White",
    ['112'] = "Metallic Frost White",
    ['113'] = "Worn Honey Beige",
    ['114'] = "Worn Brown",
    ['115'] = "Worn Dark Brown",
    ['116'] = "Worn straw beige",
    ['117'] = "Brushed Steel",
    ['118'] = "Brushed Black steel",
    ['119'] = "Brushed Aluminium",
    ['120'] = "Chrome",
    ['121'] = "Worn Off White",
    ['122'] = "Util Off White",
    ['123'] = "Worn Orange",
    ['124'] = "Worn Light Orange",
    ['125'] = "Metallic Securicor Green",
    ['126'] = "Worn Taxi Yellow",
    ['127'] = "police car blue",
    ['128'] = "Matte Green",
    ['129'] = "Matte Brown",
    ['130'] = "Worn Orange",
    ['131'] = "Matte White",
    ['132'] = "Worn White",
    ['133'] = "Worn Olive Army Green",
    ['134'] = "Pure White",
    ['135'] = "Hot Pink",
    ['136'] = "Salmon pink",
    ['137'] = "Metallic Vermillion Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Mettalic Black Blue",
    ['142'] = "Metallic Black Purple",
    ['143'] = "Metallic Black Red",
    ['144'] = "hunter green",
    ['145'] = "Metallic Purple",
    ['146'] = "Metaillic V Dark Blue",
    ['147'] = "MODSHOP BLACK1",
    ['148'] = "Matte Purple",
    ['149'] = "Matte Dark Purple",
    ['150'] = "Metallic Lava Red",
    ['151'] = "Matte Forest Green",
    ['152'] = "Matte Olive Drab",
    ['153'] = "Matte Desert Brown",
    ['154'] = "Matte Desert Tan",
    ['155'] = "Matte Foilage Green",
    ['156'] = "DEFAULT ALLOY COLOR",
    ['157'] = "Epsilon Blue",
}

local alertOn = false
local alertX = nil
local alertY = nil
local lastAlertId = nil

local toggleOld = false
local gpsName = ""

function DisableDisplayControlActions()
    DisableControlAction(0, 1, true) -- disable mouse look
    DisableControlAction(0, 2, true) -- disable mouse look
    DisableControlAction(0, 3, true) -- disable mouse look
    DisableControlAction(0, 4, true) -- disable mouse look
    DisableControlAction(0, 5, true) -- disable mouse look
    DisableControlAction(0, 6, true) -- disable mouse look
    DisableControlAction(0, 263, true) -- disable melee
    DisableControlAction(0, 264, true) -- disable melee
    DisableControlAction(0, 257, true) -- disable melee
    DisableControlAction(0, 140, true) -- disable melee
    DisableControlAction(0, 141, true) -- disable melee
    DisableControlAction(0, 142, true) -- disable melee
    DisableControlAction(0, 143, true) -- disable melee
    DisableControlAction(0, 177, true) -- disable escape
    DisableControlAction(0, 200, true) -- disable escape
    DisableControlAction(0, 202, true) -- disable escape
    DisableControlAction(0, 322, true) -- disable escape
    DisableControlAction(0, 245, true) -- disable chat
    DisablePlayerFiring(PlayerPedId(), true)

    HideHudComponentThisFrame(16);
    SetUserRadioControlEnabled(false);
    SetVehRadioStation(GetVehiclePedIsIn(PlayerPedId(),true), "OFF");
end

RegisterNetEvent("dispatch:trigger-dispatch-client:normal") -- normal dispatch aca
AddEventHandler("dispatch:trigger-dispatch-client:normal", function(code,code1, name, street, alertcoordx, alertcoordy, time)
    local myjob = exports["isPed"]:isPed("myJob")
    if myjob == "police" or myjob == 'state' or myjob == 'sheriff' then
        PlaySoundFrontend(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        SendNUIMessage({
            action = "add-dispatch",
            mod = "normal",
            alertname = name,
            street = street,
            coordx = alertcoordx,
            coordy = alertcoordy,
            time = time,
            code = code,
            code1 = code1
        })
        mapblip(name, alertcoordx, alertcoordy)
    end
end)


RegisterNetEvent("dispatch:trigger-dispatch-client:full")
AddEventHandler("dispatch:trigger-dispatch-client:full", function(code,code1, name, street, alertcoordx, alertcoordy, time, car, plate, carColor)
    local myjob = exports["isPed"]:isPed("myJob")
    if myjob == "police" or myjob == 'state' or myjob == 'sheriff' then 
        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
        SendNUIMessage({
            action = "add-dispatch",
            mod = "vehicle",
            alertname = name,
            street = street,
            coordx = alertcoordx,
            coordy = alertcoordy,
            time = time,
            code = code,
            code1 = code1,
            car = car,
            plate = plate,
            carColor = carColor
        })
        mapblip(name, alertcoordx, alertcoordy)
    end
end)

function dispatch(code, alertName, plate, alertCoord, vehicle,icon)
    local vehActive = true
    if vehicle ~= nil then vehActive = vehicle end
    local hidePlate = false
    if plate ~= nil then hidePlate = plate end

    local playerPed = PlayerPedId()	
    local padCoords = GetEntityCoords(playerPed)
    local alertCoord = vector3(padCoords.x, padCoords.y, padCoords.z)
    local alertCoordx = padCoords.x
    local alertCoordy = padCoords.y

    if alertCoord then alertCoord = vector3(alertCoord.x, alertCoord.y, alertCoord.z) end

    local var1, var2 = GetStreetNameAtCoord(alertCoord.x, alertCoord.y, alertCoord.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
    local street = GetStreetNameFromHashKey(var1)
    local sokak2 = GetStreetNameFromHashKey(var2)
    if sokak2 ~= nil and sokak2 ~= '' then
        street = street .. ', ' .. sokak2
    end

    local male = IsPedMale(playerPed)
    if male then
        sex = "Male"
    elseif not male then
        sex = "Female"
    end

    local hour = GetClockHours()
        if hour < 10 then 
            hour = "0" .. hour
        end
        local minute = GetClockMinutes()
        if minute < 10 then 
            minute = "0" .. minute
        end
        local time = hour .. ":" .. minute

    if IsPedInAnyVehicle(playerPed, false) and vehActive then
        local showPlate = math.random(1, 100)
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
        local color1 = colors[tostring(GetVehicleCustomPrimaryColour(vehicle))]
        local color2 = colors[tostring(GetVehicleCustomSecondaryColour(vehicle))]
        local plate = "Unknown"

        if showPlate < 50 and not hidePlate then plate = GetVehicleNumberPlateText(vehicle) end

        if color2 == color1 then
            colorName = color1
        else
            colorName = color1 ..', '.. color2
        end

        TriggerServerEvent("dispatch:trigger-dispatch-server:full", alertName, street, GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)), plate, colorName, alertCoord.x, alertCoord.y, time, code, icon)
        mapblipcustom(alertName, alertCoordx, alertCoordy, icon)
    else

        TriggerServerEvent("dispatch:trigger-dispatch-server:normal", alertName, street, alertCoord.x, alertCoord.y, time, code)
    end	    
end



RegisterNetEvent("dispatch:trigger-dispatch-client:custom")
AddEventHandler("dispatch:trigger-dispatch-client:custom", function(code,code1, name, street, alertcoordx, alertcoordy, time, icon, pEmergencyType)
    local myjob = exports["isPed"]:isPed("myJob")
    if myjob == "police" or myjob == 'state' or myjob == 'sheriff' then
        if pEmergencyType then 
            TriggerEvent('InteractSound_CL:PlayOnOne', "alert", 0.3)
            SendNUIMessage({
                action = "add-dispatch",
                mod = "police",
                alertname = name,
                street = street,
                coordx = alertcoordx,
                coordy = alertcoordy,
                time = time,
                code = code,
                code1 = code1
            })
        else
            PlaySoundFrontend(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            SendNUIMessage({
                action = "add-dispatch",
                mod = "normal",
                alertname = name,
                street = street,
                coordx = alertcoordx,
                coordy = alertcoordy,
                time = time,
                code = code,
                code1 = code1
            })
        end
        mapblipcustom(name, alertcoordx, alertcoordy, icon)
    end
end)

RegisterNetEvent('np-dispatch:altercallsign;spawn')
AddEventHandler('np-dispatch:altercallsign;spawn',function(getCallsign,pStatusType)
    exports['np-dispatch']:callsign_command(getCallsign,pStatusType)
end)

RegisterNetEvent('np-dispatch:beepEffect')
AddEventHandler('np-dispatch:beepEffect', function()
    if exports['isPed']:isPed('myjob') == "police" then
        TriggerServerEvent('InteractSound_SV:PlayOnSource', '10-1314', 0.2)
    end
end)

RegisterNetEvent('np-dispatch:stolenCar')
AddEventHandler('np-dispatch:stolenCar', function(plate)
    local playerPed = PlayerPedId()	
    local padCoords = GetEntityCoords(playerPed)
    local alertCoord = vector3(padCoords.x, padCoords.y, padCoords.z)
    dispatch('10-99B', 'Stolen Vehicle', plate, alertCoord, GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))), "432")
end)

RegisterNetEvent('civilian:alertPolice')
AddEventHandler("civilian:alertPolice",function(basedistance,alertType,objPassed,isGunshot,isHunting,sentWeapon)
    local isPolice = exports["isPed"]:isPed("myJob") == 'police' or exports["isPed"]:isPed("myJob") == 'sheriff' or exports["isPed"]:isPed("myJob") == 'state'
    local object = objPassed
    local plyCoords = GetEntityCoords(PlayerPedId())
    local shittypefuckyou
    if alertType == "personRobbed" then
        dispatchadd("10-65", "Person being robbed", 458)
    end

    if isGunshot == nil then 
        isGunshot = false 
    end


    if isGunshot then
        shittypefuckyou = 'gunshot'
    end

    local nearNPC

    if alertType == 'drugsale' then
        nearNPC = GetClosestNPC(plyCoords, basedistance, 'combat', object)
    else
        nearNPC = GetClosestNPC(plyCoords, basedistance, shittypefuckyou)
    end 

    local dst = 0

    if nearNPC then
        dst = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(nearNPC))
    end

    if nearNPC and DoesEntityExist(nearNPC) then -- PED ANIMATION.
        if not isSpeeder then
            Wait(500)
            if GetEntityHealth(nearNPC) == 0 then
              return
            end
            if not DoesEntityExist(nearNPC) then
                return
            end
            if IsPedFatallyInjured(nearNPC) then
                return
            end
            if IsPedInMeleeCombat(nearNPC) then
                return
            end
            if IsPedShooting(nearNPC) then
                return
            end
            local dontcall = {
                [29] = true,
                [28] = true,
                [27] = true
            }
            if not dontcall[GetPedType(nearNPC)] then
                ClearPedTasks(nearNPC)
                TaskPlayAnim(nearNPC, "cellphone@", "cellphone_call_listen_base", 1.0, 1.0, -1, 49, 0, 0, 0, 0)
            end
        end
    end

    local isUnderground = false
    if plyCoords.z <= -25 then isUnderground = true end

    if alertType == "drugsale" and not underground then
        if dst > 50.5 and dst < 75.0 then
            dispatchadd("10-40", "Drug sale reported in the area", 51)
        end

    elseif alertType == "druguse" and not underground and not pd then
        if dst > 12.0 and dst < 18.0 then
            dispatchadd("10-40", "Drug use reported", 51)
        end
        
    elseif alertType == "carcrash" then
        dispatchadd("10-50", "Vehicle Crash", 227)
    -- elseif alertType == "death" then
    --     local roadtest2 = IsPointOnRoad(GetEntityCoords(PlayerPedId()), PlayerPedId())
    --     if roadtest2 then return end
    --     dispatchadd("10-47", "Injured Person", 126)
    elseif alertType == "Suspicious" then
        dispatchadd("10-75", "Suspicious activity reported", 51)

    elseif alertType == "fight" and not underground then
        dispatchadd("10-10", "Fight in progress", 437)

    elseif (alertType == "gunshot" or alertType == "gunshotvehicle") then
        dispatchadd("10-71", "Gun shots reported", 110)

    elseif alertType == "lockpick" then
        if dst > 5.0 and dst < 85.0 then
            if math.random(100) >= 25 then
                AlertCheckLockpick(object)
            end
        end
    end
end)



function dispatchadd(code, alertName, icon)

    local playerPed = PlayerPedId()	
    local padCoords = GetEntityCoords(playerPed)
    local alertCoord = vector3(padCoords.x, padCoords.y, padCoords.z)

    if alertCoord then alertCoord = vector3(alertCoord.x, alertCoord.y, alertCoord.z) end

    local var1, var2 = GetStreetNameAtCoord(alertCoord.x, alertCoord.y, alertCoord.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
    local street = GetStreetNameFromHashKey(var1)
    local sokak2 = GetStreetNameFromHashKey(var2)
    if sokak2 ~= nil and sokak2 ~= '' then
        street = street .. ', ' .. sokak2
    end

    local hour = GetClockHours()
    if hour < 10 then 
         hour = "0" .. hour
    end
    local minute = GetClockMinutes()
    if minute < 10 then 
        minute = "0" .. minute
    end
    local time = hour .. ":" .. minute

    if icon == nil then 
        icon = 433
    end

    TriggerServerEvent("dispatch:trigger-dispatch-server:custom", false, alertName, street, alertCoord.x, alertCoord.y, time, code, icon, false)  
end


function policedead(code, alertName, icon, pState)

    local playerPed = PlayerPedId()	
    local padCoords = GetEntityCoords(playerPed)
    local alertCoord = vector3(padCoords.x, padCoords.y, padCoords.z)

    if alertCoord then alertCoord = vector3(alertCoord.x, alertCoord.y, alertCoord.z) end

    local var1, var2 = GetStreetNameAtCoord(alertCoord.x, alertCoord.y, alertCoord.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
    local street = GetStreetNameFromHashKey(var1)
    local sokak2 = GetStreetNameFromHashKey(var2)
    if sokak2 ~= nil and sokak2 ~= '' then
        street = street .. ', ' .. sokak2
    end

    local hour = GetClockHours()
    if hour < 10 then 
         hour = "0" .. hour
    end
    local minute = GetClockMinutes()
    if minute < 10 then 
        minute = "0" .. minute
    end
    local time = hour .. ":" .. minute

    if icon == nil then 
        icon = 433
    end

    TriggerServerEvent("dispatch:trigger-dispatch-server:custom", pState, alertName, street, alertCoord.x, alertCoord.y, time, code, icon, true)  
end

function mapblip(alertName, x, y)
    if alertName == "" then
        doBlipp(x, y, 433, alertName)
    elseif alertName == "Gunshot Warning" then
        doBlipp(x, y, 433, alertName)
    elseif alertName == "Robbery in progress at bobcat security" then
        doBlipp(x, y, 110, alertName)
    elseif alertName == "Pacific Bank Emergency Notice" then
        doBlipp(x, y, 272, alertName)
    elseif alertName == "Home Robbery Report" then
        doBlipp(x, y, 40, alertName)
    elseif alertName == "Power Plant Sabotage Status" then
        doBlipp(x, y, 354, alertName)
    elseif alertName == "Fleeca Bank Robbery" then
        doBlipp(x, y, 272, alertName)
    elseif alertName == "Pacific Bank Robbery" then
        doBlipp(x, y, 272, alertName)
    elseif alertName == "Jewelry Store Robbery" then
        doBlipp(x, y, 617, alertName)
    elseif alertName == "Store Robbery Report" then
        doBlipp(x, y, 628, alertName)
    end
end

function mapblipcustom(alertName, x, y, icon)
    doBlipp(x, y, tonumber(icon), alertName)
end

function doBlipp(x, y, icon, alertName)
    local alpha = 200
    local blip = AddBlipForCoord(x, y, 5.0)
	SetBlipSprite(blip, icon)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 1.20)
    SetBlipColour(blip, 75)
    SetBlipAsShortRange(blip, false)
    SetBlipAlpha(blip, alpha)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(alertName)
    EndTextCommandSetBlipName(blip)

    while alpha ~= 0 do
        Citizen.Wait(20 * 6)
        alpha = alpha - 1
        SetBlipAlpha(blip, alpha)

        if alpha == 0 then
            RemoveBlip(blip)
            break
        end
    end
end

RegisterCommand("setonduty", function(source, args) -- add to when 10-41 is triggered
    local myjob = exports["isPed"]:isPed("myJob")
    if myjob == "police" or myjob == 'state' or myjob == 'sheriff' then 
        callsign_command(args[1], args[2])
    end
end)

RegisterCommand("open-dispatch", function()
    openMenu()
end)

RegisterCommand("map", function()
    local myjob = exports["isPed"]:isPed("myJob")
    if myjob == "police" or myjob == 'state' or myjob == 'sheriff' then 
    SendNUIMessage({
        action = "map"
    })
  end
end)

RegisterCommand('911', function(source, args, rawCommand)
    local msg = rawCommand:sub(5)
    if string.len(msg) > 0 then
        local user = exports["np-base"]:GetModule("LocalPlayer")
        local first_name = user.first_name
        local last_name = user.last_name
        local phone_number = user.phone_number
        TriggerEvent('animation:phonecall')

        local cancelled = exports['np-taskbar']:taskBar(7000,'Dialing 911')
        if cancelled == 100 then
            dispatchadd("911", "911 Call: "..msg, 110)
        end
    else
        TriggerEvent('DoShortHudText', 'Please put a reason after the 911!', 2)
    end
end)

RegisterCommand('311', function(source, args, rawCommand)
    local msg = rawCommand:sub(5)
    if string.len(msg) > 0 then
        local user = exports["np-base"]:GetModule("LocalPlayer")
        local first_name = user.first_name
        local last_name = user.last_name
        local phone_number = user.phone_number
        TriggerEvent('animation:phonecall')
        local cancelled = exports['np-taskbar']:taskBar(7000,'Dialing 311')
        if cancelled == 100 then
            dispatchadd("911", "An incoming 911 call !", "817")
        end
    else
        TriggerEvent('DoShortHudText', 'Please put a reason after the 311!', 2)
    end
end)


Citizen.CreateThread( function()
    canSendGunshot = true
    local playerPed = PlayerPedId()	
    local padCoords = GetEntityCoords(playerPed)
    local alertCoord = vector3(padCoords.x, padCoords.y, padCoords.z)

    while canSendGunshot do
        Wait(5)

    if exports['isPed']:isPed("myjob") ~= "police" then
        if IsPedShooting(PlayerPedId()) then
            if math.random(100) <= 10 then
                if IsPedInAnyVehicle(PlayerPedId()) then
                    dispatch('10-71', 'Gunshots Reported From a Vehicle', GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)), alertCoord, GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))), "432") 
                    canSendGunshot = false
                    Citizen.Wait(1000)
                    canSendGunshot = true
                else
                    exports["np-dispatch"]:dispatchadd('10-71', "Gun shots Reported", "432")
                    canSendGunshot = false
                    Citizen.Wait(3000)
                    canSendGunshot = true
                end
            end
        end
    -- else
    --     Wait(1500)
      end
    end
end)