local sprite = require "sprite"
local storyboard = require "storyboard"
local scene = storyboard.newScene()

local roundNumberText
local displayChallenge

function scene:createScene( event )
	local group = self.view

	roundNumberText = display.newRetinaText( "Round "..storyboard.currentRound, 25, 25, native.systemFont, 16 )
	roundNumberText:setTextColor( 255, 255, 255 )
	group:insert( roundNumberText )
end

function scene:enterScene( event )
	timer.performWithDelay( 1000, displayChallenge )
end

function scene:exitScene( event )

end

function scene:destroyScene( event )

end

displayChallenge = function()
	transition.to( roundNumberText, { x = 0 - roundNumberText.contentWidth, time = 1000 })
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene