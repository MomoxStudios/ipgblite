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

function IPGB.Core.CheckIP( steamID64, ipAddress, svPassword, clPassword, name )

	local clientIp = string.Explode(":", ipAddress)[1] --Client IP

	http.Fetch( IPGB.Util.FormatRestURL(IPGB.Config["IPServer"], clientIp) ,
		function( body, len, headers, code )
			local content = util.JSONToTable(body)
			
			if content != nil then
				local cc = content.countryCode or "ZZ"
				
				if !table.HasValue( IPGB.Whitelist["_steamID"], util.SteamIDFrom64( steamID64 ) ) then --badip check
					if cc == "ZZ" and IPGB.Config["KickBadIP"] == true then
						game.KickID(util.SteamIDFrom64( steamID64 ), IPGB.Util.FormatKickMessage(IPGB.Config["MSG_InvalidIP"], name, cc, ipAddress, steamID64) )
					end

					local kickPlayer = false

					if IPGB.Config["ReverseWhitelist"] then kickPlayer = table.HasValue( IPGB.Whitelist["_countryCode"], cc ) end
					if not IPGB.Config["ReverseWhitelist"] then kickPlayer = !table.HasValue( IPGB.Whitelist["_countryCode"], cc ) end


					if kickPlayer then
						game.KickID(util.SteamIDFrom64( steamID64 ), IPGB.Util.FormatKickMessage(IPGB.Config["MSG_InvalidCC"], name, cc, ipAddress, steamID64) )				
					end
				end
			else
				MsgC( Color( 255, 0, 0 ), "[IPGB] FATAL ERROR: Server: ("..IPGB.Config["IPServer"]..") sent invalid data. Source: " .. IPGB.Util.FormatRestURL(IPGB.Config["IPServer"], clientIp))
			end
		end,
		function( error )
			MsgC( Color( 255, 0, 0 ), "[IPGB] FATAL ERROR: Connection to IP-Api ("..IPGB.Config["IPServer"]..") failed")
		end)
end

timer.Create( "IPGB.Util.UpdateCheck", 21600, 0, IPGB.Util.UpdateCheck ) --update Check

local function IPGB_Advert()
	PrintMessage( HUD_PRINTTALK, "This Server is using IPGB Geo Blocker" )
	PrintMessage( HUD_PRINTTALK, "Get it from: https://github.com/MomoxStudios/IPGBlite/" )
end
timer.Create( "IPGB.Advert", 7200, 0, IPGB_Advert ) --Oho you found it, congrats.


hook.Add( "CheckPassword", "ipgb_getip", IPGB.Core.CheckIP )
hook.Add( "PostGamemodeLoaded", "ipgb_checkUpdate", IPGB.Util.UpdateCheck )