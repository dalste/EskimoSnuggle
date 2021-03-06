-- This file is for use with Corona Game Edition
-- 
-- The function getSpriteSheetData() returns a table suitable for importing using sprite.newSpriteSheetFromData()
-- 
-- This file is automatically generated with TexturePacker (http://texturepacker.com). Do not edit
-- $TexturePacker:SmartUpdate:c3cc162ecf0cdfc852f132fe813f41d7$
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
				name = "environment.png",
				spriteColorRect = { x = 13, y = 5, width = 454, height = 138 },
				textureRect = { x = 2, y = 57, width = 454, height = 138 },
				spriteSourceSize = { width = 480, height = 150 },
				spriteTrimmed = true,
				textureRotated = false
			},
			{
				name = "player01.png",
				spriteColorRect = { x = 0, y = 0, width = 83, height = 75 },
				textureRect = { x = 302, y = 231, width = 83, height = 75 },
				spriteSourceSize = { width = 83, height = 75 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "player02.png",
				spriteColorRect = { x = 0, y = 0, width = 83, height = 75 },
				textureRect = { x = 257, y = 359, width = 83, height = 75 },
				spriteSourceSize = { width = 83, height = 75 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "player03.png",
				spriteColorRect = { x = 0, y = 0, width = 83, height = 75 },
				textureRect = { x = 172, y = 359, width = 83, height = 75 },
				spriteSourceSize = { width = 83, height = 75 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "player04.png",
				spriteColorRect = { x = 0, y = 0, width = 83, height = 75 },
				textureRect = { x = 87, y = 359, width = 83, height = 75 },
				spriteSourceSize = { width = 83, height = 75 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "player05.png",
				spriteColorRect = { x = 0, y = 0, width = 83, height = 75 },
				textureRect = { x = 2, y = 359, width = 83, height = 75 },
				spriteSourceSize = { width = 83, height = 75 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "shakeToStart.png",
				spriteColorRect = { x = 46, y = 6, width = 154, height = 32 },
				textureRect = { x = 302, y = 197, width = 154, height = 32 },
				spriteSourceSize = { width = 240, height = 38 },
				spriteTrimmed = true,
				textureRotated = false
			},
			{
				name = "textBubble.png",
				spriteColorRect = { x = 0, y = 0, width = 298, height = 160 },
				textureRect = { x = 2, y = 197, width = 298, height = 160 },
				spriteSourceSize = { width = 298, height = 160 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "title.png",
				spriteColorRect = { x = 10, y = 13, width = 466, height = 53 },
				textureRect = { x = 2, y = 2, width = 466, height = 53 },
				spriteSourceSize = { width = 480, height = 75 },
				spriteTrimmed = true,
				textureRotated = false
			},
		}
	}
end
return SpriteSheet

