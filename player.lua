local player = {}
local player_mt = { __index = player }

local playersSheet = sprite.newSpriteSheetFromData( "textures/players".._G.filenameSuffix..".png", 
							require( "textures.players".._G.filenameSuffix ).getSpriteSheetData() )

function player.new( playerNumber )
	local newPlayer = {}
	newPlayer.sprite = sprite.newSprite( sprite.newSpriteSet( playersSheet, playerNumber, 1 ) )
	newPlayer.sprite.xScale = _G.spriteScale
	newPlayer.sprite.yScale = _G.spriteScale

	newPlayer.sprite.x = ( display.contentWidth / 6 ) * playerNumber
	newPlayer.sprite.y = display.contentHeight * ( 2 / 3 )

	return setmetatable( newPlayer, player_mt )
end

function player:destroy()
	player.sprite:removeSelf()
end

return player