-- This file is for use with Corona Game Edition
-- 
-- The function getSpriteSheetData() returns a table suitable for importing using sprite.newSpriteSheetFromData()
-- 
-- This file is automatically generated with TexturePacker (http://texturepacker.com). Do not edit
-- $TexturePacker:SmartUpdate:28965c5605acfe1158e757608a9021a4$
-- 
-- Usage example:
--        local sheetData = require "ThisFile.lua"
--        local data = sheetData.getSpriteSheetData()
--        local spriteSheet = sprite.newSpriteSheetFromData( "Untitled.png", data )
-- 
-- For more details, see http://developer.anscamobile.com/content/game-edition-sprite-sheets

local SpriteSheet = {}
SpriteSheet.getSpriteSheetData = function ()
	return {
		frames = {
			{
				name = "clock.png",
				spriteColorRect = { x = 3, y = 3, width = 59, height = 59 },
				textureRect = { x = 179, y = 2, width = 59, height = 59 },
				spriteSourceSize = { width = 65, height = 65 },
				spriteTrimmed = true,
				textureRotated = false
			},
			{
				name = "textbox.png",
				spriteColorRect = { x = 0, y = 0, width = 175, height = 65 },
				textureRect = { x = 2, y = 2, width = 175, height = 65 },
				spriteSourceSize = { width = 175, height = 65 },
				spriteTrimmed = false,
				textureRotated = false
			},
		}
	}
end
return SpriteSheet

