-- This file is for use with Corona Game Edition
-- 
-- The function getSpriteSheetData() returns a table suitable for importing using sprite.newSpriteSheetFromData()
-- 
-- This file is automatically generated with TexturePacker (http://texturepacker.com). Do not edit
-- $TexturePacker:SmartUpdate:99dd07bb7d24760bb378b94c08947565$
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
				name = "player01@2x.png",
				spriteColorRect = { x = 6, y = 7, width = 242, height = 242 },
				textureRect = { x = 2, y = 490, width = 242, height = 242 },
				spriteSourceSize = { width = 256, height = 256 },
				spriteTrimmed = true,
				textureRotated = false
			},
			{
				name = "player02@2x.png",
				spriteColorRect = { x = 6, y = 7, width = 242, height = 242 },
				textureRect = { x = 246, y = 246, width = 242, height = 242 },
				spriteSourceSize = { width = 256, height = 256 },
				spriteTrimmed = true,
				textureRotated = false
			},
			{
				name = "player03@2x.png",
				spriteColorRect = { x = 6, y = 7, width = 242, height = 242 },
				textureRect = { x = 2, y = 246, width = 242, height = 242 },
				spriteSourceSize = { width = 256, height = 256 },
				spriteTrimmed = true,
				textureRotated = false
			},
			{
				name = "player04@2x.png",
				spriteColorRect = { x = 6, y = 7, width = 242, height = 242 },
				textureRect = { x = 246, y = 2, width = 242, height = 242 },
				spriteSourceSize = { width = 256, height = 256 },
				spriteTrimmed = true,
				textureRotated = false
			},
			{
				name = "player05@2x.png",
				spriteColorRect = { x = 6, y = 7, width = 242, height = 242 },
				textureRect = { x = 2, y = 2, width = 242, height = 242 },
				spriteSourceSize = { width = 256, height = 256 },
				spriteTrimmed = true,
				textureRotated = false
			},
		}
	}
end
return SpriteSheet

