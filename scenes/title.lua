local storyboard = require "storyboard"
local scene = storyboard.newScene()

local onShake, wiggleUp, wiggleDown
local environmentSheet, titleSprite, shakeSprite

local exiting = false

function scene:createScene( event )
	local group = self.view
	
	environmentSheet = sprite.newSpriteSheetFromData( "textures/environment".._G.filenameSuffix..".png", 
							require( "textures.environment".._G.filenameSuffix ).getSpriteSheetData() )

	titleSprite = sprite.newSprite( sprite.newSpriteSet( environmentSheet, 9, 1 ))
	titleSprite.xScale = _G.spriteScale
	titleSprite.yScale = _G.spriteScale

	shakeSprite = sprite.newSprite( sprite.newSpriteSet( environmentSheet, 7, 1 ))
	shakeSprite.xScale = _G.spriteScale
	shakeSprite.yScale = _G.spriteScale
	

	group:insert( titleSprite )
	group:insert( shakeSprite )
end

function scene:enterScene( event )
	exiting = false

	titleSprite.x = display.contentWidth / 2
	titleSprite.y = 0 - titleSprite.contentHeight
	titleSprite.alpha = 1

	shakeSprite.x = display.contentWidth / 2
	shakeSprite.y = display.contentHeight / 2 - 25
	shakeSprite.alpha = 0

	titleTransition = transition.to( titleSprite, { y = ( display.contentHeight * ( 1 / 5 )), time = 1000, transition = easing.inOutExpo })
	transition.to( shakeSprite, { alpha = 1.0, time = 1000, delay = 1000 })
	wiggleUp( shakeSprite )


	Runtime:addEventListener( "accelerometer", onShake )
end

function scene:exitScene( event )
	exiting = true
	Runtime:removeEventListener( "accelerometer", onShake )
end

function scene:destroyScene( event )
	environmentSheet:dispose()
end

onShake = function( event )
	if event.isShake == true then
		audio.play( storyboard.winSFX )
		transition.to( titleSprite, { alpha = 0, time = 500, onComplete = function() storyboard.gotoScene( "scenes.tutorial01" ) end })
		transition.to( shakeSprite, { alpha = 0, time = 500 })
	end
end

wiggleUp = function( obj )
	if exiting then return end
	shakeTransition = transition.to( shakeSprite, { y = obj.y - 5, time = 250, onComplete = wiggleDown })
end

wiggleDown = function( obj )
	if exiting then return end
	shakeTransition = transition.to( shakeSprite, { y = obj.y + 5, time = 250, onComplete = wiggleUp })
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene