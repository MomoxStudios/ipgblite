--[[
Filename: sv_messagehandler.lua
Purpose: Formats Messages
Note: You aren't supposed to change anything in here unless you know what to do!
]]--

IPGB = IPGB or {}
IPGB.Util = IPGB.Util or {}

function IPGB.Util.FormatKickMessage(msg, name, cc, ip, sid) -- QuickFormats
	msg = string.Replace( msg, "$PLAYER_NAME", name )
	msg = string.Replace( msg, "$IP", string.Explode(":", ip)[1] )
	msg = string.Replace( msg, "$COUNTRY_CODE", cc or "ZZ" )
	msg = string.Replace( msg, "$CC", cc or "ZZ" )
	msg = string.Replace( msg, "$STEAMID", util.SteamIDFrom64(sid) )
	msg = string.Replace( msg, "$CONTACT", IPGB.Config["Contact"])
	return msg
end

function IPGB.Util.FormatRestURL(url, ip) 
	return string.Replace(IPGB.Util.FormatIPServer(url), "$IP", ip)
end

function IPGB.Util.FormatIPServer(url)
	if url == "donovanclan.de" then return "https://www.donovanclan.de/IPGB/index.php/rest/geoip/resolve/$IP" end
	if url == "ip-api.com" then return "http://ip-api.com/json/$IP" end
	if url == "momoxstudios.net" then return "https://momoxstudios.net/IPGB/index.php/rest/geoip/resolve/$IP" end
	return url
end