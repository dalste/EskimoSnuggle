local storyboard = require "storyboard"
local scene = storyboard.newScene()

local tutorialMainText, tutorialSubText
local mainTextTransition, subTextTransition
local onTap

function scene:createScene( event )
	local group = self.view

	tutorialMainText = display.newRetinaText( "Perform the challenges to survive.", 0, 0, "Cubano", 18 )
	tutorialMainText:setTextColor( 65, 132, 187 )
	group:insert( tutorialMainText )

	tutorialSubText = display.newRetinaText( "But keep in mind", 0, 0, "Cubano", 42 )
	tutorialSubText:setTextColor( 65, 132, 187 )
	group:insert( tutorialSubText )
end

function scene:enterScene( event )
	tutorialMainText.x = display.contentWidth / 2
	tutorialMainText.y = 0 - tutorialMainText.contentHeight
	tutorialMainText.alpha = 1

	tutorialSubText.x = display.contentWidth / 2
	tutorialSubText.y = 0 - tutorialSubText.contentHeight
	tutorialSubText.alpha = 1

	Runtime:addEventListener( "tap", onTap )

	mainTextTransition = transition.to( tutorialMainText, { y = display.contentHeight / 5, time = 1000, transition = easing.inOutExpo })
	subTextTransition = transition.to( tutorialSubText, { y = display.contentHeight / 3, time = 1000, delay = 200, transition = easing.inOutExpo })
end

function scene:exitScene( event )
	if mainTextTransition ~= nil then transition.cancel( mainTextTransition ) end
	if subTextTransition ~= nil then transition.cancel( subTextTransition ) end

	Runtime:removeEventListener( "tap", onTap )
end

function scene:destroyScene( event )

end

onTap = function( event )
	audio.play( storyboard.tapSFX )

	transition.to( tutorialMainText, { alpha = 0, time = 500 })
	transition.to( tutorialSubText, { alpha = 0, time = 500, delay = 200, onComplete = function() storyboard.gotoScene( "scenes.tutorial05" ) end })
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene