local player = {}
local player_mt = { __index = player }

function player.new( playerNumber )
	local newPlayer = {}
	print( "CREATED PLAYER "..playerNumber )
	return setmetatable( newPlayer, player_mt )
end

function player:destroy()
	player.sprite:removeSelf()
end

return player