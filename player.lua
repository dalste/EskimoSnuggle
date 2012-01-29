local player = {}
local player_mt = { __index = player }

local playersSheet = sprite.newSpriteSheetFromData( "textures/players".._G.filenameSuffix..".png", 
							require( "textures.players".._G.filenameSuffix ).getSpriteSheetData() )

function player.new( playerNumber )
	local newPlayer = {}

	newPlayer.group = display.newGroup()

	if playerNumber % 2 == 0 then
		newPlayer.armLeft = sprite.newSprite( sprite.newSpriteSet( playersSheet, 2, 1 ) )
	else
		newPlayer.armLeft = sprite.newSprite( sprite.newSpriteSet( playersSheet, 1, 1 ) )
	end
	newPlayer.armLeft.xScale = _G.spriteScale
	newPlayer.armLeft.yScale = _G.spriteScale
	newPlayer.group:insert( newPlayer.armLeft )
	newPlayer.armLeft.y = 23
	newPlayer.armLeft.x = -21

	if playerNumber % 2 == 0 then
		newPlayer.armRight = sprite.newSprite( sprite.newSpriteSet( playersSheet, 2, 1 ) )
	else
		newPlayer.armRight = sprite.newSprite( sprite.newSpriteSet( playersSheet, 1, 1 ) )
	end
	newPlayer.armRight.xScale = _G.spriteScale
	newPlayer.armRight.yScale = _G.spriteScale
	newPlayer.group:insert( newPlayer.armRight )
	newPlayer.armRight.y = 23
	newPlayer.armRight.x = 21

	if playerNumber % 2 == 0 then
		newPlayer.legLeft = sprite.newSprite( sprite.newSpriteSet( playersSheet, 4, 1 ) )
	else
		newPlayer.legLeft = sprite.newSprite( sprite.newSpriteSet( playersSheet, 3, 1 ) )
	end
	newPlayer.legLeft.xScale = _G.spriteScale
	newPlayer.legLeft.yScale = _G.spriteScale
	newPlayer.group:insert( newPlayer.legLeft )
	newPlayer.legLeft.y = 38
	newPlayer.legLeft.x = -12

	if playerNumber % 2 == 0 then
		newPlayer.legRight = sprite.newSprite( sprite.newSpriteSet( playersSheet, 4, 1 ) )
	else
		newPlayer.legRight = sprite.newSprite( sprite.newSpriteSet( playersSheet, 3, 1 ) )
	end
	newPlayer.legRight.xScale = _G.spriteScale
	newPlayer.legRight.yScale = _G.spriteScale
	newPlayer.group:insert( newPlayer.legRight )
	newPlayer.legRight.y = 38
	newPlayer.legRight.x = 12

	newPlayer.torso = sprite.newSprite( sprite.newSpriteSet( playersSheet, ( 5 + playerNumber ), 1 ) )
	newPlayer.torso.xScale = _G.spriteScale
	newPlayer.torso.yScale = _G.spriteScale
	newPlayer.group:insert( newPlayer.torso )

	newPlayer.weakened = sprite.newSprite( sprite.newSpriteSet( playersSheet, 12, 1 ) )
	newPlayer.weakened.xScale = _G.spriteScale
	newPlayer.weakened.yScale = _G.spriteScale
	newPlayer.weakened.alpha = 0
	newPlayer.group:insert( newPlayer.weakened )

	newPlayer.group.x = ( display.contentWidth / 6 ) * playerNumber

	if playerNumber % 2 == 0 then
		newPlayer.group.y = display.contentHeight * ( 2 / 3 ) + 20
	else
		newPlayer.group.y = display.contentHeight * ( 2 / 3 )
	end

	newPlayer.skull = sprite.newSprite( sprite.newSpriteSet( playersSheet, 5, 1 ) )
	newPlayer.skull.xScale = _G.spriteScale
	newPlayer.skull.yScale = _G.spriteScale
	newPlayer.skull.alpha = 0
	newPlayer.skull.x = newPlayer.group.x
	newPlayer.skull.y = newPlayer.group.y + 20

	newPlayer.alive = true
	newPlayer.numberOfLimbs = 4

	return setmetatable( newPlayer, player_mt )
end

function player:removeLimb()
	self.numberOfLimbs = self.numberOfLimbs - 1

	local remainingLimbs = {}
	if self.armLeft.alpha == 1.0 then table.insert( remainingLimbs, self.armLeft ) end
	if self.armRight.alpha == 1.0 then table.insert( remainingLimbs, self.armRight ) end
	if self.legLeft.alpha == 1.0 then table.insert( remainingLimbs, self.legLeft ) end
	if self.legRight.alpha == 1.0 then table.insert( remainingLimbs, self.legRight ) end

	local severedLimb = remainingLimbs[ math.random( 1, #remainingLimbs ) ]
	transition.to( severedLimb, { alpha = 0, time = 500, delay = 500 })

	self.weakened.alpha = 1
	transition.to( self.weakened, { alpha = 0, time = 3000, delay = 500 })
	
	if( self.numberOfLimbs <= 0) then
		transition.dissolve( self.group, self.skull, 1000, 0 )
		self.alive = false
	end

	if severedLimb == self.armLeft then return "Right Arm" end
	if severedLimb == self.armRight then return "Left Arm" end
	if severedLimb == self.legLeft then return "Right Leg" end
	if severedLimb == self.legRight then return "Left Leg" end
end

function player:restoreLimb()
	self.numberOfLimbs = self.numberOfLimbs + 1
	if self.numberOfLimbs > 4 then self.numberOfLimbs = 4; return; end

	if self.armLeft.alpha == 1.0 then
		transition.to( self.armLeft, { alpha = 1, time = 500, delay = 500 })
		self.weakened.alpha = 1
		transition.to( self.weakened, { alpha = 0, time = 3000, delay = 500 })
		return "Right Arm"
	elseif self.armRight.alpha == 1.0 then
		transition.to( self.armRight, { alpha = 1, time = 500, delay = 500 })
		self.weakened.alpha = 1
		transition.to( self.weakened, { alpha = 0, time = 3000, delay = 500 })
		return "Left Arm"
	elseif self.legLeft.alpha == 1.0 then 
		transition.to( self.legLeft, { alpha = 1, time = 500, delay = 500 })
		self.weakened.alpha = 1
		transition.to( self.weakened, { alpha = 0, time = 3000, delay = 500 })
		return "Right Leg"
	elseif self.legRight.alpha == 1.0 then
		transition.to( self.legRight, { alpha = 1, time = 500, delay = 500 })
		self.weakened.alpha = 1
		transition.to( self.weakened, { alpha = 0, time = 3000, delay = 500 })
		return "Left Leg"
	end
end

function player:destroy()
	self.group:removeSelf()
	self.skull:removeSelf()
end

return player