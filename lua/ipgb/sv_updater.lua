--[[
Filename: sv_updater.lua
Purpose: Checks for available script updates
Note: You aren't supposed to change anything in here unless you know what to do!
]]--

IPGB.Core = IPGB.Core or {}
IPGB.Util = IPGB.Util or {}

IPGB.Core.CurrentVersion = 110

function IPGB.Util.UpdateCheck()
	http.Fetch( "https://raw.githubusercontent.com/MomoxStudios/IPGBlite/master/version.txt" , function(body, len, headers, code)	
			if len < 6 then
				if IPGB.Core.CurrentVersion == tonumber(body) then
					MsgC( Color( 20, 255, 20 ), "[IPGB] Version Up-To-Date!\n")
				else
					MsgC( Color( 255, 0, 0 ), "[IPGB] WARNING: You are using an outdated version. Please update from version [" .. IPGB.Core.CurrentVersion .. "] to version [" .. tonumber(body) .. "].\n")
					if (IPGB.LogInstalled) then
		                IPGB.Util.LogError("WARNING: You are using an outdated version. Please update from version [" .. IPGB.Core.CurrentVersion .. "] to version [" .. tonumber(body) .. "].")
		            end
				end	
			else
				MsgC( Color( 255, 0, 0 ), "[IPGB] UPDATE ERROR: GitHub sent invalid data.\n")
			 if (IPGB.LogInstalled) then
                IPGB.Util.LogError("ERROR: Couldn't check for updates. GitHub sent invalid data" )
            end	
			end			
		end,
		function( error )
			MsgC( Color( 255, 0, 0 ), "[IPGB] UPDATE ERROR: Connection to GitHub failed.\n")
			 if (IPGB.LogInstalled) then
                IPGB.Util.LogError("ERROR: Couldn't check GitHub for a newer version: " .. error )
            end
		end
	)
	return true
end
