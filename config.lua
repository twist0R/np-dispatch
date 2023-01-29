-- Commands
RegisterCommand("add-dispatch", function(source,args)
    exports["np-dispatch"]:dispatchadd(args[1], args[2], args[3])
end)

RegisterCommand("runplate", function(source,args)
    exports["np-dispatch"]:dispatchadd("LUNIS Nospraga:" .. args[1])
end)

RegisterCommand("10-11", function(source,args)
    local icon = 189 -- https://docs.fivem.net/docs/game-references/blips/
    exports["np-dispatch"]:policedead("10-11A", "Polis Yaralandı", icon)
end)

RegisterCommand("callsign", function(source, args)
    local job = exports["isPed"]:isPed("myJob")
    if job == 'police' or job == "ems" then
        -- local item = exports["et-inventory"]:hasEnoughOfItem('gps',1,false)
        -- if item then
            exports["np-dispatch"]:callsign_command(args[1], args[2])
        -- else
        --     exports["mythic_notify"]:SendAlert("error", "Üzerinde GPS yok.", 5000)
        -- end
    else
        -- exports["mythic_notify"]:SendAlert("inform", "Mesaiye girmen lazım.", 5000)
    end
end)


Citizen.CreateThread(function()
    RegisterKeyMapping("map", "open the map hocam", "keyboard", "M")
    RegisterKeyMapping("open-dp", "open the menu hocam", "keyboard", "O")
end)