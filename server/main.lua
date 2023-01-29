local police_table = {}
local under_table = {}
local dispatch_table = {}
local dispatch_number = 0
local html

RegisterNetEvent("dispatch:add-police-to-dispatch")
AddEventHandler("dispatch:add-police-to-dispatch", function(code, name, icon,under, coords)
    if icon == 'car' then
        icon = 'fa-car-side'
    elseif icon == 'heli' then
        icon = 'fa-helicopter'
    elseif icon == 'motorbike' then
        icon = 'fa-motorcycle'
    elseif icon == 'bicycle' then
        icon = 'fa-bicycle'
    elseif icon == nil then
        icon = 'fa-car-side'
    end

    for k, v in pairs(police_table) do
        if v.name == name then
            police_table[k] = nil
        end
    end

    if coords == nil then
        coords = vector3(300.0, -800.0, -100.0)
    end

    police_table[code] = {
        name = name,
        code = code,
        vehicle = icon,
        owner = false,
        x = coords.x,
        y = coords.y,
        save = "2",
        whounder = "",
        aktif = false
    }
end)

exports('GetDispatchCalls',function()
    return dispatch_table
end)

RegisterNetEvent("dispatch:create-call")
AddEventHandler("dispatch:create-call", function(alah)
    dispatch_table[alah].mod = 2 
end)

RegisterNetEvent("dispatch:close_ui_sv")
AddEventHandler("dispatch:close_ui_sv", function()
    TriggerClientEvent("dispatch:close_ui_cl", -1)
end)

RegisterNetEvent("dispatch:dismiss-call-2")
AddEventHandler("dispatch:dismiss-call-2", function(alah)
    dispatch_table[alah].mod = 3
end)

RegisterNetEvent("dispatch:dismiss-call-1")
AddEventHandler("dispatch:dismiss-call-1", function(alah)
    dispatch_table[alah] = nil
    TriggerClientEvent("dispatch:remove-ping", -1, alah)
end)


RegisterNetEvent("dispatch:remove-call")
AddEventHandler("dispatch:remove-call", function(alah)
    dispatch_table[alah] = nil
    TriggerClientEvent("dispatch:remove-ping", -1, alah)
end)

RegisterNetEvent("dispatch:add_police-assign")
AddEventHandler("dispatch:add_police-assign", function(pCallSign)
    TriggerClientEvent("dispatch:add_police-assign_cl", -1, pCallSign)
end)

RegisterNetEvent("dispatch:delete_police-assign")
AddEventHandler("dispatch:delete_police-assign", function(alah)
    TriggerClientEvent("dispatch:delete_police-assign_cl", -1, alah)
end)

RegisterNetEvent("dispatch:delete-police_sv")
AddEventHandler("dispatch:delete-police_sv", function(alah)
    TriggerClientEvent("dispatch:delete-police_cl", -1, alah)
end)


RegisterNetEvent("dispatch:police_tableSave")
AddEventHandler("dispatch:police_tableSave", function()
    for k,v in pairs(police_table) do
        police_table[k].save = "1"
    end
end)


RegisterNetEvent("dispatch:html")
AddEventHandler("dispatch:html", function(allah)
    local src = source
    html = allah

    Citizen.Wait(500)

    TriggerClientEvent("dispatch:get-html", src, html)
end)

RegisterNetEvent("dispatch:osurcam-html")
AddEventHandler("dispatch:osurcam-html", function()
    local src = source
    TriggerClientEvent("dispatch:get-html", src, html)
end)


RegisterNetEvent("dispatch:coords-police")
AddEventHandler("dispatch:coords-police", function(code, coords, heading)
    if police_table[code] ~= nil then
        police_table[code].x = coords.x
        police_table[code].y = coords.y
        police_table[code].heading = heading
    end
end)

RegisterNetEvent("dispatch:change-police")
AddEventHandler("dispatch:change-police", function(data)
    police_table[data.name].vehicle = data.icon
end)

RegisterServerEvent("dispatch:get-police")
AddEventHandler("dispatch:get-police", function()
    TriggerClientEvent("dispatch:get-police-cl", source, police_table, dispatch_table)
end)


RegisterServerEvent('dispatch:setcallsign')
AddEventHandler("dispatch:setcallsign", function()
  local src = source
  local user = exports["np-base"]:getModule("Player"):GetUser(src)
  local cid = user:getCurrentCharacter().id
  if cid == nil then return end

  local defaultType = 'car'
  local getCallsign = pCallSign(cid)
  TriggerClientEvent('np-dispatch:altercallsign;spawn',src,getCallsign,defaultType)
end)

RegisterNetEvent("dispatch:delete-police")
AddEventHandler("dispatch:delete-police", function(name)
    if name ~= nil then
        police_table[name] = nil
        TriggerClientEvent("dispatch:delete-police_cl", -1, name)
    end
end)


RegisterNetEvent("dispatch:table_sv")
AddEventHandler("dispatch:table_sv", function(owner, player)

    police_table[owner].owner = true

    police_table[owner].aktif = true

    police_table[player].whounder = owner

    police_table[player].aktif = true

end)

RegisterNetEvent("dispatch:table_ayril")
AddEventHandler("dispatch:table_ayril", function(player)
    police_table[player].whounder = ""
    
    police_table[player].aktif = false
end)

RegisterNetEvent("dispatch:force:closeithink")
AddEventHandler("dispatch:force:closeithink", function()
    TriggerClientEvent("dispatch:tasima-force-yeter", -1)
end)


RegisterNetEvent("getname")
AddEventHandler("getname", function()
    local src = source   
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
    local fullname = character.first_name .. " " .. character.last_name
    TriggerClientEvent("getname-cl", src, fullname)
end)

RegisterNetEvent("dispatch:trigger-dispatch-server:normal")
AddEventHandler("dispatch:trigger-dispatch-server:normal", function(alertName, street, alertCoordx, alertCoordy, time, code)
    dispatch_number = dispatch_number + 1

    dispatch_table[dispatch_number] = {
        code = code,
        mod = 1,
        mode = "normal",
        street = street,
        name = alertName,
        x = alertCoordx,
        y = alertCoordy,
        time = time
    }

    TriggerClientEvent("dispatch:trigger-dispatch-client:normal", -1, dispatch_number, code, alertName, street, alertCoordx, alertCoordy, time)
end)

RegisterNetEvent("dispatch:trigger-dispatch-server:full")
AddEventHandler("dispatch:trigger-dispatch-server:full", function(alertName, street, car, plate, colorName, alertCoordx, alertCoordy, time, code)
    dispatch_number = dispatch_number + 1

    dispatch_table[dispatch_number] = {
        code = code,
        mode = "full",
        vehicle = car,
        mod = 1,
        street = street,
        name = alertName,
        x = alertCoordx,
        y = alertCoordy,
        time = time,
        plate = plate,
        color = colorName
    }

    TriggerClientEvent("dispatch:trigger-dispatch-client:full", -1, dispatch_number, code, alertName,street, alertCoordx, alertCoordy, time,car,plate,colorName)
end)

RegisterNetEvent("dispatch:trigger-dispatch-server:custom")
AddEventHandler("dispatch:trigger-dispatch-server:custom", function(pPlayShit, alertName, street, alertCoordx, alertCoordy, time, code, icon, sa)
    local user = exports["np-base"]:getModule("Player"):GetUser(source)
    local userjob = user:getVar("job")
    dispatch_number = dispatch_number + 1

    if pPlayShit == true then
        TriggerClientEvent('np-dispatch:beepEffect', -1)
    end

    if sa then 
        dispatch_table[dispatch_number] = {
            code = code,
            mod = 1,
            mode = "police",
            street = street,
            name = alertName,
            x = alertCoordx,
            y = alertCoordy,
            time = time,
            icon = icon
        }
        TriggerClientEvent("dispatch:trigger-dispatch-client:custom", -1, dispatch_number, code, alertName, street, alertCoordx, alertCoordy, time, icon, true)
    else
        dispatch_table[dispatch_number] = {
            code = code,
            mod = 1,
            mode = "custom",
            street = street,
            name = alertName,
            x = alertCoordx,
            y = alertCoordy,
            time = time,
            icon = icon
        }
        TriggerClientEvent("dispatch:trigger-dispatch-client:custom", -1, dispatch_number, code, alertName, street, alertCoordx, alertCoordy, time, icon, false)
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source   
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local character = user:getCurrentCharacter()
    local fullname = character.first_name .. " " .. character.last_name
    for k,v in pairs(police_table) do
        local check = police_table[k].name
        if police_table[k].name == fullname then
            TriggerClientEvent("dispatch:delete-player", -1, police_table[k].code)
            police_table[k] = nil
        end
    end
end)  

function pCallSign(pCid)
    local result = Await(SQL.execute("SELECT * FROM jobs_whitelist WHERE cid = @cid", {["cid"] = pCid}))
    if result[1] ~= nil then
        return result[1].callsign
    else
        return '000'
    end
end