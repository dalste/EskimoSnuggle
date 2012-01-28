local storyboard = require "storyboard"
local scene = storyboard.newScene()

local onShake

function scene:createScene( event )
	local group = self.view
	
	local titleText = display.newRetinaText( "Eskimo Snuggle", 25, 25, native.systemFont, 16 )
	titleText:setTextColor( 255, 255, 255 )

	group:insert( titleText )
end

function scene:enterScene( event )
	Runtime:addEventListener( "accelerometer", onShake )
end

function scene:exitScene( event )
	Runtime:removeEventListener( "accelerometer", onShake )
end

function scene:destroyScene( event )
end

onShake = function( event )
	if event.isShake == true then
		storyboard.gotoScene( "scenes.playerselect" )
	end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene