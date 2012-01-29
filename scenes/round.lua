local sprite = require "sprite"
local storyboard = require "storyboard"
local scene = storyboard.newScene()

local feedbackFlashCount, currentState, styleIndex
local onEnterFrame, onAccelerometer, onGyro

local roundNumberText, verbText, styleText, hintText
local feedbackGroup, feedbackLeftText, feedbackRightText, exclamationLeftText, exclamationRightText
local prepareChallenge, startChallenge, updateChallenge, flashFeedback, postFlashFeedback

local currentAccel, currentGyro, threshold

local previousTime, previousOffence

local verbs =
{
	"Cartwheel",
	"Crabwalk",
	"Crawl",
	"Gallop",
	"Hop",
	"Jump",
	"Leapfrog",
	"Push-up",
	"Roll",
	"Run",
	"Skip",
	"Spin",
	"Sprint",
	"Squat",
	"Wheelbarrow",
}

local styles =
{
	"Wildly",
	"Cautiously"
}

local hints =
{
	"(Maximize Movement)",
	"(Minimize Movement)"
}

function scene:createScene( event )
	local group = self.view

	roundNumberText = display.newRetinaText( "Round "..storyboard.currentRound, 0, 0, "Cubano", 24 )
	roundNumberText.x = display.contentWidth / 2
	roundNumberText.y = 0 - roundNumberText.contentHeight
	roundNumberText:setTextColor( 65, 132, 187 )
	group:insert( roundNumberText )

	verbText = display.newRetinaText( "", 0, 0, "Cubano", 48 )
	verbText:setTextColor( 65, 132, 187 )
	group:insert( verbText )

	styleText = display.newRetinaText( "", 0, 0, "Cubano", 48 )
	styleText:setTextColor( 65, 132, 187 )
	group:insert( styleText )

	hintText = display.newRetinaText( "", 0, 0, "Cubano", 16 )
	hintText:setTextColor( 65, 132, 187 )
	group:insert( hintText )

	feedbackGroup = display.newGroup()

	feedbackLeftText = display.newRetinaText( "Get Ready", 0, display.contentHeight / 2.5, "Cubano", 14 )
	feedbackLeftText.x = display.contentWidth / 8
	feedbackLeftText:setTextColor( 65, 132, 187 )
	feedbackGroup:insert( feedbackLeftText )

	feedbackRightText = display.newRetinaText( "Get Ready", 0, display.contentHeight / 2.5, "Cubano", 14 )
	feedbackRightText.x = display.contentWidth - ( display.contentWidth / 8 )
	feedbackRightText:setTextColor( 65, 132, 187 )
	feedbackGroup:insert( feedbackRightText )

	exclamationLeftText = display.newRetinaText( "!", 0, display.contentHeight / 2.5, "Cubano", 64 )
	exclamationLeftText.x = display.contentWidth / 8
	exclamationLeftText:setTextColor( 65, 132, 187 )
	feedbackGroup:insert( exclamationLeftText )

	exclamationRightText = display.newRetinaText( "!", 0, display.contentHeight / 2.5, "Cubano", 64 )
	exclamationRightText.x = display.contentWidth - ( display.contentWidth / 8 )
	exclamationRightText:setTextColor( 65, 132, 187 )
	feedbackGroup:insert( exclamationRightText )

	feedbackGroup.alpha = 0

	group:insert( feedbackGroup )
end

function scene:enterScene( event )
	currentState = 0
	feedbackFlashCount = 3
	currentAccel = 0
	currentGyro = 0
	threshold = 0
	previousTime = system.getTimer()

	transition.to( roundNumberText, { y = ( display.contentHeight * ( 1 / 8 )), time = 1000, transition = easing.inOutExpo, onComplete = prepareChallenge })

	Runtime:addEventListener( "enterFrame", onEnterFrame )
end

function scene:exitScene( event )
	Runtime:removeEventListener( "enterFrame", onEnterFrame )
end

function scene:destroyScene( event )

end

onEnterFrame = function( event )
	local dt = ( event.time - previousTime ) / 1000
	previousTime = event.time
	
	if currentState == 0 and feedbackFlashCount == 0 then
		currentState = 1
		flashFeedbackCount = 1
		feedbackLeftText.text = "Go"
		feedbackRightText.text = "Go"
		flashFeedback( feedbackGroup )
	elseif currentState == 1 then
		currentState = 2
		previousOffence = event.time
		local ultimote = require "Ultimote"; ultimote.connect();
		Runtime:addEventListener( "accelerometer", onAccelerometer )
		Runtime:addEventListener( "gyroscope", onGyro )
	elseif currentState == 2 then
		threshold = threshold - ( 5 * dt )
		if threshold < 0 then threshold = 0 end

		if styleIndex == 1 then -- MAXIMIZE
			local scalarMovement = ( currentAccel / 0.6 ) + ( currentGyro / 12.5 )
			print( "MAXIMIZING: ", scalarMovement..", ACCEL: "..(currentAccel / 0.6)..", GYRO: "..(currentGyro / 12.5))
			if scalarMovement <= 1.0 then
				local punishment = 25 * ( ( event.time - previousOffence ) / 1000 )
				if punishment > 25 then punishment = 25 end
				threshold = threshold + punishment
				previousOffence = event.time
				print( "PUNISHED! THRESHOLD = "..threshold..", PUNISHMENT = "..punishment)
			end
		elseif styleIndex == 2 then -- MINIMIZE
			local scalarMovement = ( currentAccel / 0.6 ) + ( currentGyro / 12.5 )
			print( "MINIMIZING: ", scalarMovement..", ACCEL: "..(currentAccel / 0.6)..", GYRO: "..(currentGyro / 12.5))
			if scalarMovement >= 1.0 then
				local punishment = 25 * ( ( event.time - previousOffence ) / 1000 )
				if punishment > 25 then punishment = 25 end
				threshold = threshold + punishment
				previousOffence = event.time
				print( "PUNISHED! THRESHOLD = "..threshold..", PUNISHMENT = "..punishment)
			end
		end

		if threshold >= 100 then print ("~~~~~~~~~~~~~~~~~~~~~~~~~~ROUND OVER"); threshold = 0 end
	end
end

onAccelerometer = function( event )
	currentAccel = ( ( math.abs( event.xInstant ) + math.abs( event.yInstant ) + math.abs( event.zInstant ) ) / 3 )
end

onGyro = function( event )
	currentGyro = ( ( math.abs( event.xRotation ) + math.abs( event.yRotation ) + math.abs( event.zRotation ) ) / 3 )
end

prepareChallenge = function()
	verbText.text = verbs[ math.random( 1, #verbs )]
	verbText.x = display.contentWidth / 2
	verbText.y = 0 - verbText.contentHeight

	styleIndex = math.random( 1, #styles )
	
	styleText.text = styles[ styleIndex ]
	styleText.x = display.contentWidth / 2
	styleText.y = 0 - styleText.contentHeight

	hintText.text = hints[ styleIndex ]
	hintText.x = display.contentWidth / 2
	hintText.y = 0 - styleText.contentHeight

	transition.to( roundNumberText, { y = 0 - roundNumberText.contentHeight, time = 1000, transition = easing.inOutExpo })
	
	--transition.to( bubbleSprite, { y = display.contentHeight / 4, time = 1000, transition = easing.inOutExpo })
	transition.to( verbText, { y = display.contentHeight / 8, time = 1000, delay = 200, transition = easing.inOutExpo })
	transition.to( styleText, { y = display.contentHeight / 4, time = 1000, delay = 400, transition = easing.inOutExpo })
	transition.to( hintText, { y = display.contentHeight / 2.75, time = 1000, delay = 600, transition = easing.inOutExpo })

	flashFeedback( feedbackGroup )
end

startChallenge = function()
	system.vibrate()
end

updateChallenge = function()
end

flashFeedback = function( obj )
	obj.alpha = 1.0
	transition.to( obj, { alpha = 0, time = 2000, transition = easing.inExpo, onComplete = postFlashFeedback })
end

postFlashFeedback = function( obj )
	feedbackFlashCount = feedbackFlashCount - 1

	if feedbackFlashCount > 0 then
		flashFeedback( obj )
	end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene