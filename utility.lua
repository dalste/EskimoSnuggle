local utility = {}

utility.isPointInside = function( object, x, y )
	local inside = false

	local objectX = object.x - ( object.contentWidth / 2 )
	local objectY = object.y - ( object.contentHeight / 2 )

	if ( x >= objectX ) and
		( x <= ( objectX + object.contentWidth )) and
		( y >= objectY ) and
		( y <= ( objectY + object.contentHeight )) then
	
		inside = true
	end
	
	return inside
end

return utility