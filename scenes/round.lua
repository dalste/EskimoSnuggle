local sprite = require "sprite"
local storyboard = require "storyboard"
local scene = storyboard.newScene()

local uiSheet
local verbSprite, styleSprite, timerSprite

local roundNumberText, verbText, styleText, timerText
local prepareChallenge, startChallenge, updateChallenge

local verbs =
{
	"Cartwheel",
	"Crabwalk",
	"Crawl",
	"Gallop",
	"Hop",
	"Jump",
	"Leapfrog",
	"Push-up",
	"Roll",
	"Run",
	"Skip",
	"Spin",
	"Sprint",
	"Squat",
	"Wheelbarrow",
}

local styles =
{
	"Wildly",
	"Slowly",
	"Cautiously"
}

function scene:createScene( event )
	local group = self.view

	uiSheet = sprite.newSpriteSheetFromData( "textures/ui".._G.filenameSuffix..".png", 
							require( "textures.ui".._G.filenameSuffix ).getSpriteSheetData() )
	
	verbSprite = sprite.newSprite( sprite.newSpriteSet( uiSheet, 2, 1 ) )
	verbSprite.xScale = _G.spriteScale
	verbSprite.yScale = _G.spriteScale
	verbSprite.x = ( display.contentWidth / 4 )
	verbSprite.y = 0 - verbSprite.contentHeight
	group:insert( verbSprite )

	styleSprite = sprite.newSprite( sprite.newSpriteSet( uiSheet, 2, 1 ) )
	styleSprite.xScale = _G.spriteScale
	styleSprite.yScale = _G.spriteScale
	styleSprite.x = ( display.contentWidth / 2 )
	styleSprite.y = 0 - styleSprite.contentHeight
	group:insert( styleSprite )

	timerSprite = sprite.newSprite( sprite.newSpriteSet( uiSheet, 1, 1 ) )
	timerSprite.xScale = _G.spriteScale
	timerSprite.yScale = _G.spriteScale
	timerSprite.x = ( display.contentWidth * ( 3 / 4 ))
	timerSprite.y = 0 - timerSprite.contentHeight
	group:insert( timerSprite )

	roundNumberText = display.newRetinaText( "Round "..storyboard.currentRound, 25, 25, native.systemFont, 16 )
	roundNumberText:setTextColor( 255, 255, 255 )
	group:insert( roundNumberText )

	verbText = display.newRetinaText( "", 100, 0, native.systemFont, 16 )
	verbText:setTextColor( 25, 25, 25 )
	group:insert( verbText )

	styleText = display.newRetinaText( "", 0, 0, native.systemFont, 16 )
	styleText:setTextColor( 25, 25, 25 )
	group:insert( styleText )

	timerText = display.newRetinaText( "", 0, 0, native.systemFont, 16 )
	timerText:setTextColor( 25, 25, 25 )
	group:insert( timerText )
end

function scene:enterScene( event )
	timer.performWithDelay( 1000, prepareChallenge )
end

function scene:exitScene( event )

end

function scene:destroyScene( event )

end

prepareChallenge = function()
	verbText.text = verbs[ math.random( 1, #verbs )]
	verbText.x = verbSprite.x
	verbText.y = verbSprite.y

	styleText.text = styles[ math.random( 1, #styles )]
	styleText.x = styleSprite.x
	styleText.y = styleSprite.y

	timerText.text = "Get Ready..."
	timerText.x = timerSprite.x
	timerText.y = timerSprite.y

	transition.to( roundNumberText, { x = 0 - roundNumberText.contentWidth, time = 1000, transition = easing.inOutExpo })
	
	transition.to( verbSprite, { y = display.contentHeight / 6, time = 1000, transition = easing.inOutExpo })
	transition.to( verbText, { y = display.contentHeight / 6, time = 1000, transition = easing.inOutExpo })
	
	transition.to( styleSprite, { y = display.contentHeight / 6, time = 1000, delay = 200, transition = easing.inOutExpo })
	transition.to( styleText, { y = display.contentHeight / 6, time = 1000, delay = 200, transition = easing.inOutExpo })
	
	transition.to( timerSprite, { y = display.contentHeight / 6, time = 1000, delay = 400 ,  transition = easing.inOutExpo })
	transition.to( timerText, { y = display.contentHeight / 6, time = 1000, delay = 400 ,  transition = easing.inOutExpo })

	timer.performWithDelay( 5000, startChallenge )
end

startChallenge = function()
	timerText.text = "Go!"
	system.vibrate()
end

updateChallenge = function()
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene