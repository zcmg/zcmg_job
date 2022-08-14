AddEventHandler('onClientResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        TriggerEvent('chat:removeSuggestion', '/job')
    end
end)

if Config.BlipState then
    ligado = false
    Citizen.CreateThread(function()
        sleep = 1000
        while true do
		    local coords    = GetEntityCoords(PlayerPedId())
            if Vdist(coords.x,coords.y,coords.z, Config.Blip.x,Config.Blip.y,Config.Blip.z) <= Config.BlipDistancia then
                sleep=1
                DrawMarker(Config.BlipTipo, Config.Blip.x, Config.Blip.y, Config.Blip.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.BlipTamanho.x, Config.BlipTamanho.y, Config.BlipTamanho.z, Config.BlipCor.r, Config.BlipCor.g, Config.BlipCor.b, 100, false, true, 2, false, false, false, false)
                if Vdist(coords.x,coords.y,coords.z, Config.Blip.x,Config.Blip.y,Config.Blip.z) <= 2 then
                    if not ligado then
                        exports['zcmg_notificacao']:Alerta("CENTRO DE EMPREGO", "Pressiona <span style='color:#1c77ff'><b>[E]</b></span> para trocar de emprego!", 'ligada', 'informacao')
                        ligado = true
                    end
                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent('zcmg_job:mudarjob')
                    end
                else
                    if ligado then
                        exports['zcmg_notificacao']:Alerta("", "", 'desligada', '')
                        ligado = false
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
else
    AddEventHandler('onClientResourceStart', function (resourceName)
        if (GetCurrentResourceName() == resourceName) then
            TriggerEvent('chat:addSuggestion', '/job', 'Permite alternar de job caso tenha permisão para tal', {
            })
        end
    end)

    RegisterCommand("job", function(source, args, rawCommand)
        TriggerServerEvent('zcmg_job:mudarjob')
    end)
end