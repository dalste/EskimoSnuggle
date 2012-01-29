local storyboard = require "storyboard"
local scene = storyboard.newScene()

local gameOverText, scoreText
local onGameOver

function scene:createScene( event )
	local group = self.view

	gameOverText = display.newRetinaText( "Game Over", 0, 0, "Cubano", 48 )
	gameOverText:setTextColor( 65, 132, 187 )
	group:insert( gameOverText )

	scoreText = display.newRetinaText( "You Made It To Round "..storyboard.currentRound, 0, 0, "Cubano", 24 )
	scoreText:setTextColor( 65, 132, 187 )
	group:insert( scoreText )
end

function scene:enterScene( event )
	gameOverText.x = display.contentWidth / 2
	gameOverText.y = 0 - gameOverText.contentHeight
	gameOverText.alpha = 1

	scoreText.x = display.contentWidth / 2
	scoreText.y = 0 - scoreText.contentHeight
	scoreText.alpha = 1

	audio.play( storyboard.loseSFX )

	transition.to( gameOverText, { y = display.contentHeight / 8, time = 1000, transition = easing.inOutExpo })
	transition.to( scoreText, { y = display.contentHeight / 4, time = 1000, delay = 200, transition = easing.inOutExpo, onComplete = onGameOver })
end

function scene:exitScene( event )
end

function scene:destroyScene( event )

end

onGameOver = function()
	transition.to( gameOverText, { alpha = 0, time = 500, delay = 3000 })
	transition.to( scoreText, { alpha = 0, time = 500, delay = 3200, onComplete = function() storyboard.gotoScene( "scenes.title" ) end })
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene