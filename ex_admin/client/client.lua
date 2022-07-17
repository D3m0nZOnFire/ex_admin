--@type table Shared object
ESX = {};


TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

local player = {};

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		return result
	else
		Citizen.Wait(500)
		return nil
	end
end


-- Props 
local limit1 = 0
local limit2 = 0
local limit3 = 0
local limit4 = 0
local limit5 = 0
local limit6 = 0
local limit7 = 0
local limit8 = 0
local limit9 = 0
local limit10 = 0
local limit11 = 0


-- Particule 
local dict2 = "scr_rcpaparazzo1" --Gatégorie
local particleName2 = "scr_mich4_firework_trailburst_spawn" -- Nom de la particule
SetParticle = function()
	Citizen.CreateThread(function()
		RequestNamedPtfxAsset(dict2)
		while not HasNamedPtfxAssetLoaded(dict2) do
			Citizen.Wait(0)
		end
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped, true))
		local a = 0
		while a < 25 do
			UseParticleFxAssetNextCall(dict2)
			StartParticleFxNonLoopedAtCoord(particleName2, x, y, z, 1.50, 1.50, 1.50, 1.50, false, false, false)
			a = a + 1
			break
			Citizen.Wait(50)
		end
	end)
end

local dict2 = "proj_indep_firework" --Gatégorie
local particleName2 = "scr_indep_firework_grd_burst" -- Nom de la particule
SetParticlePed = function()
	Citizen.CreateThread(function()
		RequestNamedPtfxAsset(dict2)
		while not HasNamedPtfxAssetLoaded(dict2) do
			Citizen.Wait(0)
		end
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped, true))
		local a = 0
		while a < 25 do
			UseParticleFxAssetNextCall(dict2)
			StartParticleFxNonLoopedAtCoord(particleName2, x, y, z, 1.50, 1.50, 1.50, 1.50, false, false, false)
			a = a + 1
			break
			Citizen.Wait(50)
		end
	end)
end

-- color menu 
local selectedColor = 1
local cVarLongC = { "~r~", "~b~", "~g~", "~y~", "~p~", "~o~", "~r~", "~b~", "~g~", "~y~", "~p~", "~o~" }
local cVarLong = function()
    return cVarLongC[selectedColor]
end

Citizen.CreateThread(function()
    while true do
        Wait(325)
        selectedColor = selectedColor + 1
        if selectedColor > #cVarLongC then
            selectedColor = 1
        end
    end
end)


local selectedColorE = 1
local cVarLongCE = { "~r~", "~w~", "~r~", "~w~", "~r~", "~w~" }
local cVarLongE = function()
    return cVarLongCE[selectedColorE]
end

Citizen.CreateThread(function()
    while true do
        Wait(100)
        selectedColorE = selectedColorE + 1
        if selectedColorE > #cVarLongCE then
            selectedColorE = 1
        end
    end
end)


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        player = ESX.GetPlayerData()
        Citizen.Wait(10)
    end
end)


local TempsValue = "Aucun Temps !"
local raisontosend = "Aucune Raison !"
local GroupItem = {}
GroupItem.Value = 1

local mainMenu = RageUI.CreateMenu("~p~Administration", "~p~Gestions du serveur", 1);
mainMenu:DisplayGlare(false)
mainMenu:AddInstructionButton({
    [1] = GetControlInstructionalButton(1, 334, 0),
    [2] = "Modifier la vitesse du NoClip",
});

local selectedMenu = RageUI.CreateSubMenu(mainMenu, "~p~Administration", "~p~0TEX0", 1300) -- 1300 = position
selectedMenu:DisplayGlare(false)

local playerActionMenu = RageUI.CreateSubMenu(mainMenu, "~p~Administration", "~p~0TEX0", 1300)
playerActionMenu:DisplayGlare(false)

local menurapid = RageUI.CreateSubMenu(mainMenu, "~p~Administration", "~p~Menu Admin", 1300)
menurapid:DisplayGlare(true)

local adminmenu = RageUI.CreateSubMenu(mainMenu, "~p~Administration", "~p~Menu Admin", 1300)
adminmenu:DisplayGlare(true)

local utilsmenu = RageUI.CreateSubMenu(mainMenu, "~p~Administration", "~p~Menu Utils", 1300)
utilsmenu:DisplayGlare(true)

local pedmenu = RageUI.CreateSubMenu(mainMenu, "~p~Administration", "~p~Menu Ped", 1300)
pedmenu:DisplayGlare(true)

local vehiculemenu = RageUI.CreateSubMenu(mainMenu, "~p~Administration", "~p~Menu Vehicule", 1300)
vehiculemenu:DisplayGlare(true)

local reportmenu = RageUI.CreateSubMenu(mainMenu, "~p~Administration", "~p~Menu Report", 685)
reportmenu:DisplayGlare(true)


---@class OTEXO
OTEXO = {} or {};

---@class SelfPlayer Administrator current settings
OTEXO.SelfPlayer = {
    ped = 0,
    isStaffEnabled = false,
    isClipping = false,
    isGamerTagEnabled = false,
    isReportEnabled = true,
    isInvisible = false,
    isCarParticleEnabled = false,
    isSteve = false,
    isDelgunEnabled = false,
    isGiveAllGunsEnabled = false,
    isGodModeEnabled = false,
};

OTEXO.SelectedPlayer = {};

OTEXO.Menus = {} or {};

OTEXO.Helper = {} or {}

---@class Players
OTEXO.Players = {} or {} --- Players lists
---
OTEXO.PlayersStaff = {} or {} --- Players Staff

OTEXO.AllReport = {} or {} --- Players Staff


---@class GamerTags
OTEXO.GamerTags = {} or {};

playerActionMenu.onClosed = function()
    OTEXO.SelectedPlayer = {}
end

local NoClip = {
    Camera = nil,
    Speed = 1.0
}

local blips = false

-- blips
Citizen.CreateThread(function()
	while true do
		Wait(1)
		if blips then
			for _, player in pairs(GetActivePlayers()) do
				local found = false
				if player ~= PlayerId() then
					local ped = GetPlayerPed(player)
					local blip = GetBlipFromEntity( ped )
					if not DoesBlipExist( blip ) then
						blip = AddBlipForEntity(ped)
						SetBlipCategory(blip, 7)
						SetBlipScale( blip,  0.85 )
						ShowHeadingIndicatorOnBlip(blip, true)
						SetBlipSprite(blip, 1)
						SetBlipColour(blip, 0)
					end
					
					SetBlipNameToPlayerName(blip, player)
					
					local veh = GetVehiclePedIsIn(ped, false)
					local blipSprite = GetBlipSprite(blip)
					
					if IsEntityDead(ped) then
						if blipSprite ~= 303 then
							SetBlipSprite( blip, 303 )
							SetBlipColour(blip, 1)
							ShowHeadingIndicatorOnBlip( blip, false )
						end
					elseif veh ~= nil then
						if IsPedInAnyBoat( ped ) then
							if blipSprite ~= 427 then
								SetBlipSprite( blip, 427 )
								SetBlipColour(blip, 0)
								ShowHeadingIndicatorOnBlip( blip, false )
							end
						elseif IsPedInAnyHeli( ped ) then
							if blipSprite ~= 43 then
								SetBlipSprite( blip, 43 )
								SetBlipColour(blip, 0)
								ShowHeadingIndicatorOnBlip( blip, false )
							end
						elseif IsPedInAnyPlane( ped ) then
							if blipSprite ~= 423 then
								SetBlipSprite( blip, 423 )
								SetBlipColour(blip, 0)
								ShowHeadingIndicatorOnBlip( blip, false )
							end
						elseif IsPedInAnyPoliceVehicle( ped ) then
							if blipSprite ~= 137 then
								SetBlipSprite( blip, 137 )
								SetBlipColour(blip, 0)
								ShowHeadingIndicatorOnBlip( blip, false )
							end
						elseif IsPedInAnySub( ped ) then
							if blipSprite ~= 308 then
								SetBlipSprite( blip, 308 )
								SetBlipColour(blip, 0)
								ShowHeadingIndicatorOnBlip( blip, false )
							end
						elseif IsPedInAnyVehicle( ped ) then
							if blipSprite ~= 225 then
								SetBlipSprite( blip, 225 )
								SetBlipColour(blip, 0)
								ShowHeadingIndicatorOnBlip( blip, false )
							end
						else
							if blipSprite ~= 1 then
								SetBlipSprite(blip, 1)
								SetBlipColour(blip, 0)
								ShowHeadingIndicatorOnBlip( blip, true )
							end
						end
					else
						if blipSprite ~= 1 then
							SetBlipSprite( blip, 1 )
							SetBlipColour(blip, 0)
							ShowHeadingIndicatorOnBlip( blip, true )
						end
					end
					if veh then
						SetBlipRotation( blip, math.ceil( GetEntityHeading( veh ) ) )
					else
						SetBlipRotation( blip, math.ceil( GetEntityHeading( ped ) ) )
					end
				end
			end
		else
			for _, player in pairs(GetActivePlayers()) do
				local blip = GetBlipFromEntity( GetPlayerPed(player) )
				if blip ~= nil then
					RemoveBlip(blip)
				end
			end
		end
	end
end)

local selectedIndex = 0;

-- pour le fasttravel
local FastTravel = {
    { Name = "Fourriere", Value = vector3(409.16, -1625.47, 29.29) },
    { Name = "Parking central", Value = vector3(215.76, -810.8, 30.72) },
    { Name = "Concessionaire", Value = vector3(-41.84, -1099.72, 26.42) },
    { Name = "Mecano", Value = vector3(-211.44, -1323.68, 30.89) },
}

-- pour les particuls
local ParticleList = {
    { Name = "Trace", Value = { "scr_rcbarry2", "sp_clown_appear_trails" } },
    { Name = "Mario kart", Value = { "scr_rcbarry2", "scr_clown_bul" } },
    { Name = "Mario kart (2)", Value = { "scr_rcbarry2", "muz_clown" } },
    { Name = "Ghost rider", Value = { "core", "ent_amb_foundry_steam_spawn" } },
};

local GroupIndex = 1;
local GroupIndexx = 1;
local GroupIndexxx = 1;
local GroupIndexxxx = 1;
local GroupIndexxxxx = 1;
local PermissionIndex = 1;
local VehicleIndex = 1;
local FastTravelIndex = 1;
local CarParticleIndex = 1;
local idtosanctionbaby = 1;
local idtoreport = 1;
local kvdureport = 1;

function OTEXO.Helper:RetrievePlayersDataByID(source)
    local player = {};
    for i, v in pairs(OTEXO.Players) do
        if (v.source == source) then
            player = v;
        end
    end
    return player;
end

-- noclip
function OTEXO.Helper:onToggleNoClip(toggle)
    if (toggle) then
        Visual.Subtitle("~g~Vous venez d'activer le noclip", 1000)
        if (ESX.GetPlayerData()['group'] ~= "user") then
            if (NoClip.Camera == nil) then
                NoClip.Camera = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
            end
            SetCamActive(NoClip.Camera, true)
            RenderScriptCams(true, false, 0, true, true)
            SetCamCoord(NoClip.Camera, GetEntityCoords(OTEXO.SelfPlayer.ped))
            SetCamRot(NoClip.Camera, GetEntityRotation(OTEXO.SelfPlayer.ped))
            SetEntityCollision(NoClip.Camera, false, false)
            SetEntityVisible(NoClip.Camera, false)
            SetEntityVisible(OTEXO.SelfPlayer.ped, false, false)
        end
    else
        if (ESX.GetPlayerData()['group'] ~= "user") then
            Visual.Subtitle("~p~Vous venez de déactivez le noclip", 1000)
            SetCamActive(NoClip.Camera, false)
            RenderScriptCams(false, false, 0, true, true)
            SetEntityCollision(OTEXO.SelfPlayer.ped, true, true)
            SetEntityCoords(OTEXO.SelfPlayer.ped, GetCamCoord(NoClip.Camera))
            SetEntityHeading(OTEXO.SelfPlayer.ped, GetGameplayCamRelativeHeading(NoClip.Camera))
            if not (OTEXO.SelfPlayer.isInvisible) then
                SetEntityVisible(OTEXO.SelfPlayer.ped, true, false)
            end
        end
    end
end


function OTEXO.Helper:OnRequestGamerTags()
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if (OTEXO.GamerTags[ped] == nil) or (OTEXO.GamerTags[ped].ped == nil) or not (IsMpGamerTagActive(OTEXO.GamerTags[ped].tags)) then
            local colors = {
                ["_dev"] = 'DEV',
                ["superadmin"] = 'FONDATEUR',
                ["admin"] = 'ADMIN',
                ["mod"] = 'MODO',
                ["user"] = 'USER',
            }
            local formatted;
            local group = 0;
            local permission = 0;
            local fetching = OTEXO.Helper:RetrievePlayersDataByID(GetPlayerServerId(player));
            if (fetching) then
                formatted = string.format('[%s] [%d] %s (%s)', colors[fetching.group], GetPlayerServerId(player), GetPlayerName(player), fetching.jobs)
            else
                formatted = string.format('[%s] [%d] %s (%s)', colors[fetching.group], GetPlayerServerId(player), GetPlayerName(player), "~r~Emplois inconnus")
            end
            if (fetching) then
                group = fetching.group
                permission = fetching.permission
            end

            OTEXO.GamerTags[ped] = {
                player = player,
                ped = ped,
                group = group,
                permission = permission,
                tags = CreateFakeMpGamerTag(ped, formatted)
            };
        end

    end
end

function OTEXO.Helper:RequestModel(model)
    if (IsModelValid(model)) then
        if not (HasModelLoaded(model)) then
            RequestModel(model)
            while not HasModelLoaded(model) do
                Visual.Prompt(string.format("OTEXO : Chargement du modèle %s..", model), 4)
                Citizen.Wait(1.0)
            end
            BusyspinnerOff()
            return model;
        else
            Visual.PromptDuration(1000, string.format('OTEXO : Impossible de charger le modèle %s est déjà chargé', model), 1)
            return model;
        end
        Visual.FloatingHelpText(string.format("~r~ OTEXO : Le modèle %s que vous venez de demander n'existe pas dans les fichiers du jeu ou sur le serveur.", model))
        return model;
    end
end


function OTEXO.Helper:RequestPtfx(assetName)
    RequestNamedPtfxAsset(assetName)
    if not (HasNamedPtfxAssetLoaded(assetName)) then
        while not HasNamedPtfxAssetLoaded(assetName) do
            Citizen.Wait(1.0)
        end
        return assetName;
    else
        return assetName;
    end
end

function OTEXO.Helper:CreateVehicle(model, vector3)
    self:RequestModel(model)
    local vehicle = CreateVehicle(model, vector3, 100.0, true, false)
    local id = NetworkGetNetworkIdFromEntity(vehicle)

    SetNetworkIdCanMigrate(id, true)
    SetEntityAsMissionEntity(vehicle, false, false)
    SetModelAsNoLongerNeeded(model)

    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleOnGroundProperly(vehicle)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetVehRadioStation(vehicle, 'OFF')
    while not HasCollisionLoadedAroundEntity(vehicle) do
        Citizen.Wait(0)
    end
    return vehicle, GetEntityCoords(vehicle);
end

function OTEXO.Helper:KeyboardInput(TextEntry, ExampleText, MaxStringLength, OnlyNumber)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", 500)
    local blocking = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blocking = false
        if (OnlyNumber) then
            local number = tonumber(result)
            if (number ~= nil) then
                return number
            end
            return nil
        else
            return result
        end
    else
        Citizen.Wait(500)
        blocking = false
        return nil
    end
end

function OTEXO.Helper:OnGetPlayers()
    local clientPlayers = false;
    ESX.TriggerServerCallback('OTEXO:retrievePlayers', function(players)
        clientPlayers = players
    end)

    while not clientPlayers do
        Citizen.Wait(0)
    end
    return clientPlayers
end

function OTEXO.Helper:OnGetStaffPlayers()
    local clientPlayers = false;
    ESX.TriggerServerCallback('OTEXO:retrieveStaffPlayers', function(players)
        clientPlayers = players
    end)
    while not clientPlayers do
        Citizen.Wait(0)
    end
    return clientPlayers
end

function OTEXO.Helper:GetReport()
    ESX.TriggerServerCallback('OTEXO:retrieveReport', function(allreport)
        ReportBB = allreport
    end)
    while not ReportBB do
        Citizen.Wait(0)
    end
    return ReportBB
end

RegisterNetEvent("OTEXO:RefreshReport")
AddEventHandler("OTEXO:RefreshReport", function()
    OTEXO.GetReport = OTEXO.Helper:GetReport()
end)


function OTEXO.Helper:onStaffMode(status)
    if (status) then
        Visual.Subtitle("🧪 ~r~ Mode admin actif 🧪", 10000)
        OTEXO.PlayersStaff = OTEXO.Helper:OnGetStaffPlayers()
        OTEXO.GetReport = OTEXO.Helper:GetReport()
    else
        if (OTEXO.SelfPlayer.isClipping) then
            OTEXO.Helper:onToggleNoClip(false)
        end
        if (OTEXO.SelfPlayer.isInvisible) then
            OTEXO.SelfPlayer.isInvisible = false;
            SetEntityVisible(OTEXO.SelfPlayer.ped, true, false)
        end
    end
end

function OTEXO.Helper:NetworkedParticleFx(assets, effect, car, boneid, scale)
    OTEXO.Helper:RequestPtfx(assets)
    UseParticleFxAsset(assets)
    local bone = GetWorldPositionOfEntityBone(car, boneid)
    StartNetworkedParticleFxNonLoopedAtCoord(effect, bone.x, bone.y, bone.z, 0.0, 0.0, 0.0, scale, false, false, false, false)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if (OTEXO.SelfPlayer.isStaffEnabled) then
            OTEXO.Players = OTEXO.Helper:OnGetPlayers()
            OTEXO.PlayersStaff = OTEXO.Helper:OnGetStaffPlayers()
            OTEXO.GetReport = OTEXO.Helper:GetReport()
        end
    end
end)


RegisterNetEvent("OTEXO:menu1")
AddEventHandler("OTEXO:menu1", function()
    OTEXO.Players = OTEXO.Helper:OnGetPlayers();
    OTEXO.PlayersStaff = OTEXO.Helper:OnGetStaffPlayers()
    OTEXO.GetReport = OTEXO.Helper:GetReport()
    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
end)

RegisterNetEvent("OTEXO:menu2")
AddEventHandler("OTEXO:menu2", function()
    OTEXO.GetReport = OTEXO.Helper:GetReport()
    RageUI.Visible(reportmenu, not RageUI.Visible(reportmenu))
end)

-- MENU ADMIN
Citizen.CreateThread(function()
    while true do

        Citizen.Wait(1)

        if (IsControlJustPressed(0, 57)) then
            TriggerServerEvent("OTEXO:ouvrirmenu1")
            print("Presse Key - F10")
        end

        if (IsControlJustPressed(0, 344)) then
            TriggerServerEvent("OTEXO:ouvrirmenu2")
            print("Presse Key - F11")
        end



        RageUI.IsVisible(mainMenu, function()
            RageUI.Checkbox("Staff mode", "Le mode staff ne peut être utilisé que pour ~r~modérer~s~ le serveur, ~r~tout abus sera sévèrement puni~s~, l'intégrité de vos actions sera ~r~enregistrée!!", OTEXO.SelfPlayer.isStaffEnabled, { }, {
                onChecked = function()
                    OTEXO.Helper:onStaffMode(true)
                    TriggerServerEvent('OTEXO:onStaffJoin')
                    serverInteraction = true
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            TriggerEvent('skinchanger:loadClothes', skin, {
                            ['bags_1'] = 0, ['bags_2'] = 0,
                            ['tshirt_1'] = 130, ['tshirt_2'] = 0,
                            ['torso_1'] = 178, ['torso_2'] = 5,
                            ['arms'] = 179,
                            ['pants_1'] = 77, ['pants_2'] = 5,
                            ['shoes_1'] = 55, ['shoes_2'] = 5,
                            ['mask_1'] = 0, ['mask_2'] = 0,
                            ['bproof_1'] = 0,
                            ['chain_1'] = 0,
                            ['helmet_1'] = 91, ['helmet_2'] = 5, 
                        })
                    end)
                end,
                onUnChecked = function()
                    OTEXO.Helper:onStaffMode(false)
                    TriggerServerEvent('OTEXO:onStaffLeave')
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                end,
                onSelected = function(Index)
                    OTEXO.SelfPlayer.isStaffEnabled = Index
                end
            })

            RageUI.Separator(cVarLong() .."→→ 🧪 ←←")

            RageUI.Separator(cVarLongE() .. "•~s~ STAFF [~r~" ..GetPlayerName(source).."~s~] | ID [~r~"..GetPlayerServerId(source).."~s~]")

            RageUI.Separator(string.format(cVarLongE() .. '•~s~ Staff en lignes  [~r~%s~s~]', #OTEXO.PlayersStaff))
 
            RageUI.Separator(string.format(cVarLongE() .. '•~s~ Joueurs en lignes  [~r~%s~s~]', #OTEXO.Players))

            if (OTEXO.SelfPlayer.isStaffEnabled) then
                
                RageUI.Separator(cVarLong() .."↓ ~p~MENU RAPIDE~s~".. cVarLong() .."↓")

                -- Mon ajout
                RageUI.Checkbox('Give all weapons', nil ,OTEXO.SelfPlayer.isGiveAllGunsEnabled, { }, {
                    
                    onChecked = function()
                        for k,v in pairs(Config.Arme) do
                            GiveWeaponToPed(PlayerPedId(), GetHashKey(v.hash), 1000, false, false)
                        end
                    end,
                    onUnChecked = function()
                        for k,v in pairs(Config.Arme) do
                            RemoveWeaponFromPed(PlayerPedId(), GetHashKey(v.hash), 1000, false, false)
                        end
                    end,
                    onSelected = function(Index)
                        OTEXO.SelfPlayer.isGiveAllGunsEnabled = Index
                    end
                })

                RageUI.Button(cVarLong() ..'→→ ~s~Spawn Voiture', nil, { }, true, {
                    onSelected = function()
                        local id = KeyboardInput('OTEXO_BOX_TP', "Nom véhicule",'oppressor2', 25)

                        local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
                        local veh = id
                        if veh == nil then veh = "adder" end
                        vehiclehash = GetHashKey(veh)
                        RequestModel(vehiclehash)
    
                        Citizen.CreateThread(function() 
                            local waiting = 0
                            while not HasModelLoaded(vehiclehash) do
                                waiting = waiting + 100
                                Citizen.Wait(100)
                                if waiting > 5000 then
                                    ShowNotification("~r~Could not load the vehicle model in time, a crash was prevented.")
                                    break
                                end
                            end
                            ESX.Game.SpawnVehicle(vehiclehash, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId())+90, function(vehicle)
                                TaskWarpPedIntoVehicle(PlayerPedId(), vehiclehash, -1)
                            end)
                        end)
                    end
                })

                RageUI.Button(cVarLong() .."→→ ~s~Custom au maximum", nil, { }, true, {
                    onSelected = function()
					    if IsPedInAnyVehicle(PlayerPedId(), false) then
		                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
		                    SetVehicleModKit(vehicle, 0)
		                    SetVehicleMod(vehicle, 14, 0, true)
		                    SetVehicleNumberPlateTextIndex(vehicle, 5)
                            SetVehicleNumberPlateText(vehicle, "ADMIN")
		                    ToggleVehicleMod(vehicle, 18, true)
		                    SetVehicleColours(vehicle, 12, 27)
		                    SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
		                    SetVehicleModColor_2(vehicle, 5, 0)
		                    SetVehicleExtraColours(vehicle, 111, 111)
		                    SetVehicleWindowTint(vehicle, 2)
		                    ToggleVehicleMod(vehicle, 22, true)
		                    SetVehicleMod(vehicle, 23, 11, false)
		                    SetVehicleMod(vehicle, 24, 11, false)
		                    SetVehicleWheelType(vehicle, 12) 
		                    SetVehicleWindowTint(vehicle, 3)
		                    ToggleVehicleMod(vehicle, 20, true)
		                    SetVehicleTyreSmokeColor(vehicle, 0, 0, 0)
		                    LowerConvertibleRoof(vehicle, true)
		                    SetVehicleIsStolen(vehicle, false)
		                    SetVehicleIsWanted(vehicle, false)
		                    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		                    SetVehicleNeedsToBeHotwired(vehicle, false)
		                    SetCanResprayVehicle(vehicle, true)
		                    SetPlayersLastVehicle(vehicle)
		                    SetVehicleFixed(vehicle)
		                    SetVehicleDeformationFixed(vehicle)
		                    SetVehicleTyresCanBurst(vehicle, false)
		                    SetVehicleWheelsCanBreak(vehicle, false)
		                    SetVehicleCanBeTargetted(vehicle, false)
		                    SetVehicleExplodesOnHighExplosionDamage(vehicle, false)
		                    SetVehicleHasStrongAxles(vehicle, true)
		                    SetVehicleDirtLevel(vehicle, 0)
		                    SetVehicleCanBeVisiblyDamaged(vehicle, false)
		                    IsVehicleDriveable(vehicle, true)
		                    SetVehicleEngineOn(vehicle, true, true)
		                    SetVehicleStrong(vehicle, true)
		                    RollDownWindow(vehicle, 0)
		                    RollDownWindow(vehicle, 1)
		                    SetVehicleNeonLightEnabled(vehicle, 0, true)
		                    SetVehicleNeonLightEnabled(vehicle, 1, true)
		                    SetVehicleNeonLightEnabled(vehicle, 2, true)
		                    SetVehicleNeonLightEnabled(vehicle, 3, true)
		                    SetVehicleNeonLightsColour(vehicle, 0, 0, 255)
		                    SetPedCanBeDraggedOut(PlayerPedId(), false)
		                    SetPedStayInVehicleWhenJacked(PlayerPedId(), true)
		                    SetPedRagdollOnCollision(PlayerPedId(), false)
		                    ResetPedVisibleDamage(PlayerPedId())
		                    ClearPedDecorations(PlayerPedId())
		                    SetIgnoreLowPriorityShockingEvents(PlayerPedId(), true)
		                    for i = 0,14 do
			                    SetVehicleExtra(veh, i, 0)
		                    end
		                    SetVehicleModKit(veh, 0)
		                    for i = 0,49 do
			                    local custom = GetNumVehicleMods(veh, i)
			                    for j = 1,custom do
				                    SetVehicleMod(veh, i, math.random(1,j), 1)
			                    end
		                    end
                            Citizen.InvokeNative(0xC8E9B6B71B8E660D, vehicle, true, 2.5, 2.5, 4.0, false)
	                    end
                    end
                })

                RageUI.Separator(cVarLong() .."↓ ~p~INTERACTION~s~".. cVarLong() .."↓")

                RageUI.Button(cVarLong() ..'→→ ~s~Liste des staffs', nil, { }, true, {
                    onSelected = function()
                        ESX.ShowNotification(string.format('Staff en lignes [~b~%s~s~]', #OTEXO.PlayersStaff))
                        selectedMenu:SetSubtitle(string.format('~p~Staff en lignes [%s]', #OTEXO.PlayersStaff))
                        selectedIndex = 2;
                    end
                }, selectedMenu)

                RageUI.Button(cVarLong() ..'→→ ~s~Liste des joueurs', nil, { }, true, { 
                    onSelected = function()
                        ESX.ShowNotification(string.format('Joueurs en lignes [~b~%s~s~]', #OTEXO.Players)) 
                        selectedMenu:SetSubtitle(string.format('~p~Joueurs en lignes [%s]', #OTEXO.Players))  
                        selectedIndex = 1;
                    end
                }, selectedMenu)

                RageUI.Button(cVarLong() .. '→→ ~s~Liste des reports', nil, {  }, true, {
                    onSelected = function()
                    end
                }, reportmenu)

                RageUI.Separator(cVarLong() .."↓ ~p~MENU ~s~".. cVarLong() .."↓")

                RageUI.Button(cVarLong() ..'→ ~s~ Menu Admin', nil, { }, true, {
                    onSelected = function()
                    end
                }, adminmenu)

                RageUI.Button(cVarLong() ..'→ ~s~ Menu Rapid', nil, { }, true, {
                    onSelected = function()
                    end
                }, menurapid)
                
                
                RageUI.Button(cVarLong() ..'→ ~s~ Menu Ped', nil, { }, true, {
                    onSelected = function()
                    end
                }, pedmenu)

                RageUI.Button(cVarLong() ..'→ ~s~Menu Vehicule', nil, { }, true, {
                    onSelected = function()
                    end
                }, vehiculemenu)

                RageUI.Button(cVarLong() ..'→ ~s~ Menu Utils', nil, { }, true, {
                    onSelected = function()
                    end
                }, utilsmenu)

            end
        end)

        if (OTEXO.SelfPlayer.isStaffEnabled) then
            RageUI.IsVisible(utilsmenu, function()

                RageUI.Checkbox("Delgun", nil, OTEXO.SelfPlayer.isDelgunEnabled, { }, {
                    onChecked = function()
                        TriggerServerEvent("OTEXO:SendLogs", "Active Delgun")
                        local weapon = GetHashKey("weapon_assaultsmg")
                        local ped = GetPlayerPed(PlayerId())
                        GiveWeaponToPed(ped, weapon, 1000, false, true)
                    end,
                    onUnChecked = function()
                        TriggerServerEvent("OTEXO:SendLogs", "Désactive Delgun")
                        local weapon = GetHashKey("weapon_assaultsmg")
                        local ped = GetPlayerPed(PlayerId())
                        RemoveWeaponFromPed(ped, weapon, 1000, false, true)
                    end,
                    onSelected = function(Index)
                        OTEXO.SelfPlayer.isDelgunEnabled = Index
                    end
                })

                RageUI.List('Fast Travel', FastTravel, FastTravelIndex, nil, {}, true, {
                    onListChange = function(Index, Item)
                        FastTravelIndex = Index;
                    end,
                    onSelected = function(Index, Item)
                        SetEntityCoords(PlayerPedId(), Item.Value)
                    end,
                })

                RageUI.Checkbox("Particule sur les roue", nil, OTEXO.SelfPlayer.isCarParticleEnabled, { }, {
                    onChecked = function()
                        TriggerServerEvent("OTEXO:SendLogs", "Active Particle on wheel")
                    end,
                    onUnChecked = function()
                        TriggerServerEvent("OTEXO:SendLogs", "Désactive Particle on wheel")
                    end,
                    onSelected = function(Index)
                        OTEXO.SelfPlayer.isCarParticleEnabled = Index
                    end
                })

                if (OTEXO.SelfPlayer.isCarParticleEnabled) then
                    RageUI.List('Particule sur les roue (Type)', ParticleList, CarParticleIndex, nil, {}, true, {
                        onListChange = function(Index, Item)
                            CarParticleIndex = Index;
                        end,
                        onSelected = function(Index, Item)

                        end,
                    })
                end
            end)
        end


        if (OTEXO.SelfPlayer.isStaffEnabled) then
            RageUI.IsVisible(pedmenu, function()

                RageUI.Button('Reprendre son personnage', nil, {}, true, {
                    onSelected = function()
                        SetParticlePed()
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                            local isMale = skin.sex == 0
        
        
                            TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                    TriggerEvent('esx:restoreLoadout')
                            end)
                            end)
                            end) 
                        end
                }, pedmenu)

                RageUI.Separator("↓ ~p~Ped ~s~↓")

                RageUI.Button('Robot', nil, {}, true, {
                    onSelected = function()
                        SetParticlePed()
                        local j1 = PlayerId()
                    local p1 = GetHashKey('u_m_y_rsranger_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                        Wait(100)
                        end
                        SetPlayerModel(j1, p1)
                        SetModelAsNoLongerNeeded(p1)
                    end  
                }, pedmenu)

                RageUI.Button('Apu', nil, {}, true, {
                    onSelected = function()
                        SetParticlePed()
                        local j1 = PlayerId()
                        local p1 = GetHashKey('g_f_y_lost_01')
                        RequestModel(p1)
                        while not HasModelLoaded(p1) do
                            Wait(100)
                            end
                            SetPlayerModel(j1, p1)
                            SetModelAsNoLongerNeeded(p1)
                        end  
                }, pedmenu)

                RageUI.Button('Apu 2', nil, {}, true, {
                    onSelected = function()
                        SetParticlePed()
                        local j1 = PlayerId()
                    local p1 = GetHashKey('s_f_y_bartender_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                        Wait(100)
                        end
                        SetPlayerModel(j1, p1)
                        SetModelAsNoLongerNeeded(p1)
                    end   
                }, pedmenu)

                RageUI.Button('Pogo Wish', nil, {}, true, {
                    onSelected = function()
                        SetParticlePed()
                        local j1 = PlayerId()
                        local p1 = GetHashKey('u_m_m_streetart_01')
                        RequestModel(p1)
                        while not HasModelLoaded(p1) do
                            Wait(100)
                            end
                            SetPlayerModel(j1, p1)
                            SetModelAsNoLongerNeeded(p1)
                        end 
                }, pedmenu)

                RageUI.Button('Pogo', nil, {}, true, {
                    onSelected = function()
                        SetParticlePed()
                        local j1 = PlayerId()
                    local p1 = GetHashKey('u_m_y_pogo_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                    end
                }, pedmenu)

                RageUI.Button('Mime', nil, {}, true, {
                    onSelected = function()  
                        SetParticlePed()
                        local j1 = PlayerId()
                        local p1 = GetHashKey('s_m_y_mime')
                        RequestModel(p1)
                        while not HasModelLoaded(p1) do
                          Wait(100)
                         end
                         SetPlayerModel(j1, p1)
                         SetModelAsNoLongerNeeded(p1)
                        end 
                }, pedmenu)

                RageUI.Button('Jésus', nil, {}, true, {
                    onSelected = function()     
                        SetParticlePed()
                            local j1 = PlayerId()
                            local p1 = GetHashKey('u_m_m_jesus_01')
                            RequestModel(p1)
                            while not HasModelLoaded(p1) do
                              Wait(100)
                             end
                             SetPlayerModel(j1, p1)
                             SetModelAsNoLongerNeeded(p1)
                            end
                }, pedmenu)

                RageUI.Button('The Rock', nil, {}, true, {
                    onSelected = function()  
                        SetParticlePed()  
                            local j1 = PlayerId()
                    local p1 = GetHashKey('u_m_y_babyd')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                    end 
                }, pedmenu)

                RageUI.Button('Zombie', nil, {}, true, {
                    onSelected = function()     
                        SetParticlePed()
                            local j1 = PlayerId()
                            local p1 = GetHashKey('u_m_y_zombie_01')
                            RequestModel(p1)
                            while not HasModelLoaded(p1) do
                              Wait(100)
                             end
                             SetPlayerModel(j1, p1)
                             SetModelAsNoLongerNeeded(p1)
                            end  
                }, pedmenu)

                RageUI.Button('Sonic', nil, {}, true, {
                    onSelected = function()     
                        SetParticlePed()
                            local j1 = PlayerId()
                            local p1 = GetHashKey('Sonic')
                            RequestModel(p1)
                            while not HasModelLoaded(p1) do
                              Wait(100)
                             end
                             SetPlayerModel(j1, p1)
                             SetModelAsNoLongerNeeded(p1)
                            end  
                }, pedmenu)

                RageUI.Button('Nc_Pepe', nil, {}, true, {
                    onSelected = function()     
                        SetParticlePed()
                            local j1 = PlayerId()
                            local p1 = GetHashKey('Nc_Pepe')
                            RequestModel(p1)
                            while not HasModelLoaded(p1) do
                              Wait(100)
                             end
                             SetPlayerModel(j1, p1)
                             SetModelAsNoLongerNeeded(p1)
                            end  
                }, pedmenu)

                RageUI.Button('patrick', nil, {}, true, {
                    onSelected = function()    
                        SetParticlePed() 
                            local j1 = PlayerId()
                            local p1 = GetHashKey('patrick')
                            RequestModel(p1)
                            while not HasModelLoaded(p1) do
                              Wait(100)
                             end
                             SetPlayerModel(j1, p1)
                             SetModelAsNoLongerNeeded(p1)
                            end  
                }, pedmenu)

                RageUI.Button('Ada_Wong', nil, {}, true, {
                    onSelected = function()  
                        SetParticlePed()   
                            local j1 = PlayerId()
                            local p1 = GetHashKey('Ada_Wong')
                            RequestModel(p1)
                            while not HasModelLoaded(p1) do
                              Wait(100)
                             end
                             SetPlayerModel(j1, p1)
                             SetModelAsNoLongerNeeded(p1)
                            end  
                }, pedmenu)

                RageUI.Button('Asian', nil, {}, true, {
                    onSelected = function()     
                        SetParticlePed()
                            local j1 = PlayerId()
                            local p1 = GetHashKey('AsianGirl')
                            RequestModel(p1)
                            while not HasModelLoaded(p1) do
                              Wait(100)
                             end
                             SetPlayerModel(j1, p1)
                             SetModelAsNoLongerNeeded(p1)
                            end  
                }, pedmenu)

            end)
        end

        if (OTEXO.SelfPlayer.isStaffEnabled) then
            RageUI.IsVisible(vehiculemenu, function()
                RageUI.List('Vehicles', {
                    { Name = "BMX", Value = 'bmx' },
                    { Name = "Club", Value = 'club' },
                    { Name = "Panto", Value = 'panto' },
                    { Name = "Blista", Value = "Blista" },
                    { Name = "Sanchez", Value = 'sanchez' },
                }, VehicleIndex, nil, {}, true, {
                    onListChange = function(Index, Item)
                        VehicleIndex = Index;
                    end,
                    onSelected = function(Index, Item)
                        if Item.Value == nil then
                            local modelName = KeyboardInput('OTEXO_BOX_VEHICLE_NAME', "Nom du vehicule", '', 50)
                            TriggerEvent('OTEXO:spawnVehicle', modelName)
                            TriggerServerEvent("OTEXO:SendLogs", "Spawn custom vehicle")
                        else
                            TriggerEvent('OTEXO:spawnVehicle', Item.Value)
                            TriggerServerEvent("OTEXO:SendLogs", "Spawn vehicle")
                        end
                    end,
                })
                RageUI.Button('Réparation du véhicule', nil, { }, true, {
                    onSelected = function()
                        local plyVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                        SetVehicleFixed(plyVeh)
                        SetVehicleDirtLevel(plyVeh, 0.0)
                        TriggerServerEvent("OTEXO:SendLogs", "Repair Vehicle")
                    end
                })

                RageUI.List('Suppression des véhicules (Zone)', {
                    { Name = "1", Value = 1 },
                    { Name = "5", Value = 5 },
                    { Name = "10", Value = 10 },
                    { Name = "15", Value = 15 },
                    { Name = "20", Value = 20 },
                    { Name = "25", Value = 25 },
                    { Name = "30", Value = 30 },
                    { Name = "50", Value = 50 },
                    { Name = "100", Value = 100 },
                }, GroupIndex, nil, {}, true, {
                    onListChange = function(Index, Item)
                        GroupIndex = Index;
                    end,
                    onSelected = function(Index, Item)
                        TriggerServerEvent("OTEXO:SendLogs", "Delete vehicle zone")
                        local playerPed = PlayerPedId()
                        local radius = Item.Value
                        if radius and tonumber(radius) then
                            radius = tonumber(radius) + 0.01
                            local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(playerPed, false), radius)

                            for i = 1, #vehicles, 1 do
                                local attempt = 0

                                while not NetworkHasControlOfEntity(vehicles[i]) and attempt < 100 and DoesEntityExist(vehicles[i]) do
                                    Citizen.Wait(100)
                                    NetworkRequestControlOfEntity(vehicles[i])
                                    attempt = attempt + 1
                                end

                                if DoesEntityExist(vehicles[i]) and NetworkHasControlOfEntity(vehicles[i]) then
                                    ESX.Game.DeleteVehicle(vehicles[i])
                                    DeleteEntity(vehicles[i])
                                end
                            end
                        else
                            local vehicle, attempt = ESX.Game.GetVehicleInDirection(), 0

                            if IsPedInAnyVehicle(playerPed, true) then
                                vehicle = GetVehiclePedIsIn(playerPed, false)
                            end

                            while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
                                Citizen.Wait(100)
                                NetworkRequestControlOfEntity(vehicle)
                                attempt = attempt + 1
                            end

                            if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
                                ESX.Game.DeleteVehicle(vehicle)
                                DeleteEntity(vehicle)
                            end
                        end
                    end,
                })
            end)
        end

        if (OTEXO.SelfPlayer.isStaffEnabled) then
            RageUI.IsVisible(menurapid, function()
                
                
                RageUI.Separator("↓ ~p~Action rapides ~s~↓")

                

                RageUI.Button('Se teleporter sur lui', nil, {}, true, {
                    onSelected = function()
                        local id = KeyboardInput('OTEXO_BOX_TP', "ID DE LA PERSONNE",'1', 25)
                        TriggerServerEvent("OTEXO:teleport", id)
                    end
                }, menurapid)

                RageUI.Button('Le teleporter sur moi', nil, {}, true, {
                    onSelected = function()
                        local quelid = KeyboardInput('OTEXO_BOX_TP', "ID DE LA PERSONNE",'1', 25)
                        TriggerServerEvent("OTEXO:teleportTo", quelid)
                    end
                }, menurapid)

                RageUI.Button('Le teleporter au Parking Central', nil, {}, true, {
                    onSelected = function()
                        local quelid = KeyboardInput('OTEXO_BOX_TP', "ID DE LA PERSONNE",'1', 25)
                        TriggerServerEvent('OTEXO:teleportcoords', quelid, vector3(215.76, -810.12, 30.73))
                    end
                }, menurapid)

                RageUI.Separator("↓ ~p~ANNONCE~s~ ↓")

                RageUI.Button('Annonce', "~r~Perm~s~: ~n~admin, superadmin", {}, true, {
                    onSelected = function()
                        local quelid = KeyboardInput('OTEXO_BOX_ANNONCE', "Message", "~~ ~~ ~~ ~~ ~~", 500)
                        TriggerServerEvent('OTEXO:annonce', quelid)
                    end
                }, menurapid)

                RageUI.Separator("↓ ~p~ADMIN~s~ ↓")
               
                RageUI.Button('Reviveall', "~r~Revive tout le monde ~n~ ~r~Perm~s~: ~n~admin, superadmin", {}, true, {
                    onSelected = function()
                        TriggerServerEvent('OTEXO:reviveall')
                    end
                }, menurapid)

                RageUI.Button('Save les joueurs', "Save tout les joueurs du serveur~n~ ~r~Perm~s~: ~n~ superadmin", {}, true, {
                    onSelected = function()
                        TriggerServerEvent('OTEXO:SavellPlayerAuto')
                    end
                }, menurapid)

            end)
        end

        if (OTEXO.SelfPlayer.isStaffEnabled) then
            RageUI.IsVisible(adminmenu, function()
                RageUI.Checkbox("Afficher les Noms", "L'affichage les noms des joueurs vous permet de voir les informations des joueurs, y compris de vous reconnaître entre les membres du personnel grâce à votre couleur.", OTEXO.SelfPlayer.isGamerTagEnabled, { }, {
                    onChecked = function()
                        if (ESX.GetPlayerData()['group'] ~= "user") then
                            TriggerServerEvent("OTEXO:SendLogs", "Active Nom")
                            OTEXO.Helper:OnRequestGamerTags()
                        end
                    end,
                    onUnChecked = function()
                        for i, v in pairs(OTEXO.GamerTags) do
                            TriggerServerEvent("OTEXO:SendLogs", "Désactive Nom")
                            RemoveMpGamerTag(v.tags)
                        end
                        OTEXO.GamerTags = {};
                    end,
                    onSelected = function(Index)
                        OTEXO.SelfPlayer.isGamerTagEnabled = Index
                    end
                })
                
                RageUI.Checkbox("NoClip", "Vous permet de vous déplacer librement sur toute la carte sous forme de caméra libre.", OTEXO.SelfPlayer.isClipping, { }, {
                    onChecked = function()
                        TriggerServerEvent("OTEXO:SendLogs", "Active noclip")
                        OTEXO.Helper:onToggleNoClip(true)
                        SetParticle()
                    end,
                    onUnChecked = function()
                        TriggerServerEvent("OTEXO:SendLogs", "Désactive noclip")
                        OTEXO.Helper:onToggleNoClip(false)
                        SetParticle()
                    end,
                    onSelected = function(Index)
                        OTEXO.SelfPlayer.isClipping = Index
                    end
                })
                RageUI.Checkbox("Invisible", nil, OTEXO.SelfPlayer.isInvisible, { }, {
                    onChecked = function()
                        TriggerServerEvent("OTEXO:SendLogs", "Active invisible")
                        SetEntityVisible(OTEXO.SelfPlayer.ped, false, false)
                        SetParticle()
                    end,
                    onUnChecked = function()
                        TriggerServerEvent("OTEXO:SendLogs", "Désactive invisible")
                        SetEntityVisible(OTEXO.SelfPlayer.ped, true, false)
                        SetParticle()
                    end,
                    onSelected = function(Index)
                        OTEXO.SelfPlayer.isInvisible = Index
                    end
                })

                RageUI.Checkbox("Blips", nil, OTEXO.SelfPlayer.IsBlipsActive, { }, {
                    onChecked = function()
                        TriggerServerEvent("OTEXO:SendLogs", "Active Blips")
                        blips = true
                    end,
                    onUnChecked = function()
                        TriggerServerEvent("OTEXO:SendLogs", "Désactive Blips")
                        blips = false
                    end,
                    onSelected = function(Index)
                        OTEXO.SelfPlayer.IsBlipsActive = Index
                    end
                })
            end)
        end


        if (OTEXO.SelfPlayer.isStaffEnabled) then
            RageUI.IsVisible(selectedMenu, function()
                table.sort(OTEXO.Players, function(a,b) return a.source < b.source end)
                if (selectedIndex == 1) then
                    if (#OTEXO.Players > 0) then

                        for i, v in pairs(OTEXO.Players) do
                            local colors = {
                                ["_dev"] = '~r~',
                                ["superadmin"] = '~p~ Fondateur ',
                                ["admin"] = '~r~ admin',
                                ["mod"] = '~b~ modo',
                                ["user"] = 'user',
                            }
                            RageUI.Separator("↓ ~r~GROUPE~s~ ↓ ↓ ~r~NOM~s~ ↓ ↓ ~r~ID~s~ ↓ ↓ ~r~JOB~s~ ↓")
                            RageUI.Button(string.format(cVarLong() .. '→ ~s~ %s  |  %s  |  [%s]  |  %s', colors[v.group], v.name, v.source, v.jobs), nil, {}, true, {
                                onSelected = function()
                                    playerActionMenu:SetSubtitle(string.format('[%s] %s', i, v.name))
                                    OTEXO.SelectedPlayer = v;
                                end
                            }, playerActionMenu)
                        end
                    else
                        RageUI.Separator("Aucun joueurs en ligne.")
                    end
                end
                if (selectedIndex == 2) then
                    if (#OTEXO.PlayersStaff > 0) then
                        for i, v in pairs(OTEXO.PlayersStaff) do
                            local colors = {
                                ["_dev"] = '~r~',
                                ["superadmin"] = '~p~ Fondateur ',
                                ["admin"] = '~r~ admin',
                                ["mod"] = '~b~ modo',
                            }
                            RageUI.Separator("↓ ~r~GROUPE~s~ ↓ ↓ ~r~NOM~s~ ↓ ↓ ~r~ID~s~ ↓ ↓ ~r~JOB~s~ ↓")
                            RageUI.Button(string.format(cVarLong() .. '→ ~s~ %s  |  %s  |  [%s]  |  %s', colors[v.group], v.name, v.source, v.jobs), nil, {}, true, {
                                onSelected = function()
                                    playerActionMenu:SetSubtitle(string.format('[%s] %s', v.source, v.name))
                                    OTEXO.SelectedPlayer = v;
                                end
                            }, playerActionMenu)
                        end
                    else
                        RageUI.Separator("Aucun joueurs en ligne.")
                    end
                end

                if (selectedIndex == 4) then
                    for i, v in pairs(OTEXO.Players) do
                        if v.source == idtosanctionbaby then
                            RageUI.Separator("↓ ~p~INFORMATION ~s~↓")
                            RageUI.Button('Groupe : ' .. v.group, nil, {}, true, {
                                onSelected = function()
                                end
                            })
                            RageUI.Button('ID : ' .. idtosanctionbaby, nil, {}, true, {
                                onSelected = function()
                                end
                            })
        
                            RageUI.Button('Nom : ' .. v.name, nil, {}, true, {
                                onSelected = function()
                                end
                            })
                            RageUI.Button('Jobs : ' .. v.jobs, nil, {}, true, {
                                onSelected = function()
                                end
                            })
                        end
                    end
                    RageUI.Separator("↓~p~ SANCTION~s~ ↓")
                    RageUI.Button('Raison du kick', nil, { RightLabel = raisontosend }, true, {
                        onSelected = function()
                            local Raison = KeyboardInput('OTEXO_BOX_BAN_RAISON', "Raison du kick", '', 50)
                            raisontosend = Raison
                        end
                    })

                    RageUI.Button('Valider', nil, { RightLabel = "✅" }, true, {
                        onSelected = function()
                            TriggerServerEvent("OTEXO:kick", idtosanctionbaby, raisontosend)
                        end
                    })
                end
                if (selectedIndex == 6) then
                    for i, v in pairs(OTEXO.Players) do
                        if v.source == idtoreport then
                            RageUI.Separator("↓ ~p~INFORMATION ~s~↓")
                            RageUI.Button('Groupe : ~b~' .. v.group, nil, {}, true, {
                                onSelected = function()
                                end
                            })
                            RageUI.Button('ID : ~r~' .. idtoreport, nil, {}, true, {
                                onSelected = function()
                                end
                            })
        
                            RageUI.Button('Nom : ~o~' .. v.name, nil, {}, true, {
                                onSelected = function()
                                end
                            })
                            RageUI.Button('Jobs : ' .. v.jobs, nil, {}, true, {
                                onSelected = function()
                                end
                            })
                        end
                    end

                    RageUI.Separator("↓~p~ ACTION RAPIDE ~s~↓")
                    RageUI.Button('Se teleporter sur lui', nil, {}, true, {
                        onSelected = function()
                            TriggerServerEvent("OTEXO:teleport", idtoreport)
                        end
                    })
                    RageUI.Separator("")
                    RageUI.Button('Le teleporter sur moi', nil, {}, true, {
                        onSelected = function()
                            TriggerServerEvent("OTEXO:teleportTo", idtoreport)
                        end
                    })
                    RageUI.Button('Le teleporter au Parking Central', nil, {}, true, {
                        onSelected = function()
                            TriggerServerEvent('OTEXO:teleportcoords', idtoreport, vector3(215.76, -810.12, 30.73))
                        end
                    })

                    RageUI.Button('Réanimer le joueur ', nil, {}, true, {
                        onSelected = function()
                            TriggerServerEvent("OTEXO:Revive", idtoreport)
                        end
                    })
                    

                    RageUI.Separator("↓~p~ REPORT~s~ ↓")
                    RageUI.Button('~g~Report Réglée', nil, { }, true, {
                        onSelected = function()
                            TriggerServerEvent("OTEXO:ReportRegle", kvdureport)
                            TriggerEvent("OTEXO:RefreshReport")
                        end
                    }, reportmenu)
                end
            end)

            --test
            RageUI.IsVisible(playerActionMenu, function()
                RageUI.Separator("↓ ~p~INFORMATION ~s~↓")

                for i, v in pairs(OTEXO.Players) do
                    if v.source == OTEXO.SelectedPlayer.source then
                        local colors = {
                            ["_dev"] = '~r~dev',
                            ["superadmin"] = '~u~ Fondateur ',
                            ["admin"] = '~r~ admin',
                            ["mod"] = '~b~ modo',
                            ["user"] = '~g~user',
                        }
                        RageUI.Button('Groupe : ' .. colors[v.group], nil, {}, true, {
                            onSelected = function()
                            end
                        })
                        RageUI.Button('Role : ~b~' .. v.group, nil, {}, true, {
                            onSelected = function()
                            end
                        })
                        RageUI.Button('ID : ~g~' .. v.source, nil, {}, true, {
                            onSelected = function()
                            end
                        })
                        RageUI.Button('Nom : ' .. v.name, nil, {}, true, {
                            onSelected = function()
                            end
                        })
                        RageUI.Button('Jobs : ' .. v.jobs, nil, {}, true, {
                            onSelected = function()
                            end
                        })
                        end
                    end

                RageUI.Separator("↓ ~p~TELEPORTATION~s~ ↓")

                RageUI.Button('Vous téléporté sur lui', nil, {}, true, {
                    
                    onSelected = function()
                        TriggerServerEvent('OTEXO:teleport', OTEXO.SelectedPlayer.source)
                    end
                })
                
                RageUI.Button('Téléporté vers vous', nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent('OTEXO:teleportTo', OTEXO.SelectedPlayer.source)
                    end
                })

                RageUI.Button('Le téléporté au Parking Central', nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent('OTEXO:teleportcoords', OTEXO.SelectedPlayer.source, vector3(215.76, -810.12, 30.73))
                    end
                })

                RageUI.Button('Le téléporté sur un toit', nil, {}, true, {
                    onSelected  = function()
                        TriggerServerEvent('OTEXO:teleporttoit', OTEXO.SelectedPlayer.source, vector3(-75.59, -818.07, 326.17))
                    end
                })

                RageUI.Separator("↓ ~p~JAIL~s~ ↓")

                RageUI.Button('Jail', nil, {}, true, {
                    onSelected  = function()
                        local time = KeyboardInput('OTEXO_BOX_JAIL', "Temps Jail (en minutes)", '', 50)
                        TriggerServerEvent('OTEXO:Jail', OTEXO.SelectedPlayer.source, time)
                    end
                })

                RageUI.Button('~r~Unjail', "~r~Perm~s~: ~n~admin, superadmin", {}, true, {
                    onSelected  = function()
                        TriggerServerEvent('OTEXO:UnJail', OTEXO.SelectedPlayer.source)
                    end
                })

                RageUI.Separator("↓ ~p~MODERATION~s~ ↓")


                RageUI.Button('Message', nil, {}, true, {
                    onSelected = function()
                        local reason = KeyboardInput('OTEXO_BOX_MESSAGE_RAISON', "Message", '', 100)
                        TriggerServerEvent('OTEXO:message', OTEXO.SelectedPlayer.source, reason)
                    end
                })


                RageUI.Button('Clear inventaire', "~r~Perm~s~: ~n~admin, superadmin", {}, true, {
                    onSelected = function()
                        TriggerServerEvent('OTEXO:clearInv', OTEXO.SelectedPlayer.source)
                    end
                })

                RageUI.Button('Clear armes', "~r~Perm~s~: ~n~admin, superadmin", {}, true, {
                    onSelected = function()
                        TriggerServerEvent('OTEXO:clearLoadout', OTEXO.SelectedPlayer.source)
                    end
                })

                RageUI.Button('Wipe', "~r~Perm~s~: ~n~superadmin", {}, true, {
                    onSelected = function()
                        TriggerServerEvent('OTEXO:WipePlayer', OTEXO.SelectedPlayer.source)
                    end
                })
                

                RageUI.Separator("↓ ~p~PERSONNAGE~s~ ↓")

                RageUI.Button('Revive', nil, {}, true, {
                    onSelected = function()
                        ESX.ShowNotification("~p~Revive du joueur en cours...")
                        TriggerServerEvent("OTEXO:Revive", OTEXO.SelectedPlayer.source)
                    end
                })

                RageUI.Button('Prendre Carte d\'identité', nil, {}, true, {
                    onSelected = function()
                        ESX.ShowNotification("~b~Carte d\'identité en cours...")
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId(OTEXO.SelectedPlayer.source)), GetPlayerServerId(PlayerId()));
                    end
                })

                RageUI.Separator("↓ ~p~SANCTION~s~ ↓")

                RageUI.Button('~g~Kick le joueur', nil, {}, true, {
                    onSelected = function()
                        selectedMenu:SetSubtitle(string.format('Kick le joueur'))
                        idtosanctionbaby = OTEXO.SelectedPlayer.source
                        selectedIndex = 4;
                    end
                }, selectedMenu)
                RageUI.Button('~r~Bannir', "Pour bannir vous devez utiliser BanSql", {}, true, {
                    onSelected = function()
                        local days = KeyboardInput('OTEXO_BOX_BAN_RAISON',"Durée du banissement (en heures)", "", 20, true)
                        if days ~= nil then
                            local reason = KeyboardInput('OTEXO_BOX_BAN_RAISON',"Raison", "", 80, false)
                            if reason ~= nil then
                                ESX.ShowNotification("~y~Application de la sanction en cours...")
                                ExecuteCommand(("sqlban %s %s %s"):format(OTEXO.SelectedPlayer.source, days, reason))
                            end
                        end                    end
                }, playerActionMenu)
            end)
            RageUI.IsVisible(reportmenu, function()
                for i, v in pairs(OTEXO.GetReport) do
                    if i == 0 then
                        return
                    end
                    RageUI.Button("[~r~" .. v.id .. "~s~] " .. v.name, "ID : ~r~" .. v.id .. "~s~\n" .. "Name : ~b~" .. v.name .. "~s~\nRaison :~n~~u~ " .. v.reason, {}, true, {
                        onSelected = function()
                            selectedMenu:SetSubtitle(string.format('Report'))
                            kvdureport = i
                            idtoreport = v.id
                            selectedIndex = 6;
                        end
                    }, selectedMenu)
                end
            end)
        end
        for i, onTick in pairs(OTEXO.Menus) do
            onTick();
        end
    end

end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    if (xPlayer.group == "mod" or xPlayer.group == "admin" or xPlayer.group == "superadmin") then
        Keys.Register('F10', 'F10', 'Menu d\'administration', function()
            if (xPlayer.group == "mod" or xPlayer.group == "admin" or xPlayer.group == "superadmin") then
                RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
            end
        end)
    end
end)

local function getEntity(player)
    -- function To Get Entity Player Is Aiming At
    local _, entity = GetEntityPlayerIsFreeAimingAt(player)
    return entity
end

local function aimCheck(player)
    -- function to check config value onAim. If it's off, then
    return IsPedShooting(player)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if (OTEXO.SelfPlayer.isStaffEnabled) then
            if (OTEXO.SelfPlayer.isDelgunEnabled) then
                if IsPlayerFreeAiming(PlayerId()) then
                    local entity = getEntity(PlayerId())
                    if GetEntityType(entity) == 2 or 3 then
                        if aimCheck(GetPlayerPed(-1)) then
                            SetEntityAsMissionEntity(entity, true, true)
                            DeleteEntity(entity)
                        end
                    end
                end
            end

            if (OTEXO.SelfPlayer.isClipping) then
                --HideHudAndRadarThisFrame()

                local camCoords = GetCamCoord(NoClip.Camera)
                local right, forward, _, _ = GetCamMatrix(NoClip.Camera)
                if IsControlPressed(0, 32) then
                    local newCamPos = camCoords + forward * NoClip.Speed
                    SetCamCoord(NoClip.Camera, newCamPos.x, newCamPos.y, newCamPos.z)
                end
                if IsControlPressed(0, 8) then
                    local newCamPos = camCoords + forward * -NoClip.Speed
                    SetCamCoord(NoClip.Camera, newCamPos.x, newCamPos.y, newCamPos.z)
                end
                if IsControlPressed(0, 34) then
                    local newCamPos = camCoords + right * -NoClip.Speed
                    SetCamCoord(NoClip.Camera, newCamPos.x, newCamPos.y, newCamPos.z)
                end
                if IsControlPressed(0, 9) then
                    local newCamPos = camCoords + right * NoClip.Speed
                    SetCamCoord(NoClip.Camera, newCamPos.x, newCamPos.y, newCamPos.z)
                end
                if IsControlPressed(0, 334) then
                    if (NoClip.Speed - 0.1 >= 0.1) then
                        NoClip.Speed = NoClip.Speed - 0.1
                    end
                end
                if IsControlPressed(0, 335) then
                    if (NoClip.Speed + 0.1 >= 0.1) then
                        NoClip.Speed = NoClip.Speed + 0.1
                    end
                end

                SetEntityCoords(OTEXO.SelfPlayer.ped, camCoords.x, camCoords.y, camCoords.z)

                local xMagnitude = GetDisabledControlNormal(0, 1)
                local yMagnitude = GetDisabledControlNormal(0, 2)
                local camRot = GetCamRot(NoClip.Camera)
                local x = camRot.x - yMagnitude * 10
                local y = camRot.y
                local z = camRot.z - xMagnitude * 10
                if x < -75.0 then
                    x = -75.0
                end
                if x > 100.0 then
                    x = 100.0
                end
                SetCamRot(NoClip.Camera, x, y, z)
            end

            if (OTEXO.SelfPlayer.isGamerTagEnabled) then
                for i, v in pairs(OTEXO.GamerTags) do
                    local target = GetEntityCoords(v.ped, false);

                    if #(target - GetEntityCoords(PlayerPedId())) < 120 then
                        SetMpGamerTagVisibility(v.tags, 0, true)
                        SetMpGamerTagVisibility(v.tags, 2, true)

                        SetMpGamerTagVisibility(v.tags, 4, NetworkIsPlayerTalking(v.player))
                        SetMpGamerTagAlpha(v.tags, 2, 255)
                        SetMpGamerTagAlpha(v.tags, 4, 255)

                        local colors = {
                            ["_dev"] = 21,
                            ["superadmin"] = 12,
                            ["admin"] = 27,
                            ["modo"] = 9,
                        }
                        SetMpGamerTagColour(v.tags, 0, colors[v.group] or 0)
                    else
                        RemoveMpGamerTag(v.tags)
                        OTEXO.GamerTags[i] = nil;
                    end
                end


            end

        end
    end
end)

Citizen.CreateThread(function()
    while true do
        OTEXO.SelfPlayer.ped = GetPlayerPed(-1);
        if (OTEXO.SelfPlayer.isStaffEnabled) then
            if (OTEXO.SelfPlayer.isGamerTagEnabled) then
                OTEXO.Helper:OnRequestGamerTags();
            end
        end

        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        if (OTEXO.SelfPlayer.isCarParticleEnabled) then
            local ped = PlayerPedId()
            local car = GetVehiclePedIsIn(ped, false);
            local dics = ParticleList[CarParticleIndex].Value[1];
            local name = ParticleList[CarParticleIndex].Value[2];

            if (car) then
                local wheel_lf = GetEntityBoneIndexByName(car, 'wheel_lf')
                local wheel_lr = GetEntityBoneIndexByName(car, 'wheel_lr')
                local wheel_rf = GetEntityBoneIndexByName(car, 'wheel_rf')
                local wheel_rr = GetEntityBoneIndexByName(car, 'wheel_rr')
                if (wheel_lf) then
                    OTEXO.Helper:NetworkedParticleFx(dics, name, car, wheel_lf, 1.0)
                end
                if (wheel_lr) then
                    OTEXO.Helper:NetworkedParticleFx(dics, name, car, wheel_lr, 1.0)
                end
                if (wheel_rf) then
                    OTEXO.Helper:NetworkedParticleFx(dics, name, car, wheel_rf, 1.0)
                end
                if (wheel_rr) then
                    OTEXO.Helper:NetworkedParticleFx(dics, name, car, wheel_rr, 1.0)
                end
                SetVehicleFixed(car)
                SetVehicleDirtLevel(car, 0.0)
                SetPlayerInvincible(ped, true)
            end
        end
    end
end)

RegisterNetEvent('OTEXO:setGroup')
AddEventHandler('OTEXO:setGroup', function(group, lastGroup)
    player.group = group
end)

RegisterNetEvent('OTEXO:teleport')
AddEventHandler('OTEXO:teleport', function(coords)
    if (OTEXO.SelfPlayer.isClipping) then
        SetCamCoord(NoClip.Camera, coords.x, coords.y, coords.z)
        SetEntityCoords(OTEXO.SelfPlayer.ped, coords.x, coords.y, coords.z)
    else
        ESX.Game.Teleport(PlayerPedId(), coords)
    end
end)

RegisterNetEvent('OTEXO:spawnVehicle')
AddEventHandler('OTEXO:spawnVehicle', function(model)
    if (OTEXO.SelfPlayer.isStaffEnabled) then
        model = (type(model) == 'number' and model or GetHashKey(model))

        if IsModelInCdimage(model) then
            local playerPed = PlayerPedId()
            local plyCoords = GetEntityCoords(playerPed)

            ESX.Game.SpawnVehicle(model, plyCoords, 90.0, function(vehicle)
                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
            end)
        else
            Visual.Subtitle('Invalid vehicle model.', 5000)
        end
    end
end)

local disPlayerNames = 5
local playerDistances = {}

local function DrawText3D(x, y, z, text, r, g, b)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px, py, pz) - vector3(x, y, z))

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        if not useCustomScale then
            SetTextScale(0.0 * scale, 0.55 * scale)
        else
            SetTextScale(0.0 * scale, customScale)
        end
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

Citizen.CreateThread(function()
    Wait(500)
    while true do
        if (OTEXO.SelfPlayer.isGamerTagEnabled) then
            for _, id in ipairs(GetActivePlayers()) do

                if playerDistances[id] then
                    if (playerDistances[id] < disPlayerNames) then
                        x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                        if NetworkIsPlayerTalking(id) then
                            DrawText3D(x2, y2, z2 + 1, GetPlayerServerId(id), 130, 100, 255)
                            DrawMarker(23, x2, y2, z2 - 0.97, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 130, 100, 225, 255, 0, 0, 0, 0)
                        else
                            DrawText3D(x2, y2, z2 + 1, GetPlayerServerId(id), 255, 0, 0)
                        end
                    elseif (playerDistances[id] < 25) then
                        x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                        if NetworkIsPlayerTalking(id) then
                            DrawMarker(23, x2, y2, z2 - 0.97, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 130, 100, 225, 255, 0, 0, 0, 0)
                        end
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        if (OTEXO.SelfPlayer.isGamerTagEnabled) then
            for _, id in ipairs(GetActivePlayers()) do

                x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                distance = math.floor(#(vector3(x1, y1, z1) - vector3(x2, y2, z2)))
                playerDistances[id] = distance
            end
        end
        Citizen.Wait(1000)
    end
end)

-- Objets --

function spawnObject(name)
	local plyPed = PlayerPedId()
	local coords = GetEntityCoords(plyPed, false) + (GetEntityForwardVector(plyPed) * 0.5)

	ESX.Game.SpawnObject(name, coords, function(obj)
		SetEntityHeading(obj, GetEntityPhysicsHeading(plyPed))
		PlaceObjectOnGroundProperly(obj)
	end)
end


-- JAIL ------------

local IsJailed = false
local unjail = false
local JailTime = 0
local fastTimer = 0
local JailLocation = Config.JailLocation


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_jailer:jail')
AddEventHandler('esx_jailer:jail', function(jailTime)
	if IsJailed then 
		return
	end

	JailTime = jailTime
	local sourcePed = GetPlayerPed(-1)
	if DoesEntityExist(sourcePed) then
		Citizen.CreateThread(function()

			-- Clear player
			SetPedArmour(sourcePed, 0)
			ClearPedBloodDamage(sourcePed)
			ResetPedVisibleDamage(sourcePed)
			--ClearPedLastWeaponDamage(sourcePed)
			ResetPedMovementClipset(sourcePed, 0)
			
			SetEntityCoords(sourcePed, JailLocation.x, JailLocation.y, JailLocation.z)
			IsJailed = true
			unjail = false
			while JailTime > 0 and not unjail do
				sourcePed = GetPlayerPed(-1)
				--RemoveAllPedWeapons(sourcePed, false)
				if IsPedInAnyVehicle(sourcePed, false) then
					ClearPedTasksImmediately(sourcePed)
				end

				if JailTime % 120 == 0 then
					TriggerServerEvent('esx_jailer:updateRemaining', JailTime)
				end

				Citizen.Wait(20000)

				-- Is the player trying to escape?
				if GetDistanceBetweenCoords(GetEntityCoords(sourcePed), JailLocation.x, JailLocation.y, JailLocation.z) > 10 then
					SetEntityCoords(sourcePed, JailLocation.x, JailLocation.y, JailLocation.z)
				end
				
				JailTime = JailTime - 20
			end

			-- jail time 
			TriggerServerEvent('esx_jailer:unjailTime', -1)
			SetEntityCoords(sourcePed, Config.JailBlip.x, Config.JailBlip.y, Config.JailBlip.z)
			IsJailed = false

			-- Change back the user skin
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if JailTime > 0 and IsJailed then
			if fastTimer < 0 then
				fastTimer = JailTime
			end
			draw2dText(("il reste ~r~%s~s~ secondes jusqu’à ce que vous êtes libéré de ~p~prison"):format(ESX.Round(fastTimer)), { 0.390, 0.955 } )
			fastTimer = fastTimer - 0.01
		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent('esx_jailer:unjail')
AddEventHandler('esx_jailer:unjail', function(source)
	unjail = true
	JailTime = 0
	fastTimer = 0
end)

-- When player respawns / joins
AddEventHandler('playerSpawned', function(spawn)
	if IsJailed then
		SetEntityCoords(GetPlayerPed(-1), JailLocation.x, JailLocation.y, JailLocation.z)
	else
		TriggerServerEvent('esx_jailer:checkJail')
	end
end)

-- When script starts
Citizen.CreateThread(function()
	Citizen.Wait(2000) -- wait for mysql-async to be ready, this should be enough time
	TriggerServerEvent('esx_jailer:checkJail')
end)


function draw2dText(text, pos)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(table.unpack(pos))
end
