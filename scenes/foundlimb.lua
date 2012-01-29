require "ice"
local limbBox = ice:loadBox( "limbs" )

local storyboard = require "storyboard"
local scene = storyboard.newScene()

local foundLimbText, recipientText, recipientTextTransition, limbless
local findLimbless, restoreLimb, onTap
local limbReattached

function scene:createScene( event )
	local group = self.view

	foundLimbText = display.newRetinaText( "You Found A Frozen Limb!", 0, 0, "Cubano", 36 )
	foundLimbText:setTextColor( 65, 132, 187 )
	group:insert( foundLimbText )

	recipientText = display.newRetinaText( "", 0, 0, "Cubano", 24 )
	recipientText:setTextColor( 106, 48, 92 )
	group:insert( recipientText )
end

function scene:enterScene( event )
	limbBox:store( ""..storyboard.currentRound, 0 )
	limbBox:save()

	foundLimbText.x = display.contentWidth / 2
	foundLimbText.y = 0 - foundLimbText.contentHeight
	foundLimbText.alpha = 1

	recipientText.x = display.contentWidth / 2
	recipientText.y = display.contentHeight / 4
	recipientText.alpha = 0

	limblessPlayers = {}
	limbReattached = false

	transition.to( foundLimbText, { y = display.contentHeight / 8, time = 1000, transition = easing.inOutExpo, onComplete = findLimbless })
end

function scene:exitScene( event )
	limblessPlayers = nil
	if recipientTextTransition ~= nil then transition.cancel( recipientTextTransition ) end
	Runtime:removeEventListener( "tap", onTap )
end

function scene:destroyScene( event )

end

findLimbless = function()
	for i = 1, #storyboard.players do
		if storyboard.players[ i ].numberOfLimbs < 4 then
			table.insert( limblessPlayers, i )
		end
	end

	Runtime:addEventListener( "tap", onTap )
end

restoreLimb = function()
	recipientText.alpha = 0

	local playerIndex = math.random( 1, #limblessPlayers )
	local limb = storyboard.players[ limblessPlayers[ playerIndex ] ]:restoreLimb()
	recipientText.text = "Eskimo "..( limblessPlayers[ playerIndex ] ).." Reattached "..limb
	recipientTextTransition = transition.to( recipientText, { alpha = 1, time = 500, delay = 1000, onComplete = 
							function( obj ) transition.to( obj, { alpha = 0, time = 500, delay = 3000 }) end })
	limbReattached = true
end

onTap = function( event )
	audio.play( storyboard.tapSFX )

	if limbReattached == false then
		restoreLimb()
	else
		transition.to( foundLimbText, { alpha = 0, time = 500, onComplete = function() storyboard.gotoScene( "scenes.round" ) end })
	end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene