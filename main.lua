system.setIdleTimer( false )
display.setStatusBar( display.HiddenStatusBar )

-- Used for dynamic content scaling for spritesheets
if display.contentScaleX <= 0.6 then -- 0.6 since we uprez at 1.6 (config.lua)
	_G.filenameSuffix = "HD"
	_G.spriteScale = 0.5 -- 0.5 since our HD assets are double the resolution (not 1.6 the resolution)
else
	_G.filenameSuffix = ""
	_G.spriteScale = 1.0
end

local screen = 
{
	left = display.screenOriginX,
	top = display.screenOriginY,
	right = display.contentWidth - display.screenOriginX,
	bottom = display.contentHeight - display.screenOriginY
};

local function startGame()
	local storyboard = require "storyboard"
	storyboard.gotoScene( "scenes.title" )
end

local fill = display.newRect( screen.left, screen.top, screen.right - screen.left, screen.bottom - screen.top )
fill:setFillColor( 235, 250, 255 )

local sprite = require "sprite"

local environmentSheet = sprite.newSpriteSheetFromData( "textures/environment".._G.filenameSuffix..".png", 
							require( "textures.environment".._G.filenameSuffix ).getSpriteSheetData() )

local environmentSprite = sprite.newSprite( sprite.newSpriteSet( environmentSheet, 1, 1 ))
environmentSprite.xScale = _G.spriteScale
environmentSprite.yScale = _G.spriteScale
environmentSprite.x = display.contentWidth / 2
environmentSprite.y = display.contentHeight + environmentSprite.contentHeight

transition.to( environmentSprite, { y = ( display.contentHeight * ( 3 / 4 )), time = 1000, transition = easing.inOutExpo, onComplete = startGame })



--local ultimote = require "Ultimote"; ultimote.connect();

--[[
function onShake( event )
	print( event.yInstant ) --..", "..event.yGravity..", "..event.zGravity.." -- "..event.xInstant..", "..event.yInstant..", "..event.zInstant )
end

function onGyro( event )
	print( event.zRotation )
end
]]

--Runtime:addEventListener( "accelerometer", onShake )
--Runtime:addEventListener( "gyroscope", onGyro )