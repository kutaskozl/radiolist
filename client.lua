CreateThread(function() 
    while true do
        local channel = exports['pma-voice']:GetRadioChannel()
        local count = exports['pma-voice']:GetRadioCount()
        if tostring(channel) == "0" then
            sleep = 1500 -- co ile sprawdza czy jesteś na radiu (1.5 sekundy)
            SendNUIMessage({
                type = 'HideUI'
            })    
        else
            local players = lib.callback.await('piotreq_radiolist:GetUsers')
            sleep = 500 -- co ile odświeża ui gdy jesteś na radiu (0.5 sekundy)
            SendNUIMessage({
                type = 'ShowUI',
                channel = channel,
                count = count,
                players = players,
            })    
        end    
        Citizen.Wait(sleep)
    end
end)