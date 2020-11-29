--[[
Filename: sv_logger.lua
Purpose: Creates and manages log files
Note: You aren't supposed to change anything in here unless you know what to do!
]]--

IPGB = IPGB or {}
IPGB.Core = IPGB.Core or {}
IPGB.Util = IPGB.Util or {}

IPGB.LogInstalled = true

IPGB.GlobalDate = os.date("%d") .. "_" .. os.date("%m") .. "_" .. os.date("%Y")

function IPGB.Core.InitLogs()
	if !file.Exists( "ipgb/logs", "DATA" ) then
		file.CreateDir( "ipgb/logs" )
	end
	if !file.Exists( string.format("ipgb/logs/log_%s.txt", IPGB.GlobalDate) , "DATA"  ) then
		file.Write( string.format("ipgb/logs/log_%s.txt", IPGB.GlobalDate), "IPGB Logs\n" ) 
	end
	return true
end
	
function IPGB.Util.LogPlayerKickedCC(name, steamid64, cc) --logs any players being kicked
	if (IPGB.Core.InitLogs()) then
		file.Append( string.format("ipgb/logs/log_%s.txt", IPGB.GlobalDate) , string.format("[%s] Player %s (%s) kicked, Country: %s\n", os.date( "%H:%M:%S" ), name, util.SteamIDFrom64(steamid64), cc) )
	end
end

function IPGB.Util.LogPlayerKickedIP(name, steamid64, ip) --logs any bad ip connections
	if (IPGB.Core.InitLogs()) then
		file.Append( string.format("ipgb/logs/log_%s.txt", IPGB.GlobalDate) , string.format("[%s] Player %s (%s) has been blocked due to an invalid IP. IP: %s\n", os.date( "%H:%M:%S" ), name, util.SteamIDFrom64(steamid64), ip) )
	end
end		


function IPGB.Util.LogError(msg) --logs any bad ip connections
	if (IPGB.Core.InitLogs()) then
		file.Append( string.format("ipgb/logs/log_%s.txt", IPGB.GlobalDate) , string.format("[%s] %s\n", os.date( "%H:%M:%S" ), msg) )
	end
end		
