ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()
    local vRaw = LoadResourceFile(GetCurrentResourceName(), 'version.json')
    if vRaw then
    local v = json.decode(vRaw)
            PerformHttpRequest('https://raw.githubusercontent.com/kutaskozl/atmrobbery/main/version.json', function(code, res, headers)
                if code == 200 then
                        local rv = json.decode(res)
                        if rv.version == v.version then
                            if rv.commit ~= v.commit then 
                                print(([[
^1----------------------------------------------------------------------
^1WARNING: YOUR SZI_ATMROBBERY IS OUTDATED!
^1COMMIT UPDATE: ^5%s AVAILABLE
^1DOWNLOAD:^5 https://github.com/Sub-Zero-Interactive/szi_atmrobbery
^1CHANGELOG:^5 %s
^1-----------------------------------------------------------------------
^0]]):format(rv.commit, rv.changelog))
                            else
                                print(([[
^8-------------------------------------------------------
^2Your szi_atmrobbery is the latest version!
^5Version:^0 %s
^5COMMIT:^0 %s
^5CHANGELOG:^0 %s
^8-------------------------------------------------------
^0]]):format( rv.version, rv.commit, rv.changelog))
                            end
                       else
                           print(([[
^1----------------------------------------------------------------------
^1URGENT: YOUR SZI_ATMROBBERY IS OUTDATATED!!!
^1COMMIT UPDATE: ^5%s AVAILABLE
^1DOWNLOAD:^5 https://github.com/Sub-Zero-Interactive/szi_atmrobbery
^1CHANGELOG:^5 %s
^1-----------------------------------------------------------------------
^0]]):format(rv.commit, rv.changelog))
                       end
                   else
                    print('[^1ERROR^0] szi_atmrobbery unable to check version!')
                end
            end,'GET'
        )
    end
end)

lib.callback.register('piotreq_radiolist:GetUsers', function()
    local players = exports['pma-voice']:getPlayersInRadioChannel(Player(source).state['radioChannel'])
    local list = {}
    for player, isTalking in pairs(players) do
        local list2 = {player = GetRPName(player), isTalking = isTalking, badge = GetPlayerBadge(player)}
        table.insert(list, list2)
    end
    return list
end)

function GetRPName(player)
    local xPlayer = ESX.GetPlayerFromId(player)
    local fname = xPlayer.get('firstName')
    local sname = xPlayer.get('lastName')
    local fullname = string.upper(string.sub(fname, 1, 1))..'. '..string.upper(string.sub(sname, 1, 1))..''..string.sub(sname, 2)
    return fullname
end

function GetPlayerBadge(player)
    local xPlayer = ESX.GetPlayerFromId(player)
    local badge = MySQL.query.await('SELECT badge FROM users WHERE identifier = ?', {xPlayer.identifier})[1].badge
    return badge
end
