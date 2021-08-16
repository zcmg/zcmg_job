AddEventHandler('onClientResourceStart', function (resourceName)
    if (GetCurrentResourceName() == resourceName) then
        TriggerEvent('chat:addSuggestion', '/job', 'Permite alternar de job caso tenha permisão para tal', {
        })
    end
end)

AddEventHandler('onClientResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        TriggerEvent('chat:removeSuggestion', '/job')
    end
end)
