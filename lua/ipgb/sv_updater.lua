--[[
Filename: sv_updater.lua
Purpose: Checks for available script updates
Note: You aren't supposed to change anything in here unless you know what to do!
]]--

IPGB.Core = IPGB.Core or {}
IPGB.Util = IPGB.Util or {}

IPGB.Core.CurrentVersion = "1.0.0"

function IPGB.Util.UpdateCheck(ply)
	http.Fetch( "https://raw.githubusercontent.com/MomoxStudios/IPGBlite/master/version.txt" , function(body, len, headers, code)	

				print(type(body),body," | ",type(IPGB.Core.CurrentVersion),IPGB.Core.CurrentVersion)

				if body != IPGB.Core.CurrentVersion then
					MsgC( Color( 255, 0, 0 ), "[IPGB] WARNING: You are using an outdated version. Please update from version [" .. IPGB.Core.CurrentVersion .. "] to version [" .. body .. "].\n")
					IPGB.Core.IsOutdated = true
				else
					MsgC( Color( 20, 255, 20 ), "[IPGB] Version Up-To-Date: version: " .. body .. "\n")
				end			
		end,
		function( error )
			MsgC( Color( 255, 0, 0 ), "[IPGB] FATAL ERROR: Connection to GitHub failed.\n")
		end
	)
	return true
end
