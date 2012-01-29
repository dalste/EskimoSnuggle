local storyboard = require "storyboard"
local scene = storyboard.newScene()

local tutorialMainText, tutorialMainText2, tutorialSubText
local mainTextTransition, mainTextTransition2, subTextTransition
local onTap

function scene:createScene( event )
	local group = self.view

	tutorialMainText = display.newRetinaText( "Party members must always maintain", 0, 0, "Cubano", 18 )
	tutorialMainText:setTextColor( 65, 132, 187 )
	group:insert( tutorialMainText )

	tutorialMainText2 = display.newRetinaText( "physical contact with each other.", 0, 0, "Cubano", 18 )
	tutorialMainText2:setTextColor( 65, 132, 187 )
	group:insert( tutorialMainText2 )

	tutorialSubText = display.newRetinaText( "Snuggle Up!", 0, 0, "Cubano", 42 )
	tutorialSubText:setTextColor( 65, 132, 187 )
	group:insert( tutorialSubText )
end

function scene:enterScene( event )
	tutorialMainText.x = display.contentWidth / 2
	tutorialMainText.y = 0 - tutorialMainText.contentHeight
	tutorialMainText.alpha = 1

	tutorialMainText2.x = display.contentWidth / 2
	tutorialMainText2.y = 0 - tutorialMainText2.contentHeight
	tutorialMainText2.alpha = 1

	tutorialSubText.x = display.contentWidth / 2
	tutorialSubText.y = 0 - tutorialSubText.contentHeight
	tutorialSubText.alpha = 1

	Runtime:addEventListener( "tap", onTap )

	mainTextTransition = transition.to( tutorialMainText, { y = display.contentHeight / 7, time = 1000, transition = easing.inOutExpo })
	mainTextTransition2 = transition.to( tutorialMainText2, { y = display.contentHeight / 5, time = 1000, transition = easing.inOutExpo })
	subTextTransition = transition.to( tutorialSubText, { y = display.contentHeight / 3, time = 1000, delay = 200, transition = easing.inOutExpo })
end

function scene:exitScene( event )
	if mainTextTransition ~= nil then transition.cancel( mainTextTransition ) end
	if mainTextTransition2 ~= nil then transition.cancel( mainTextTransition2 ) end
	if subTextTransition ~= nil then transition.cancel( subTextTransition ) end

	Runtime:removeEventListener( "tap", onTap )
end

function scene:destroyScene( event )

end

onTap = function( event )
	audio.play( storyboard.tapSFX )

	transition.to( tutorialMainText, { alpha = 0, time = 500 })
	transition.to( tutorialMainText2, { alpha = 0, time = 500 })
	transition.to( tutorialSubText, { alpha = 0, time = 500, delay = 200, onComplete = function() storyboard.gotoScene( "scenes.tutorial06" ) end })
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene