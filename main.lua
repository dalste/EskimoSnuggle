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


audio.reserveChannels( 1 )
local backgroundMusic = audio.loadSound( "audio/partyDog.mp3" )
local backgroundMusicChannel = audio.play( backgroundMusic, { channel = 1, loops = -1 }  )
audio.setVolume( 0.3, 1 )

local function startGame()
	local storyboard = require "storyboard"
	
	storyboard.tapSFX = audio.loadSound( "audio/tap.wav" )
	storyboard.warningSFX = audio.loadSound( "audio/warning.wav" )
	storyboard.winSFX = audio.loadSound( "audio/win.wav" )
	storyboard.loseSFX = audio.loadSound( "audio/lose.wav" )
	storyboard.weakenedSFX = audio.loadSound( "audio/weakened.wav" )
	storyboard.newRoundSFX = audio.loadSound( "audio/newRound.wav" )
	storyboard.countdownSFX = audio.loadSound( "audio/countdown.wav" )
	storyboard.goSFX = audio.loadSound( "audio/go.wav" )

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

--[[
local ultimote = require "Ultimote"; ultimote.connect();

local currentRotation, currentAcceleration = 0, 0
function onShake( event )
	currentAcceleration = math.abs( event.xInstant ) + math.abs( event.yInstant ) + math.abs( event.zInstant )
end

function onGyro( event )
	currentRotation = math.abs( event.xRotation * event.deltaTime ) + math.abs( event.yRotation * event.deltaTime ) + 
							math.abs( event.zRotation * event.deltaTime )
end

function update( event )
	print("A: "..currentAcceleration..", G: "..currentRotation)
end

Runtime:addEventListener( "accelerometer", onShake )
Runtime:addEventListener( "gyroscope", onGyro )
Runtime:addEventListener( "enterFrame", update )
--]]