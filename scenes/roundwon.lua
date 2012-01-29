require "ice"
local limbBox = ice:loadBox( "limbs" )

local storyboard = require "storyboard"
local scene = storyboard.newScene()

local roundWonText, roundWonTransition
local onTap

function scene:createScene( event )
	local group = self.view

	roundWonText = display.newRetinaText( "Safe!", 0, 0, "Cubano", 48 )
	roundWonText:setTextColor( 65, 132, 187 )
	group:insert( roundWonText )
end

function scene:enterScene( event )
	roundWonText.x = display.contentWidth / 2
	roundWonText.y = 0 - roundWonText.contentHeight
	roundWonText.alpha = 1

	roundWonTransition = transition.to( roundWonText, { y = display.contentHeight / 8, time = 1000, transition = easing.inOutExpo, onComplete = onRoundWon })

	Runtime:addEventListener( "tap", onTap )
end

function scene:exitScene( event )
	if roundWonTransition ~= nil then transition.cancel( roundWonTransition ) end

	Runtime:removeEventListener( "tap", onTap )
end

function scene:destroyScene( event )

end

onTap = function( event )
	audio.play( storyboard.tapSFX )

	local needALimb = false

	for i = 1, #storyboard.players do
		if storyboard.players[ i ].numberOfLimbs < 4 then needALimb = true end
	end

	local frozenLimbs = limbBox:retrieve( ""..storyboard.currentRound )
	if needALimb == true and frozenLimbs ~= nil and frozenLimbs > 0 then
			transition.to( roundWonText, { alpha = 0, time = 500, onComplete = function() storyboard.gotoScene( "scenes.foundlimb" ) end })
	else
		transition.to( roundWonText, { alpha = 0, time = 500, onComplete = function() storyboard.gotoScene( "scenes.round" ) end })
	end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene