--[[
Filename: sv_config.lua
Purpose: Config obviously
]]--

IPGB = IPGB or {}
IPGB.Config = IPGB.Config or {}
IPGB.Whitelist = IPGB.Whitelist or {}

-- Do not touch anything above this line

--###################################################
--##################### Config ######################
--###################################################

-- IP-Server | Define the Server being used to trace IPS down ( GeoIP Service ) IPGB comes with 2 free/unlimited IP Servers.
IPGB.Config["IPServer"] = "momoxstudios.net" -- Valid options: "donovanclan.de" or "ip-api.com" or "momoxstudios.net" 

-- Kick Bad IPs | Kick IPs wich can't be traced down (Mostly local IP's)
IPGB.Config["KickBadIP"] = false -- Valid options: true / false

-- Reverse Whitelist | Reverse the Country Whitelist, so only Countries inside can't join the server
IPGB.Config["ReverseWhitelist"] = true -- Valid options: true / false

-- Kick Message CC | The kick message people get when being kicked for not being whitelisted (Use \n to make a new line)
-- Available Quick Codes: $PLAYER_NAME; $IP; $COUNTRY_CODE or $CC; $STEAMID; $CONTACT
IPGB.Config["MSG_InvalidCC"] = "[IPGB] You have been kicked!\nYour Country ($CC) is not allowed on this server\nIf you believe this is an error, contact:\n$CONTACT"

-- Kick Message IP | The kick message people get when being kicked for having an invalid IP (Use \n to make a new line)
-- Available Quick Codes: $PLAYER_NAME; $IP; $COUNTRY_CODE or $CC; $STEAMID; $CONTACT
IPGB.Config["MSG_InvalidIP"] = "[IPGB] You have been kicked!\nYour IP ($IP) is invalid!\nIf you believe this is an error, contact:\n$CONTACT"

-- Contact | Define the $CONTACT parameter for kick messages. Enter your Steam Profile, Website/Forum or whatever
IPGB.Config["Contact"] = "The Server Owner"

--###################################################
--#################### Whitelist ####################
--###################################################

-- Country Code Whitelist | Add countries which should be whitelisted in this table. A list can be found here (the Alpha 2 codes): http://www.nationsonline.org/oneworld/country_code_list.htm | ZZ means invalid
IPGB.Whitelist["_countryCode"] = {"DE", "FR", "GB", "IT"} -- Has to look like this;  No Country: {} | One Country: {"DE"} | Multiple Countries: {"DE","FR","IT"}        DONT FORGET THE "" 

-- SteamID Whitelist | Add SteamID's which should bypass all checks.
IPGB.Whitelist["_steamID"] = {"STEAM_0:1:76836829"} -- Has to look like this;  No SteamID: {} | One SteamID: {"STEAM_0:1:76836829"} | Multiple Countries: {"STEAM_0:1:76836829","STEAM_0:1:23456789"}        DONT FORGET THE "" 




