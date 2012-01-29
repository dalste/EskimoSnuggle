local sprite = require "sprite"
local storyboard = require "storyboard"
local scene = storyboard.newScene()

local frostbittenText

function scene:createScene( event )
	local group = self.view

	frostbittenText = display.newRetinaText( "Frostbitten!", 0, 0, "Cubano", 48 )
	frostbittenText:setTextColor( 65, 132, 187 )
	group:insert( frostbittenText )
end

function scene:enterScene( event )
	frostbittenText.x = display.contentWidth / 2
	frostbittenText.y = 0 - frostbittenText.contentHeight

	transition.to( frostbittenText, { y = display.contentHeight / 8, time = 1000, transition = easing.inOutExpo })

	local numberOfDeadPlayers = 0

	for i = 1, #storyboard.players do
		local coinFlip = math.random( 1, 2 )
		
		if coinFlip == 1 and storyboard.players[i].alive == true then
			print( "PLAYER "..i.." LOST A LIMB")
			storyboard.players[i]:removeLimb( 1 )
			-- SAVE LIMB LOCATION AT CURRENT ROUND NUMBER
		end

		if storyboard.players[i].alive == false then
			numberOfDeadPlayers = numberOfDeadPlayers + 1
		end
	end

	--[[
	if numberOfDeadPlayers >= #storyboard.players then
		print( "GAME OVER" )
		--storyboard.gotoScene( "scenes.title" )
	else
		]]
		storyboard.currentRound = storyboard.currentRound + 1
		timer.performWithDelay( 1000, function() storyboard.gotoScene( "scenes.title" ) end )
	--end
end

function scene:exitScene( event )
end

function scene:destroyScene( event )

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene