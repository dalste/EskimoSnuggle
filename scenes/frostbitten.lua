local storyboard = require "storyboard"
local scene = storyboard.newScene()

local frostbittenText
local dismemberPlayers, onNextRound, onGameOver

function scene:createScene( event )
	local group = self.view

	frostbittenText = display.newRetinaText( "Frostbitten!", 0, 0, "Cubano", 48 )
	frostbittenText:setTextColor( 65, 132, 187 )
	group:insert( frostbittenText )
end

function scene:enterScene( event )
	frostbittenText.x = display.contentWidth / 2
	frostbittenText.y = 0 - frostbittenText.contentHeight
	frostbittenText.alpha = 1

	transition.to( frostbittenText, { y = display.contentHeight / 8, time = 1000, transition = easing.inOutExpo, onComplete = dismemberPlayers })
end

function scene:exitScene( event )
end

function scene:destroyScene( event )

end

dismemberPlayers = function()
	local numberOfDeadPlayers = 0
	local definitelyAlive = {}
	local dismemberedSomebody = false

	for i = 1, #storyboard.players do
		local coinFlip = math.random( 1, 2 )
		
		if coinFlip == 1 and storyboard.players[i].alive == true then
			print( "PLAYER "..i.." LOST A LIMB")
			storyboard.players[i]:removeLimb( 1 )
			dismemberedSomebody = true
			-- SAVE LIMB LOCATION AT CURRENT ROUND NUMBER
		elseif storyboard.players[i].alive == true then
			table.insert( definitelyAlive, i )
		end

		if storyboard.players[i].alive == false then
			numberOfDeadPlayers = numberOfDeadPlayers + 1
		end
	end

	if not dismemberedSomebody and #definitelyAlive > 0 then
		local index = math.random( 1, #definitelyAlive )
		storyboard.players[index]:removeLimb( 1 )
		print( "RETROACTIVELY DISMEMBERING PLAYER "..index )

		if storyboard.players[index].alive == false then
			numberOfDeadPlayers = numberOfDeadPlayers + 1
		end
	end

	dismemberedSomebody = nil

	if numberOfDeadPlayers >= #storyboard.players then
		onGameOver()
	else
		onNextRound()
	end
end

onNextRound = function()
	transition.to( frostbittenText, { alpha = 0, time = 500, onComplete = function() storyboard.gotoScene( "scenes.round" ) end })
end

onGameOver = function()
	transition.to( frostbittenText, { alpha = 0, time = 500, onComplete = function() storyboard.gotoScene( "scenes.gameover" ) end })
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene