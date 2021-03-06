require "ice"
local limbBox = ice:loadBox( "limbs" )

local storyboard = require "storyboard"
local scene = storyboard.newScene()

local frostbittenText, limbText, limbTextTransition
local dismemberPlayers, processPlayer, playerProcessed, onNextRound, onGameOver, onTap
local playersToDismember, playerIndex

function scene:createScene( event )
	local group = self.view

	frostbittenText = display.newRetinaText( "Frostbitten!", 0, 0, "Cubano", 48 )
	frostbittenText:setTextColor( 65, 132, 187 )
	group:insert( frostbittenText )

	limbText = display.newRetinaText( "", 0, 0, "Cubano", 24 )
	limbText:setTextColor( 106, 48, 92 )
	group:insert( limbText )
end

function scene:enterScene( event )
	limbBox:store( ""..storyboard.currentRound, 1 )
	limbBox:save()

	frostbittenText.x = display.contentWidth / 2
	frostbittenText.y = 0 - frostbittenText.contentHeight
	frostbittenText.alpha = 1

	limbText.x = display.contentWidth / 2
	limbText.y = display.contentHeight / 4
	limbText.alpha = 0

	playersToDismember = {}
	playerIndex = 1

	transition.to( frostbittenText, { y = display.contentHeight / 8, time = 1000, transition = easing.inOutExpo, onComplete = dismemberPlayers })
end

function scene:exitScene( event )
	playersToDismember = nil
	if limbTextTransition ~= nil then transition.cancel( limbTextTransition ) end
	Runtime:removeEventListener( "tap", onTap )
end

function scene:destroyScene( event )

end

dismemberPlayers = function()
	local definitelyAlive = {}

	for i = 1, #storyboard.players do
		local coinFlip = math.random( 1, 2 )

		if coinFlip == 1 and storyboard.players[i].alive == true then
			table.insert( playersToDismember, i )
		elseif storyboard.players[i].alive == true then
			table.insert( definitelyAlive, i )
		end
	end

	if #playersToDismember == 0 and #definitelyAlive > 0 then
		local index = math.random( 1, #definitelyAlive )
		table.insert( playersToDismember, definitelyAlive[index] )
	end

	definitelyAlive = nil
	readyToProcessPlayer = true

	Runtime:addEventListener( "tap", onTap )
end

onTap = function( event )
	audio.play( storyboard.tapSFX )

	if playerIndex > #playersToDismember then
		local numberOfDeadPlayers = 0

		for i = 1, #storyboard.players do
			if storyboard.players[i].alive == false then
				numberOfDeadPlayers = numberOfDeadPlayers + 1
			end
		end

		if numberOfDeadPlayers >= #storyboard.players then
			onGameOver()
		else
			onNextRound()
		end
	else
		processPlayer()
	end
end

processPlayer = function()
	if limbTextTransition ~= nil then transition.cancel( limbTextTransition ) end
	limbText.alpha = 0

	local limb = storyboard.players[ playersToDismember[ playerIndex ] ]:removeLimb()
	limbText.text = "Eskimo "..( playersToDismember[ playerIndex ] ).." Lost "..limb
	limbTextTransition = transition.to( limbText, { alpha = 1, time = 500, delay = 500, onComplete = 
							function( obj ) transition.to( obj, { alpha = 0, time = 500, delay = 3000 }) end })
	playerIndex = playerIndex + 1
end

onNextRound = function()
	Runtime:removeEventListener( "tap", onTap )
	transition.to( frostbittenText, { alpha = 0, time = 500, onComplete = function() storyboard.gotoScene( "scenes.round" ) end })
end

onGameOver = function()
	Runtime:removeEventListener( "tap", onTap )
	transition.to( frostbittenText, { alpha = 0, time = 500, onComplete = function() storyboard.gotoScene( "scenes.gameover" ) end })
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene