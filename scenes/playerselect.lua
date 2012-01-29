local sprite = require "sprite"
local utility = require "utility"
local storyboard = require "storyboard"
local scene = storyboard.newScene()

local onTouch, createPlayers
local environmentSheet, playerSelectText, playerNumber01, playerNumber02, playerNumber03, playerNumber04, playerNumber05

function scene:createScene( event )
	local group = self.view
	
	playerSelectText = display.newRetinaText( "How many people are in your party?", 0, 0, "Cubano", 18 )
	playerSelectText.x = display.contentWidth / 2
	playerSelectText.y = 0 - playerSelectText.contentHeight
	playerSelectText:setTextColor( 65, 132, 187 )
	group:insert( playerSelectText )

	environmentSheet = sprite.newSpriteSheetFromData( "textures/environment".._G.filenameSuffix..".png", 
							require( "textures.environment".._G.filenameSuffix ).getSpriteSheetData() )
	
	local playerNumbers01Set = sprite.newSpriteSet( environmentSheet, 2, 1 )
	local playerNumbers02Set = sprite.newSpriteSet( environmentSheet, 3, 1 )
	local playerNumbers03Set = sprite.newSpriteSet( environmentSheet, 4, 1 )
	local playerNumbers04Set = sprite.newSpriteSet( environmentSheet, 5, 1 )
	local playerNumbers05Set = sprite.newSpriteSet( environmentSheet, 6, 1 )

	playerNumber01 = sprite.newSprite( playerNumbers01Set )
	playerNumber01.xScale = _G.spriteScale
	playerNumber01.yScale = _G.spriteScale
	playerNumber01.x = ( display.contentWidth / 2 ) - ( 2 * playerNumber01.contentWidth ) - 20
	playerNumber01.y = 0 - playerNumber01.contentHeight
	playerNumber01.value = 1
	group:insert( playerNumber01 )

	playerNumber02 = sprite.newSprite( playerNumbers02Set )
	playerNumber02.xScale = _G.spriteScale
	playerNumber02.yScale = _G.spriteScale
	playerNumber02.x = ( display.contentWidth / 2 ) - playerNumber02.contentWidth - 10
	playerNumber02.y = 0 - playerNumber02.contentHeight
	playerNumber02.value = 2
	group:insert( playerNumber02 )

	playerNumber03 = sprite.newSprite( playerNumbers03Set )
	playerNumber03.xScale = _G.spriteScale
	playerNumber03.yScale = _G.spriteScale
	playerNumber03.x = display.contentWidth / 2
	playerNumber03.y = 0 - playerNumber03.contentHeight
	playerNumber03.value = 3
	group:insert( playerNumber03 )

	playerNumber04 = sprite.newSprite( playerNumbers04Set )
	playerNumber04.xScale = _G.spriteScale
	playerNumber04.yScale = _G.spriteScale
	playerNumber04.x = ( display.contentWidth / 2 ) + playerNumber04.contentWidth + 10
	playerNumber04.y = 0 - playerNumber04.contentHeight
	playerNumber04.value = 4
	group:insert( playerNumber04 )

	playerNumber05 = sprite.newSprite( playerNumbers05Set )
	playerNumber05.xScale = _G.spriteScale
	playerNumber05.yScale = _G.spriteScale
	playerNumber05.x = ( display.contentWidth / 2 ) + ( 2 * playerNumber04.contentWidth ) + 20
	playerNumber05.y = 0 - playerNumber05.contentHeight
	playerNumber05.value = 5
	group:insert( playerNumber05 )
end

function scene:enterScene( event )
	transition.to( playerSelectText, { y = ( display.contentHeight * ( 1 / 8 )), time = 1000, transition = easing.inOutExpo })

	transition.to( playerNumber01, { y = ( display.contentHeight * ( 1 / 3 )), time = 1000, delay = 500, transition = easing.inOutExpo })
	transition.to( playerNumber02, { y = ( display.contentHeight * ( 1 / 3 )), time = 1000, delay = 550, transition = easing.inOutExpo })
	transition.to( playerNumber03, { y = ( display.contentHeight * ( 1 / 3 )), time = 1000, delay = 600,transition = easing.inOutExpo })
	transition.to( playerNumber04, { y = ( display.contentHeight * ( 1 / 3 )), time = 1000, delay = 650, transition = easing.inOutExpo })
	transition.to( playerNumber05, { y = ( display.contentHeight * ( 1 / 3 )), time = 1000, delay = 700, transition = easing.inOutExpo })

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
	environmentSheet:dispose()
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

	--[[
	transition.to( playerSelectText, { y = ( 0 - playerSelectText.contentHeight ), time = 1000, transition = easing.inOutExpo })

	transition.to( playerNumber01, { y = ( 0 - playerNumber01.contentHeight ), time = 1000, delay = 500, transition = easing.inOutExpo })
	transition.to( playerNumber02, { y = ( 0 - playerNumber02.contentHeight ), time = 1000, delay = 550, transition = easing.inOutExpo })
	transition.to( playerNumber03, { y = ( 0 - playerNumber03.contentHeight ), time = 1000, delay = 600,transition = easing.inOutExpo })
	transition.to( playerNumber04, { y = ( 0 - playerNumber04.contentHeight ), time = 1000, delay = 650, transition = easing.inOutExpo })
	transition.to( playerNumber05, { y = ( 0 - playerNumber05.contentHeight ), time = 1000, delay = 700, transition = easing.inOutExpo,
										onComplete = function() storyboard.gotoScene( "scenes.round" ) end }) ]]
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene