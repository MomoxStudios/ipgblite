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

function IPGB.Util.FormatIPServer(url, ip)
	if url == "ip-api.com" then return string.format("http://ip-api.com/json/%s", ip) end
	if url == "momoxstudios.net" then return string.format("https://momoxstudios.net/IPGB/index.php/rest/geoip/resolve/%s", ip) end
	return url
end

