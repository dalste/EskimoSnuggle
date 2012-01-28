local sprite = require "sprite"
local storyboard = require "storyboard"
local scene = storyboard.newScene()

local uiSheet
local verbSprite, styleSprite, timerSprite

local roundNumberText, verbText, styleText, timerText
local displayChallenge

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

	styleSprite = sprite.newSprite( sprite.newSpriteSet( uiSheet, 2, 1 ) )
	styleSprite.xScale = _G.spriteScale
	styleSprite.yScale = _G.spriteScale
	styleSprite.x = ( display.contentWidth / 2 )
	styleSprite.y = 0 - styleSprite.contentHeight

	timerSprite = sprite.newSprite( sprite.newSpriteSet( uiSheet, 1, 1 ) )
	timerSprite.xScale = _G.spriteScale
	timerSprite.yScale = _G.spriteScale
	timerSprite.x = ( display.contentWidth * ( 3 / 4 ))
	timerSprite.y = 0 - timerSprite.contentHeight

	roundNumberText = display.newRetinaText( "Round "..storyboard.currentRound, 25, 25, native.systemFont, 16 )
	roundNumberText:setTextColor( 255, 255, 255 )
	group:insert( roundNumberText )

	verbText = display.newRetinaText( "", 0, 0, native.systemFont, 16 )
	verbText:setTextColor( 255, 255, 255 )
	group:insert( verbText )

	styleText = display.newRetinaText( "", 0, 0, native.systemFont, 16 )
	styleText:setTextColor( 255, 255, 255 )
	group:insert( styleText )

	timerText = display.newRetinaText( "", 0, 0, native.systemFont, 16 )
	timerText:setTextColor( 255, 255, 255 )
	group:insert( timerText )
end

function scene:enterScene( event )
	timer.performWithDelay( 1000, displayChallenge )
end

function scene:exitScene( event )

end

function scene:destroyScene( event )

end

displayChallenge = function()
	verbText.text = verbs[ math.random( 1, #verbs )]
	styleText.text = styles[ math.random( 1, #styles )]

	transition.to( roundNumberText, { x = 0 - roundNumberText.contentWidth, time = 1000, transition = easing.inOutExpo })
	transition.to( verbSprite, { y = display.contentHeight / 6, time = 1000, transition = easing.inOutExpo })
	transition.to( styleSprite, { y = display.contentHeight / 6, time = 1000, delay = 200, transition = easing.inOutExpo })
	transition.to( timerSprite, { y = display.contentHeight / 6, time = 1000, delay = 400,  transition = easing.inOutExpo })
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene