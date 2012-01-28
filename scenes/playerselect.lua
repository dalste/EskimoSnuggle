local sprite = require "sprite"
local utility = require "utility"
local storyboard = require "storyboard"
local scene = storyboard.newScene()

local onTouch, createPlayers
local playerNumbersSheet, playerNumber01, playerNumber02, playerNumber03, playerNumber04, playerNumber05

function scene:createScene( event )
	local group = self.view
	
	local playerSelectText = display.newRetinaText( "How many players?", 25, 25, native.systemFont, 16 )
	playerSelectText:setTextColor( 255, 255, 255 )

	group:insert( playerSelectText )

	playerNumbersSheet = sprite.newSpriteSheetFromData( "textures/playerNumbers".._G.filenameSuffix..".png", 
							require( "textures.playerNumbers".._G.filenameSuffix ).getSpriteSheetData() )
	
	local playerNumbers01Set = sprite.newSpriteSet( playerNumbersSheet, 1, 1 )
	local playerNumbers02Set = sprite.newSpriteSet( playerNumbersSheet, 2, 1 )
	local playerNumbers03Set = sprite.newSpriteSet( playerNumbersSheet, 3, 1 )
	local playerNumbers04Set = sprite.newSpriteSet( playerNumbersSheet, 4, 1 )
	local playerNumbers05Set = sprite.newSpriteSet( playerNumbersSheet, 5, 1 )

	playerNumber01 = sprite.newSprite( playerNumbers01Set )
	playerNumber01.xScale = _G.spriteScale
	playerNumber01.yScale = _G.spriteScale
	playerNumber01.x = ( display.contentWidth / 2 ) - ( 2 * playerNumber01.contentWidth ) - 20
	playerNumber01.y = display.contentHeight * ( 2 / 3 )
	playerNumber01.value = 1
	group:insert( playerNumber01 )

	playerNumber02 = sprite.newSprite( playerNumbers02Set )
	playerNumber02.xScale = _G.spriteScale
	playerNumber02.yScale = _G.spriteScale
	playerNumber02.x = ( display.contentWidth / 2 ) - playerNumber02.contentWidth - 10
	playerNumber02.y = display.contentHeight * ( 2 / 3 )
	playerNumber02.value = 2
	group:insert( playerNumber02 )

	playerNumber03 = sprite.newSprite( playerNumbers03Set )
	playerNumber03.xScale = _G.spriteScale
	playerNumber03.yScale = _G.spriteScale
	playerNumber03.x = display.contentWidth / 2
	playerNumber03.y = display.contentHeight * ( 2 / 3 )
	playerNumber03.value = 3
	group:insert( playerNumber03 )

	playerNumber04 = sprite.newSprite( playerNumbers04Set )
	playerNumber04.xScale = _G.spriteScale
	playerNumber04.yScale = _G.spriteScale
	playerNumber04.x = ( display.contentWidth / 2 ) + playerNumber04.contentWidth + 10
	playerNumber04.y = display.contentHeight * ( 2 / 3 )
	playerNumber04.value = 4
	group:insert( playerNumber04 )

	playerNumber05 = sprite.newSprite( playerNumbers05Set )
	playerNumber05.xScale = _G.spriteScale
	playerNumber05.yScale = _G.spriteScale
	playerNumber05.x = ( display.contentWidth / 2 ) + ( 2 * playerNumber04.contentWidth ) + 20
	playerNumber05.y = display.contentHeight * ( 2 / 3 )
	playerNumber05.value = 5
	group:insert( playerNumber05 )
end

function scene:enterScene( event )
	playerNumber01:addEventListener( "touch", onTouch )
	playerNumber02:addEventListener( "touch", onTouch )
	playerNumber03:addEventListener( "touch", onTouch )
	playerNumber04:addEventListener( "touch", onTouch )
	playerNumber05:addEventListener( "touch", onTouch )
end

function scene:exitScene( event )
	playerNumber01:removeEventListener( "touch", onTouch )
	playerNumber02:removeEventListener( "touch", onTouch )
	playerNumber03:removeEventListener( "touch", onTouch )
	playerNumber04:removeEventListener( "touch", onTouch )
	playerNumber05:removeEventListener( "touch", onTouch )
end

function scene:destroyScene( event )
	playerNumbersSheet:dispose()
end

onTouch = function( event )
	if event.phase == "began" then
        event.target.xScale = _G.spriteScale * 1.25
        event.target.yScale = _G.spriteScale * 1.25
        event.target.active = true
        display.getCurrentStage():setFocus( event.target )
    elseif event.phase == "moved" and event.target.active == true then
    	if utility.isPointInside( event.target, event.x, event.y ) then
    		event.target.xScale = _G.spriteScale * 1.25
        	event.target.yScale = _G.spriteScale * 1.25
    	else
			event.target.xScale = _G.spriteScale
        	event.target.yScale = _G.spriteScale
    	end
    elseif event.phase == "ended" or event.phase == "cancelled" then
        event.target.xScale = _G.spriteScale
        event.target.yScale = _G.spriteScale
        display.getCurrentStage():setFocus( nil )
        if utility.isPointInside( event.target, event.x, event.y ) then
        	createPlayers( event.target.value )
    	end
    end
end

createPlayers = function( numberOfPlayers )
	storyboard.players = {}

	for i = 1, numberOfPlayers do
		table.insert( storyboard.players, require( "player" ).new( i ))
	end

	storyboard.currentRound = 1

	storyboard.gotoScene( "scenes.round" )
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene