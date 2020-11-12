--[[
Filename: sv_updater.lua
Purpose: Checks for available script updates
Note: You aren't supposed to change anything in here unless you know what to do!
]]--

IPGB.Core = IPGB.Core or {}
IPGB.Util = IPGB.Util or {}

IPGB.Core.CurrentVersion = "1.0.0"

function IPGB.Util.UpdateCheck()
	http.Fetch( "https://raw.githubusercontent.com/MomoxStudios/ipgblite/master/version.json" , function(body, len, headers, code)	
		local content = util.JSONToTable(body) or "ERROR"
			if content != "ERROR" then
				if IPGB.Core.CurrentVersion == content.version then
					MsgC( Color( 20, 255, 20 ), "[IPGB] Version Up-To-Date!\n")
				else
					MsgC( Color( 255, 0, 0 ), "[IPGB] WARNING: Update available! Version [" .. IPGB.Core.CurrentVersion .. "] -> [" .. content.version .. "]. Changes: " .. content.changes.. "\n")
					if (IPGB.LogInstalled) then
		                IPGB.Util.LogError("WARNING: Update available! Version [" .. IPGB.Core.CurrentVersion .. "] -> [" .. content.version .. "]. Changes: " .. content.changes)
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
