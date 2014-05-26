net.Receive( "announcementSent", function()
    local playerNick = net.ReadString()
    local announcementMessageContent = net.ReadString()
    local backgroundEnabled = net.ReadInt( 8 )
    local timeInSeconds = net.ReadInt( 8 )
    print(announcementMessage)
    drawAnnouncement( playerNick, announcementMessageContent, backgroundEnabled, timeInSeconds, printInChat )
end)

surface.CreateFont( "playerNickFont", {
	font = "Colaborate-Regular",
	size = 40,
	weight = 500,
	antialias = true,
} )
surface.CreateFont( "announcementMessageFont", {
	font = "Colaborate-Regular",
	size = 20,
	weight = 500,
	antialias = true,
} )

function drawAnnouncement( playerNick, announcementMessageContent, backgroundEnabled, timeInSeconds, printInChat )
    local announcementBackgroundPanel = vgui.Create( "DPanel" )
    announcementBackgroundPanel:SetSize( ScrW(), 150 )
    announcementBackgroundPanel:SetPos( 0, -200 )
    local announcementBackgroundX, announcementBackgroundY = announcementBackgroundPanel:GetSize()
    announcementBackgroundPanel.Paint = function()
        if backgroundEnabled == 1 then
            surface.SetDrawColor( 0, 0, 0, 125 ) 
        else
            surface.SetDrawColor( 0, 0, 0, 0 )
        end
        surface.DrawRect( 0, 0, announcementBackgroundPanel:GetWide(), announcementBackgroundPanel:GetTall() )
    end
    announcementBackgroundPanel:MoveTo( 0, 0, 0.1, 0, 1 )

    local announcementNameLabel = vgui.Create( "DLabel", announcementBackgroundPanel)
    announcementNameLabel:SetFont( "playerNickFont" )
    announcementNameLabel:SetText( playerNick )
    announcementNameLabel:SizeToContents()
    announcementNameLabel:SetContentAlignment( 5 )
    local announcementNameX, announcementNameY = announcementNameLabel:GetSize()
    announcementNameLabel:SetPos( (ScrW()/2)-(announcementNameX/2), (0-50) )
    announcementNameLabel:SetTextColor( Color( 255, 255, 255, 255 ) )
    announcementNameLabel:MoveTo( (ScrW()/2)-(announcementNameX/2), 15, 0.1, 0.3, 1 )
    
    local announcementMessageLabel = vgui.Create( "DLabel", announcementBackgroundPanel)
    announcementMessageLabel:SetFont( "announcementMessageFont" )
    announcementMessageLabel:SetText( announcementMessageContent )
    announcementMessageLabel:SizeToContents()
    announcementMessageLabel:SetContentAlignment( 8 )
    local announcementMessageX, announcementMessageY = announcementMessageLabel:GetSize()
    announcementMessageLabel:SetPos( (ScrW()/2)-(announcementMessageX/2), (0-50) )
    announcementMessageLabel:SetTextColor( Color( 255, 255, 255, 255 ) )
    announcementMessageLabel:MoveTo( (ScrW()/2)-(announcementMessageX/2), 15+announcementNameY+15, 0.1, 0.3, 1 )

    timer.Create( "removeAnnouncement", timeInSeconds+0.3, 1, function()
        announcementNameLabel:MoveTo( (ScrW()/2)-(announcementNameX/2), (0-50), 0.1, 0, 1 )
        announcementMessageLabel:MoveTo( (ScrW()/2)-(announcementMessageX/2), (0-announcementMessageY), 0.1, 0, 1 )
        announcementBackgroundPanel:MoveTo( 0, -200, 0.1, 0.3, 1 )
        timer.Create( "deleteAnnouncement", (timeInSeconds+5.3), 1, function()
            announcementBackgroundPanel:Remove()
            announcementNameLabel:Remove()
            announcementMessageLabel:Remove()
        end)
    end)
    
    
    
end
