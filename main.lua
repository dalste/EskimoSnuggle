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

local fill = display.newRect( screen.left, screen.top, screen.right - screen.left, screen.bottom - screen.top )
fill:setFillColor( 181, 214, 223 )

local storyboard = require "storyboard"
storyboard.gotoScene( "scenes.playerselect" )