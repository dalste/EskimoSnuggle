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

	newPlayer.skull = sprite.newSprite( sprite.newSpriteSet( playersSheet, 6, 1 ) )
	newPlayer.skull.xScale = _G.spriteScale
	newPlayer.skull.yScale = _G.spriteScale
	newPlayer.skull.x = ( display.contentWidth / 6 ) * playerNumber
	newPlayer.skull.y = display.contentHeight * ( 2 / 3 )
	newPlayer.skull.alpha = 0

	newPlayer.alive = true

	newPlayer.numberOfLimbs = 1

	return setmetatable( newPlayer, player_mt )
end

function player:removeLimb( limb )
	self.numberOfLimbs = self.numberOfLimbs - 1

	if( self.numberOfLimbs <= 0) then
		transition.dissolve( self.sprite, self.skull, 1000, 0 )
		self.alive = false
	end
end

function player:destroy()
	self.sprite:removeSelf()
end

return player