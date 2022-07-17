ESX = {};
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

local staff = {}
local allreport = {}
local reportcount = {}


-- command ping
TriggerEvent('es:addGroupCommand', 'ping', 'user', function(source)
    TriggerClientEvent('esx:showAdvancedNotification', source, 'PING', '~b~' ..GetPlayerName(source).. '', 'Votre ping est de ~n~~r~'..GetPlayerPing(source)..' MS', 'CHAR_CHAT_CALL', 0)
end)

-- command report
TriggerEvent('es:addGroupCommand', 'report', 'user', function(source, args, user)
	if args[1] ~= nil then
        local xPlayerSource = ESX.GetPlayerFromId(source)

        MySQL.Async.fetchAll('SELECT jail_time FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayerSource.identifier
        }, function(result)
                local isadded = false
                for k,v in pairs(reportcount) do
                    if v.id == source then
                        isadded = true
                    end
                end
                if not isadded then
                    table.insert(reportcount, { 
                        id = source,
                        gametimer = 0
                    })
                end
                for k,v in pairs(reportcount) do
                    if v.id == source then
                        if v.gametimer + 120000 > GetGameTimer() and v.gametimer ~= 0 then
                            TriggerClientEvent('esx:showAdvancedNotification', source, 'SUPPORT', '~b~'..GetPlayerName(source)..'', 'Vous devez patienter ~r~2 minute~s~ avant de faire de nouveau un ~r~report !', 'CHAR_BLOCKED', 0)
                            return
                        else
                            v.gametimer = GetGameTimer()
                        end
                    end
                end
                TriggerClientEvent('esx:showAdvancedNotification', source, 'REPORT', '~b~' ..GetPlayerName(source).. '', 'Votre Report a bien été envoyé \n [ '.. table.concat(args, " ") .. ' ]', 'CHAR_CHAT_CALL', 0)
                PerformHttpRequest(Config.webhook.report, function(err, text, headers) end, 'POST', json.encode({username = "REPORT", content = "``REPORT``\n```ID : " .. source .. "\nNom : " .. GetPlayerName(source) .. "\nMessage : " .. table.concat(args, " ") .. "```"}), { ['Content-Type'] = 'application/json' })
                table.insert(allreport, {
                    id = source,
                    name = GetPlayerName(source),
                    reason = table.concat(args, " ")
                })
                local xPlayers = ESX.GetPlayers()
                for i = 1, #xPlayers, 1 do
                    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                    if xPlayer and (xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin") then
                        TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'REPORT', 'Nouveaux report de ~r~'..GetPlayerName(source)..' ~s~| ~p~'..source..'', 'Message: ~n~~u~'.. table.concat(args, " "), 'CHAR_CHAT_CALL', 0)
                        TriggerClientEvent("OTEXO:RefreshReport", xPlayer.source)
                    end
                end
        end)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Signalez un joueur ou un problème", params = { {name = "report", help = "Ce que vous voulez signalez"} }})


RegisterServerEvent("OTEXO:SendLogs")
AddEventHandler("OTEXO:SendLogs", function(action)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        PerformHttpRequest(Config.webhook.SendLogs, function(err, text, headers) end, 'POST', json.encode({username = "AdminMenu", content = "```\nNom : " .. GetPlayerName(source) .. "\nAction : ".. action .." !```" }), { ['Content-Type'] = 'application/json' })
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)

RegisterServerEvent("OTEXO:onStaffJoin")
AddEventHandler("OTEXO:onStaffJoin", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerSource = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        PerformHttpRequest(Config.webhook.Staffmodeon , function(err, text, headers) end, 'POST', json.encode({username = "AdminMenu", content = "``STAFF MODE ON``\n```\nNom : " .. GetPlayerName(source) .. "\nAction : Active Staff Mode !```" }), { ['Content-Type'] = 'application/json' })
        table.insert(staff, source)
        print('^1'.. GetPlayerName(source) ..' ^2Activer StaffMode^0')
        TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'STAFF', '~g~ACTIF', '~b~'..GetPlayerName(source).. '~s~ à ~g~activer~s~ son StaffMode ', 'CHAR_BUGSTARS', 8)
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)

RegisterServerEvent("OTEXO:onStaffLeave")
AddEventHandler("OTEXO:onStaffLeave", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerSource = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        PerformHttpRequest(Config.webhook.Staffmodeoff , function(err, text, headers) end, 'POST', json.encode({username = "AdminMenu", content = "``STAFF MODE OFF``\n```\nNom : " .. GetPlayerName(source) .. "\nAction : Désactive Staff Mode !```" }), { ['Content-Type'] = 'application/json' })
        table.remove(staff, source)
        print('^1'.. GetPlayerName(source) ..' ^2Désactiver StaffMode^0')
        TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'STAFF', '~r~DESACTIVER', '~b~'..GetPlayerName(source).. '~s~ à ~r~désactiver~s~ son StaffMode ', 'CHAR_BUGSTARS', 8)

    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)

RegisterServerEvent("OTEXO:Jail")
AddEventHandler("OTEXO:Jail", function(id, time)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        PerformHttpRequest(Config.webhook.Jail, function(err, text, headers) end, 'POST', json.encode({username = "JAIL", content = "`` JAIL ``\n```\nNom : " .. GetPlayerName(source) .. "\nNom de la personne jail : " .. GetPlayerName(id) .. "\nTemps : " .. time .. " minutes ```" }), { ['Content-Type'] = 'application/json' })
        TriggerEvent('esx_jailer:sendToJail', tonumber(id), tonumber(time * 60))
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)

RegisterServerEvent("OTEXO:UnJail")
AddEventHandler("OTEXO:UnJail", function(id, time)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        PerformHttpRequest(Config.webhook.UnJail, function(err, text, headers) end, 'POST', json.encode({username = "UNJAIL", content = "`` UNJAIL ``\n```\nNom : " .. GetPlayerName(source) .. "\nNom de la personne unjail : " .. GetPlayerName(id) .. "```" }), { ['Content-Type'] = 'application/json' })
        TriggerEvent("esx_jailer:unjailQuest", id)
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)


RegisterServerEvent("OTEXO:teleport")
AddEventHandler("OTEXO:teleport", function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        PerformHttpRequest(Config.webhook.teleport, function(err, text, headers) end, 'POST', json.encode({username = "AdminMenu", content = "``TELEPORT``\n```\nNom : " .. GetPlayerName(source) .. "\nAction : Téléporter aux joueurs ! " .. "\n\n" .. "Nom de la personne : " .. GetPlayerName(id) .. "```" }), { ['Content-Type'] = 'application/json' })
        TriggerClientEvent("OTEXO:teleport", source, GetEntityCoords(GetPlayerPed(id)))
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)

RegisterServerEvent("OTEXO:teleportTo")
AddEventHandler("OTEXO:teleportTo", function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        PerformHttpRequest(Config.webhook.teleportTo, function(err, text, headers) end, 'POST', json.encode({username = "AdminMenu", content = "``TELEPORT SUR SOI MEME``\n```\nNom : " .. GetPlayerName(source) .. "\nAction : Téléportez les joueurs à l'administrateur ! " .. "\n\n" .. "Nom de la personne : " .. GetPlayerName(id) .. "```" }), { ['Content-Type'] = 'application/json' })
        TriggerClientEvent("OTEXO:teleport", id, GetEntityCoords(GetPlayerPed(source)))
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)

RegisterServerEvent("OTEXO:Revive")
AddEventHandler("OTEXO:Revive", function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        PerformHttpRequest(Config.webhook.revive, function(err, text, headers) end, 'POST', json.encode({username = "AdminMenu", content = "``REVIVE``\n```\nNom : " .. GetPlayerName(source) .. "\nAction : Revive ! " .. "\n\n" .. "Nom de la personne revive : " .. GetPlayerName(id) .. "```" }), { ['Content-Type'] = 'application/json' })
        TriggerClientEvent("esx_ambulancejob:revive", id)
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)


RegisterServerEvent("OTEXO:teleportcoords")
AddEventHandler("OTEXO:teleportcoords", function(id, coords)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        PerformHttpRequest(Config.webhook.teleportcoords, function(err, text, headers) end, 'POST', json.encode({username = "AdminMenu", content = "``TP GARAGE``\n```\nNom : " .. GetPlayerName(source) .. "\nAction : Tp sur garage ! " .. "\n\n" .. "Nom de la personne : " .. GetPlayerName(id) .. "```" }), { ['Content-Type'] = 'application/json' })
        TriggerClientEvent("OTEXO:teleport", id, vector3(215.76, -810.12, 30.73))
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)

RegisterServerEvent("OTEXO:teleporttoit")
AddEventHandler("OTEXO:teleporttoit", function(id, coords)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        PerformHttpRequest(Config.webhook.teleporttoit, function(err, text, headers) end, 'POST', json.encode({username = "AdminMenu", content = "``TP TOIT``\n```\nNom : " .. GetPlayerName(source) .. "\nAction : Tp sur un toit ! " .. "\n\n" .. "Nom de la personne : " .. GetPlayerName(id) .. "```" }), { ['Content-Type'] = 'application/json' })
        TriggerClientEvent("OTEXO:teleport", id, vector3(-75.59, -818.07, 326.17))
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)


RegisterServerEvent("OTEXO:message")
AddEventHandler("OTEXO:message", function(target, message)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = GetPlayerName(source)
    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        PerformHttpRequest(Config.webhook.message, function(err, text, headers) end, 'POST', json.encode({username = "AdminMenu", content = "``MESSAGE``\n```\nNom : " .. GetPlayerName(source) .. "\nAction : Message ! " .. "\n\n" .. "Nom de la personne : " .. GetPlayerName(target) .. "\n" .. "Message est : " .. message .. "```" }), { ['Content-Type'] = 'application/json' })
        TriggerClientEvent("esx:showNotification", source, ("~g~Message envoyé à %s"):format(GetPlayerName(target)))
        TriggerClientEvent('esx:showAdvancedNotification', target, 'Message du staff', '~r~'..name..' ~s~:', ''..message..'' , 'CHAR_SOCIAL_CLUB', 0)
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)

RegisterServerEvent("OTEXO:annonce")
AddEventHandler("OTEXO:annonce", function( message)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers	= ESX.GetPlayers()
    local name = GetPlayerName(source)
    if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'ANNONCE', '~b~'..name..' :', ''..message..'', 'CHAR_ARTHUR', 0)
        end
        PerformHttpRequest(Config.webhook.annonce, function(err, text, headers) end, 'POST', json.encode({username = "AdminMenu", content = "``ANNONCE``\n```\nNom : " .. GetPlayerName(source) .. "\nAction : Annonce ! " .. "\n\n" .. "Message : " ..message.. "```" }), { ['Content-Type'] = 'application/json' })

    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)

RegisterServerEvent("OTEXO:reviveall")
AddEventHandler("OTEXO:reviveall", function(message)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers	= ESX.GetPlayers()
    if xPlayer.getGroup() == "superadmin" then
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx_ambulancejob:revive', xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'ANNONCE', '~b~'..xPlayers[i]..' ', '~r~Revive de tout le monde', 'CHAR_GANGAPP', 0)
        end
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)

RegisterServerEvent("OTEXO:SavellPlayerAuto")
AddEventHandler("OTEXO:SavellPlayerAuto", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = GetPlayerName(source)
    if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        PerformHttpRequest(Config.webhook.SavellPlayerAuto, function(err, text, headers) end, 'POST', json.encode({username = "AdminMenu", content = "``SAVE JOUEURS ``\n```\nNom : " .. GetPlayerName(source) .. "\nAction : save joueurs  ! " .. "```" }), { ['Content-Type'] = 'application/json' })
        ESX.SavePlayers(cb)
	    print('^2Save des joueurs ^3Effectué^0 par ^1'..name..'^0')
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)

RegisterServerEvent("OTEXO:clearInv")
AddEventHandler("OTEXO:clearInv", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayere = ESX.GetPlayerFromId(target)
    if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        for i = 1, #xPlayere.inventory, 1 do
            if xPlayere.inventory[i].count > 0 then
                xPlayere.setInventoryItem(xPlayere.inventory[i].name, 0)
            end
        end
        PerformHttpRequest(Config.webhook.clearInv, function(err, text, headers) end, 'POST', json.encode({username = "AdminMenu", content = "``CLEAR INVENTAIRE``\n```\nNom : " .. GetPlayerName(source) .. "\nAction : Clear inventaire ! " .. "\n\n" .. "Nom de la personne  : " .. GetPlayerName(target) .. "```" }), { ['Content-Type'] = 'application/json' })
        TriggerClientEvent("esx:showNotification", source, ("~g~Clear inventaire de %s effectuée"):format(GetPlayerName(target)))
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)

RegisterServerEvent("OTEXO:clearLoadout")
AddEventHandler("OTEXO:clearLoadout", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayere = ESX.GetPlayerFromId(target)
    if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        for i = #xPlayere.loadout, 1, -1 do
            xPlayere.removeWeapon(xPlayere.loadout[i].name)
        end
        PerformHttpRequest(Config.webhook.clearLoadout, function(err, text, headers) end, 'POST', json.encode({username = "AdminMenu", content = "``CLEAR ARME``\n```\nNom : " .. GetPlayerName(source) .. "\nAction : Clear arme ! " .. "\n\n" .. "Nom de la personne  : " .. GetPlayerName(target) .. "```" }), { ['Content-Type'] = 'application/json' })
        TriggerClientEvent("esx:showNotification", source, ("~g~Clear des armes de %s effectuée"):format(GetPlayerName(target)))
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)


RegisterServerEvent("OTEXO:WipePlayer")
AddEventHandler("OTEXO:WipePlayer", function(target, id)
    local xPlayer = ESX.GetPlayerFromId(target)
    local steam = xPlayer.getIdentifier()
    if  xPlayer.getGroup() == "superadmin" then
        PerformHttpRequest(Config.webhook.WipePlayer, function(err, text, headers) end, 'POST', json.encode({username = "AdminMenu", content = "``WIPE``\n```\nNom : " .. GetPlayerName(source) .. "\nAction : Wipe  ! " .. "\n\n" .. "Nom de la personne  : " .. GetPlayerName(target) .. "```" }), { ['Content-Type'] = 'application/json' })
        DropPlayer(target, "Wipe en cours..")
        MySQL.Async.execute([[ 
            DELETE FROM billing WHERE identifier = @wipeID;
            DELETE FROM billing WHERE sender = @wipeID;
            DELETE FROM open_car WHERE identifier = @wipeID;
            DELETE FROM owned_vehicles WHERE owner = @wipeID;
            DELETE FROM user_accounts WHERE identifier = @wipeID;
            DELETE FROM user_accessories WHERE identifier = @wipeID;
            DELETE FROM phone_users_contacts WHERE identifier = @wipeID;
            DELETE FROM user_inventory WHERE identifier = @wipeID;
            DELETE FROM user_licenses WHERE owner = @wipeID;
            DELETE FROM user_tenue WHERE identifier = @wipeID;
             DELETE FROM users WHERE identifier = @wipeID;	]], {
            ['@wipeID'] = steam,
        }, function(rowsChanged)
            print("^5Wipe effectuer ! SteamID :"..steam.."^0")
            TriggerClientEvent('esx:showNotification', id, "Joueur wipe")
        end)
        --DELETE FROM owned_properties WHERE owner = @wipeID;
        --DELETE FROM playerstattoos WHERE identifier = @wipeID;
        --DELETE FROM owned_boats WHERE owner = @wipeID;
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)


RegisterServerEvent("OTEXO:kick")
AddEventHandler("OTEXO:kick", function(id, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        PerformHttpRequest(Config.webhook.kick, function(err, text, headers) end, 'POST', json.encode({username = "AdminMenu", content = "``KICK``\n```\nNom : " .. GetPlayerName(source) .. "\nAction : Kick Players ! " .. "\n\n" .. "Nom de la personne  : " .. GetPlayerName(id) .. "\n" .. "Reason : " .. reason .. "```" }), { ['Content-Type'] = 'application/json' })
        DropPlayer(id, reason)
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)


RegisterServerEvent("OTEXO:ouvrirmenu1")
AddEventHandler("OTEXO:ouvrirmenu1", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        TriggerClientEvent("OTEXO:menu1", source)
    else
        
    end
end)

RegisterServerEvent("OTEXO:ouvrirmenu2")
AddEventHandler("OTEXO:ouvrirmenu2", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        TriggerClientEvent("OTEXO:menu2", source)
    else
        
    end
end)

RegisterServerEvent("OTEXO:ReportRegle")
AddEventHandler("OTEXO:ReportRegle", function(idt)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        for i, v in pairs(allreport) do
            if i == idt then
                TriggerClientEvent('esx:showAdvancedNotification',  v.id, 'SUPPORT', '~b~' ..GetPlayerName(source).. '', '~g~Votre report a été réglée !', 'CHAR_CHAT_CALL', 0)
            end
        end
        allreport[idt] = nil
    else
        TriggerEvent("BanSql:ICheatServer", source, "CHEAT")
    end
end)

ESX.RegisterServerCallback('OTEXO:retrievePlayers', function(playerId, cb)
    local players = {}
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        table.insert(players, {
            id = "0",
            group = xPlayer.getGroup(),
            source = xPlayer.source,
            jobs = xPlayer.getJob().name,
            name = xPlayer.getName()
        })
    end

    cb(players)
end)

ESX.RegisterServerCallback('OTEXO:retrieveStaffPlayers', function(playerId, cb)
    local playersadmin = {}
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        table.insert(playersadmin, {
            id = "0",
            group = xPlayer.getGroup(),
            source = xPlayer.source,
            jobs = xPlayer.getJob().name,
            name = xPlayer.getName()
        })
    end
end

    cb(playersadmin)
end)

ESX.RegisterServerCallback('OTEXO:retrieveReport', function(playerId, cb)
    cb(allreport)
end)

-- message quand on se connect
AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    deferrals.defer()
    deferrals.update("Bienvenue 🧪")
    Wait(3500)
     deferrals.done()
end)



TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- jail command
TriggerEvent('es:addGroupCommand', 'jail', 'mod', function(source, args, user)
	if args[1] and GetPlayerName(args[1]) ~= nil and tonumber(args[2]) then
		TriggerEvent('esx_jailer:sendToJail', tonumber(args[1]), tonumber(args[2] * 60))
        PerformHttpRequest(Config.webhook.Jail, function(err, text, headers) end, 'POST', json.encode({username = "JAIL", content = "`` JAIL ``\n```\nNom : " .. GetPlayerName(source) .. "\nNom de la personne jail : " .. GetPlayerName(args[1]) .. "\nTemps : " .. tonumber(args[2]) .. " minutes ```" }), { ['Content-Type'] = 'application/json' })

	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'ID de joueur invalide ou temps de prison !' } } )
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Mettre un joueur en prison", params = {{name = "id", help = "id de la personne"}, {name = "time", help = "temps de prison en minutes"}}})


-- unjail command
TriggerEvent('es:addGroupCommand', 'unjail', 'admin', function(source, args, user)
	if args[1] then
		if GetPlayerName(args[1]) ~= nil then
			TriggerEvent('esx_jailer:unjailQuest', tonumber(args[1]))
            PerformHttpRequest(Config.webhook.UnJail, function(err, text, headers) end, 'POST', json.encode({username = "UNJAIL", content = "`` UNJAIL ``\n```\nNom : " .. GetPlayerName(source) .. "\nNom de la personne unjail : " .. GetPlayerName(args[1]) .. "```" }), { ['Content-Type'] = 'application/json' })
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'ID de joueur non valide !' } } )
		end
	else
		TriggerEvent('esx_jailer:unjailQuest', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Sortir les gens de prison", params = {{name = "id", help = "id de la personne"}}})

RegisterServerEvent('esx_jailer:sendToJail')
AddEventHandler('esx_jailer:sendToJail', function(target, jailTime)
	local identifier = GetPlayerIdentifiers(target)[1]

	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier=@id', {['@id'] = identifier}, function(result)
		if result[1] ~= nil then
			MySQL.Async.execute("UPDATE jail SET jail_time=@jt WHERE identifier=@id", {['@id'] = identifier, ['@jt'] = jailTime})
		else
			MySQL.Async.execute("INSERT INTO jail (identifier,jail_time) VALUES (@identifier,@jail_time)", {['@identifier'] = identifier, ['@jail_time'] = jailTime})
		end
	end)
	
	TriggerClientEvent('esx:showAdvancedNotification', target, 'PRISON', '~r~'..GetPlayerName(target)..'', 'est maintenant en ~b~prison ~s~pour ~n~[ ~u~'..ESX.Round(jailTime / 60)..' ~s~] minutes', 'CHAR_GANGAPP', 0)

	TriggerClientEvent('esx_policejob:unrestrain', target)
	TriggerClientEvent('esx_jailer:jail', target, jailTime)
end)

RegisterServerEvent('esx_jailer:checkJail')
AddEventHandler('esx_jailer:checkJail', function()
	local player = source 
	local identifier = GetPlayerIdentifiers(player)[1] 
	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier=@id', {['@id'] = identifier}, function(result)
		if result[1] ~= nil then

			TriggerClientEvent('esx_jailer:jail', player, tonumber(result[1].jail_time))
		end
	end)
end)

RegisterServerEvent('esx_jailer:unjailQuest')
AddEventHandler('esx_jailer:unjailQuest', function(source)
	if source ~= nil then
		unjail(source)
	end
end)

RegisterServerEvent('esx_jailer:unjailTime')
AddEventHandler('esx_jailer:unjailTime', function()
	unjail(source)
end)

RegisterServerEvent('esx_jailer:updateRemaining')
AddEventHandler('esx_jailer:updateRemaining', function(jailTime)
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier=@id', {['@id'] = identifier}, function(result)
		if result[1] ~= nil then
			MySQL.Async.execute("UPDATE jail SET jail_time=@jt WHERE identifier=@id", {['@id'] = identifier, ['@jt'] = jailTime})
		end
	end)
end)

function unjail(target)
	local identifier = GetPlayerIdentifiers(target)[1]
	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier=@id', {['@id'] = identifier}, function(result)
		if result[1] ~= nil then
			MySQL.Async.execute('DELETE from jail WHERE identifier = @id', {['@id'] = identifier})
		end
	end)

    TriggerClientEvent('esx:showAdvancedNotification', target, 'PRISON', '~u~'..GetPlayerName(target)..'', ' est libéré de prison!', 'CHAR_GANGAPP', 0)

	TriggerClientEvent('esx_jailer:unjail', target)
end

-- pas touche 🤣 (je rigole mettez ce que vous voulez)

CreateThread(function()
    Citizen.Wait(1250)
    print('Ex_admin Is on')
end)
