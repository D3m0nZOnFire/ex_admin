
--  ___ __  _      ___  ___  __ __  _  _ _ 
-- | __>\ \/      | . || . \|  \  \| || \ |
-- | _>  \ \  ___ |   || | ||     || ||   |
-- |___>_/\_\|___||_|_||___/|_|_|_||_||_\_|
                                         

-------- EXEMPLE ------------------------------
-- ↓ LA LOGS (pas toucher!!)↓      ↓WEEBOK↓
--        Staffmodeon    =      "CHANGER",
------------------------------------------------

--------- LOGS ---------
Config = {
    webhook = {
        Staffmodeon = "TON WEBHOOK ICI",      -- MODE STAFF ON
        Staffmodeoff = "TON WEBHOOK ICI",     -- MODE STAFF OFF
        Jail = "TON WEBHOOK ICI",
        UnJail = "TON WEBHOOK ICI",
        teleport = "TON WEBHOOK ICI",
        teleportTo = "TON WEBHOOK ICI",
        revive = "TON WEBHOOK ICI",
        teleportcoords = "TON WEBHOOK ICI",
        teleporttoit = "TON WEBHOOK ICI",
        message = "TON WEBHOOK ICI",
        annonce = "TON WEBHOOK ICI",
        SavellPlayerAuto = "TON WEBHOOK ICI",-- SAVE TOUT LES JOUEURS
        clearInv = "TON WEBHOOK ICI",        -- CLEAR INVENTAIRE
        clearLoadout = "TON WEBHOOK ICI",    -- CLEAR ARME
        WipePlayer = "TON WEBHOOK ICI",
        kick = "TON WEBHOOK ICI",
        SendLogs = "TON WEBHOOK ICI",        -- GENERAL LOGS
        report = "TON WEBHOOK ICI"
    },
    Arme = {
        {hash = "WEAPON_REVOLVER"},
        {hash = "WEAPON_PISTOL"},
        {hash = "WEAPON_PISTOL_MK2"},
        {hash = "WEAPON_COMBATPISTOL"},
        {hash = "WEAPON_APPISTOL"},
        {hash = "WEAPON_PISTOL50"},
        {hash = "WEAPON_SNSPISTOL"},
        {hash = "WEAPON_HEAVYPISTOL"},
        {hash = "WEAPON_VINTAGEPISTOL"},
        {hash = "WEAPON_STUNGUN"},
        {hash = "WEAPON_FLAREGUN"},
        {hash = "WEAPON_MARKSMANPISTOL"},
        {hash = "WEAPON_MICROSMG"},
        {hash = "WEAPON_MINISMG"},
        {hash = "WEAPON_SMG"},
        {hash = "WEAPON_SMG_MK2"},
        {hash = "WEAPON_ASSAULTSMG"},
        {hash = "WEAPON_MG"},
        {hash = "WEAPON_COMBATMG"},
        {hash = "WEAPON_COMBATMG_MK2"},
        {hash = "WEAPON_COMBATPDW"},
        {hash = "WEAPON_GUSENBERG"},
        {hash = "WEAPON_MACHINEPISTOL"},
        {hash = "WEAPON_ASSAULTRIFLE"}, 
        {hash = "WEAPON_ASSAULTRIFLE_MK2"},
        {hash = "WEAPON_CARBINERIFLE"},
        {hash = "WEAPON_CARBINERIFLE_MK2"},
        {hash = "WEAPON_ADVANCEDRIFLE"},
        {hash = "WEAPON_SPECIALCARBINE"},
        {hash = "WEAPON_BULLPUPRIFLE"}, 
        {hash = "WEAPON_COMPACTRIFLE"},
        {hash = "WEAPON_PUMPSHOTGUN"},
        {hash = "WEAPON_SWEEPERSHOTGUN"},
        {hash = "WEAPON_SAWNOFFSHOTGUN"},
        {hash = "WEAPON_BULLPUPSHOTGUN"},
        {hash = "WEAPON_ASSAULTSHOTGUN"}, 
        {hash = "WEAPON_MUSKET"},
        {hash = "WEAPON_HEAVYSHOTGUN"},
        {hash = "WEAPON_DBSHOTGUN"},
        {hash = "WEAPON_SNIPERRIFLE"},
        {hash = "WEAPON_HEAVYSNIPER"},
        {hash = "WEAPON_HEAVYSNIPER_MK2"},
        {hash = "WEAPON_MARKSMANRIFLE"}, 
        {hash = "WEAPON_GRENADELAUNCHER"},
        {hash = "WEAPON_GRENADELAUNCHER_SMOKE"},
        {hash = "WEAPON_RPG"},
        {hash = "WEAPON_MINIGUN"},
        {hash = "WEAPON_FIREWORK"},
        {hash = "WEAPON_RAILGUN"},
        {hash = "WEAPON_HOMINGLAUNCHER"}, 
        {hash = "WEAPON_GRENADE"},
        {hash = "WEAPON_STICKYBOMB"},
        {hash = "WEAPON_COMPACTLAUNCHER"},
        {hash = "WEAPON_SNSPISTOL_MK2"},
        {hash = "WEAPON_REVOLVER_MK2"},
        {hash = "WEAPON_DOUBLEACTION"}, 
        {hash = "WEAPON_SPECIALCARBINE_MK2"},
        {hash = "WEAPON_BULLPUPRIFLE_MK2"},
        {hash = "WEAPON_PUMPSHOTGUN_MK2"},
        {hash = "WEAPON_MARKSMANRIFLE_MK2"},
        {hash = "WEAPON_RAYPISTOL"},
        {hash = "WEAPON_RAYCARBINE"}, 
        {hash = "WEAPON_RAYMINIGUN"},
        {hash = "WEAPON_NAVYREVOLVER"},
        {hash = "WEAPON_CERAMICPISTOL"},
        {hash = "WEAPON_PIPEBOMB"},
        {hash = "WEAPON_GADGETPISTOL"},
        {hash = "WEAPON_MILITARYRIFLE"},
        {hash = "WEAPON_COMBATSHOTGUN"},
        {hash = "WEAPON_AUTOSHOTGUN"}
    };
}

------- JAIL ------
Config.JailBlip     = {x = 256.83, y = -784.37, z = 30.45}  -- coordonnées de la UNJAIL
Config.JailLocation = {x = 1641.64, y = 2571.08, z = 45.50} -- coordonnées de la JAIL 
