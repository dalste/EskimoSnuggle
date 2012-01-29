-- This file is for use with Corona Game Edition
-- 
-- The function getSpriteSheetData() returns a table suitable for importing using sprite.newSpriteSheetFromData()
-- 
-- This file is automatically generated with TexturePacker (http://texturepacker.com). Do not edit
-- $TexturePacker:SmartUpdate:5f61ba5bd1d343771e2274efcbd1de28$
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
				name = "armStyle01.png",
				spriteColorRect = { x = 0, y = 0, width = 18, height = 14 },
				textureRect = { x = 18, y = 232, width = 18, height = 14 },
				spriteSourceSize = { width = 18, height = 14 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "armStyle02.png",
				spriteColorRect = { x = 0, y = 0, width = 18, height = 14 },
				textureRect = { x = 18, y = 216, width = 18, height = 14 },
				spriteSourceSize = { width = 18, height = 14 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "legStyle01.png",
				spriteColorRect = { x = 0, y = 0, width = 14, height = 18 },
				textureRect = { x = 2, y = 236, width = 14, height = 18 },
				spriteSourceSize = { width = 14, height = 18 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "legStyle02.png",
				spriteColorRect = { x = 0, y = 0, width = 14, height = 18 },
				textureRect = { x = 2, y = 216, width = 14, height = 18 },
				spriteSourceSize = { width = 14, height = 18 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "skull.png",
				spriteColorRect = { x = 0, y = 0, width = 53, height = 42 },
				textureRect = { x = 185, y = 72, width = 53, height = 42 },
				spriteSourceSize = { width = 53, height = 42 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "torsoStyle01.png",
				spriteColorRect = { x = 0, y = 0, width = 59, height = 69 },
				textureRect = { x = 124, y = 2, width = 59, height = 69 },
				spriteSourceSize = { width = 59, height = 69 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "torsoStyle02.png",
				spriteColorRect = { x = 0, y = 0, width = 59, height = 69 },
				textureRect = { x = 63, y = 2, width = 59, height = 69 },
				spriteSourceSize = { width = 59, height = 69 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "torsoStyle03.png",
				spriteColorRect = { x = 0, y = 0, width = 59, height = 69 },
				textureRect = { x = 2, y = 145, width = 59, height = 69 },
				spriteSourceSize = { width = 59, height = 69 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "torsoStyle04.png",
				spriteColorRect = { x = 0, y = 0, width = 59, height = 69 },
				textureRect = { x = 2, y = 74, width = 59, height = 69 },
				spriteSourceSize = { width = 59, height = 69 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "torsoStyle05.png",
				spriteColorRect = { x = 0, y = 0, width = 59, height = 68 },
				textureRect = { x = 185, y = 2, width = 59, height = 68 },
				spriteSourceSize = { width = 59, height = 68 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "torsoStyle06.png",
				spriteColorRect = { x = 0, y = 0, width = 59, height = 70 },
				textureRect = { x = 2, y = 2, width = 59, height = 70 },
				spriteSourceSize = { width = 59, height = 70 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "weakened.png",
				spriteColorRect = { x = 6, y = 4, width = 46, height = 62 },
				textureRect = { x = 63, y = 73, width = 46, height = 62 },
				spriteSourceSize = { width = 60, height = 70 },
				spriteTrimmed = true,
				textureRotated = false
			},
		}
	}
end
return SpriteSheet

