//Configuration Options:

//Do you want the message to also appear in the players chat box?
//	true / false
local PRINT_IN_CHAT = true

//What message to do you want to display to the connecting user?
//  Change [server_name] to your servers name, or re-arrange the string to suit your needs! If you need help, just let me know!
//  $playername = players garry's mod nickname / display name
//  $playersteamid = players steam ID
local TITLE_TEXT = "Staff Announcement"

//Do you want the semi-transparent background to show up under the announcement?
//  1 = true, 0 = false
local BACKGROUND_ENABLED = 0
//What command you want to use to start an announcement?
//No spaces...
local ANNOUNCEMENT_COMMAND = "!announce"

//DO NOT TOUCH ANYTHING PAST THIS LINE//

resource.AddFile( "resource/fonts/ColabReg.ttf" )

print( "Player Login Message has started." )
util.AddNetworkString( "announcementSent" )

//Toggle debug on/off (prints messages to console)
hook.Add( "PlayerSay", "announcementSent", function( ply, text )
    if ply:GetUserGroup() == "superadmin" then
        local command = string.Explode( " ", text )
        if string.lower(command[1]) == ANNOUNCEMENT_COMMAND then
            print("Command worked")
            local playerNick = ply:Nick()
            local playerSteamID = ply:SteamID()
            local timeInSeconds = tonumber(command[2])
            local announcementMessage = string.gsub( text, ANNOUNCEMENT_COMMAND .. " " .. command[2] .. " ","")
            print(announcementMessage)
            print( playerNick .. " : " .. announcementMessage )
            net.Start( "announcementSent" )
                net.WriteString( playerNick )
                net.WriteString( announcementMessage )
                net.WriteInt( BACKGROUND_ENABLED, 8 )
                net.WriteInt( timeInSeconds, 8 )
            net.Broadcast()
            if PRINT_IN_CHAT == true then
                for k, v in pairs( player.GetAll() ) do
                    v:ChatPrint( playerNick .. " : " .. announcementMessage )
                end
            end
		end
	end
end )
