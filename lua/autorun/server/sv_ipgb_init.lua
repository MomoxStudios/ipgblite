--[[
Filename: sv_ipgb_init.lua
Purpose: Core Files. Connects every module and performs IP Checks
Note: You aren't supposed to change anything in here unless you know what to do!
]]--
IPGB = IPGB or {}
IPGB.Core = IPGB.Core or {}
IPGB.Util = IPGB.Util or {}
IPGB.Config = IPGB.Config or {}
IPGB.Whitelist = IPGB.Whitelist or {}

include( "ipgb/sv_config.lua" )
include( "ipgb/sv_messagehandler.lua" )
include( "ipgb/sv_updater.lua" )
if file.Exists( "ipgb/sv_logger.lua", "LUA" ) then include( "ipgb/sv_logger.lua" ) else print("[IPGB] Logger Module is not installed. Available on Workshop") end

IPGB.LogInstalled = IPGB.LogInstalled or false
print("Debug: "..tostring(IPGB.LogInstalled))

function IPGB.Core.CheckIP( steamID64, ipAddress, svPassword, clPassword, name )

	local clientIp = string.Explode(":", ipAddress)[1] --Client IP
	print("DEBUG DEBUG DEBUG: "..clientIp)

	http.Fetch( "http://ip-api.com/json/"..clientIp ,
		function( body, len, headers, code )
			local content = util.JSONToTable(body)
			
			if content != nil then
				local cc = content.countryCode or "ZZ"
				
				if !table.HasValue( IPGB.Whitelist["_steamID"], util.SteamIDFrom64( steamID64 ) )  && !table.HasValue(IPGB.Whitelist["_ip"], clientIp) then --badip check
					if cc == "ZZ" and IPGB.Config["KickBadIP"] == true then
						if(IPGB.LogInstalled) then IPGB.Util.LogPlayerKickedIP(name, steamID64, clientIp) end
						game.KickID(util.SteamIDFrom64( steamID64 ), IPGB.Util.FormatKickMessage(IPGB.Config["MSG_InvalidIP"], name, cc, ipAddress, steamID64) )
					end

					local kickPlayer = false

					print(cc)

					if IPGB.Config["ReverseWhitelist"] then kickPlayer = table.HasValue( IPGB.Whitelist["_countryCode"], cc ) end
					if not IPGB.Config["ReverseWhitelist"] then kickPlayer = !table.HasValue( IPGB.Whitelist["_countryCode"], cc ) end


					if kickPlayer then
						if(IPGB.LogInstalled) then IPGB.Util.LogPlayerKickedCC(name, steamID64, cc) end
						game.KickID(util.SteamIDFrom64( steamID64 ), IPGB.Util.FormatKickMessage(IPGB.Config["MSG_InvalidCC"], name, cc, ipAddress, steamID64) )				
					end
				end
			else
				MsgC( Color( 255, 0, 0 ), "[IPGB] FATAL ERROR: IP-Api sent invalid data. Source: " .. string.Replace("http://ip-api.com/json/$IP", "$IP", clientIp).."\n")
				if(IPGB.LogInstalled) then IPGB.Util.LogError("FATAL ERROR: IP-Api sent invalid data. Contact Developer! Source: " .. string.Replace("http://ip-api.com/json/$IP", "$IP", clientIp)) end 
			end
		end,
		function( error )
			if error == "invalid url" && IPGB.Config["KickBadIP"] == true && !table.HasValue(IPGB.Whitelist["_ip"], clientIp) then 
				if(IPGB.LogInstalled) then IPGB.Util.LogPlayerKickedIP(name, steamID64, clientIp) end
				game.KickID(util.SteamIDFrom64( steamID64 ), IPGB.Util.FormatKickMessage(IPGB.Config["MSG_InvalidIP"], name, cc, ipAddress, steamID64) ) 
				MsgC( Color( 255, 0, 0 ), "[IPGB] Invalid IP Blocked: Player: "..name.." (" ..clientIp..")\n")	
				
					
			elseif 	IPGB.Config["KickBadIP"] == false then 
					MsgC( Color( 255, 0, 0 ), "[IPGB] ERROR: Player '"..name.."' joined with an invalid ip and can't be checked. Refer to config for a solution.\n")	
					if(IPGB.LogInstalled) then IPGB.Util.LogError("ERROR: Player '"..name.."' joined with an invalid ip and can't be checked. Refer to config for a solution.") end 
			else
				MsgC( Color( 255, 0, 0 ), "[IPGB] FATAL ERROR: Connection to IP-Api failed: "..error..". Check if there are any local (bad) IPs in the IP Whitelist!\n")	
				if(IPGB.LogInstalled) then IPGB.Util.LogError("FATAL ERROR: Connection to IP-Api failed: "..error..". Check if there are any local (bad) IPs in the IP Whitelist!") end 
			end
			
		end)
end

timer.Create( "IPGB.Util.UpdateCheck", 21600, 0, IPGB.Util.UpdateCheck ) --update Check


hook.Add( "CheckPassword", "ipgb_getip", IPGB.Core.CheckIP )
hook.Add( "PostGamemodeLoaded", "ipgb_checkUpdate", IPGB.Util.UpdateCheck )