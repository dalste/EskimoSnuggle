local storyboard = require "storyboard"
local scene = storyboard.newScene()

local tutorialMainText
local mainTextTransition
local onTap

function scene:createScene( event )
	local group = self.view

	tutorialMainText = display.newRetinaText( "Carry the device and move your bodies to play.", 0, 0, "Cubano", 18 )
	tutorialMainText:setTextColor( 65, 132, 187 )
	group:insert( tutorialMainText )
end

function scene:enterScene( event )
	tutorialMainText.x = display.contentWidth / 2
	tutorialMainText.y = 0 - tutorialMainText.contentHeight
	tutorialMainText.alpha = 1

	Runtime:addEventListener( "tap", onTap )

	mainTextTransition = transition.to( tutorialMainText, { y = display.contentHeight / 3, time = 1000, transition = easing.inOutExpo })
end

function scene:exitScene( event )
	if mainTextTransition ~= nil then transition.cancel( mainTextTransition ) end

	Runtime:removeEventListener( "tap", onTap )
end

function scene:destroyScene( event )

end

onTap = function( event )
	audio.play( storyboard.tapSFX )

	mainTextTransition = transition.to( tutorialMainText, { alpha = 0, time = 500, 
							onComplete = function() storyboard.gotoScene( "scenes.tutorial03" ) end })
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene