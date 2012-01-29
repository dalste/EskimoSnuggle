local sprite = require "sprite"
local storyboard = require "storyboard"
local scene = storyboard.newScene()

local flashFeedbackCount, flashFeedbackTransition, currentState, styleIndex
local onEnterFrame, onAccelerometer, onGyro

local roundNumberText, verbText, styleText, hintText
local feedbackGroup, feedbackLeftText, feedbackRightText, exclamationLeftText, exclamationRightText
local prepareChallenge, winChallenge, loseChallenge, flashFeedback, postFlashFeedback
local winChallengeTimer

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
	flashFeedbackCount = 3
	currentAccel = 0
	currentGyro = 0
	threshold = 0
	previousTime = system.getTimer()

	roundNumberText.x = display.contentWidth / 2
	roundNumberText.y = 0 - roundNumberText.contentHeight

	feedbackGroup.alpha = 0

	transition.to( roundNumberText, { y = ( display.contentHeight * ( 1 / 8 )), time = 1000, transition = easing.inOutExpo, onComplete = prepareChallenge })

	Runtime:addEventListener( "enterFrame", onEnterFrame )
end

function scene:exitScene( event )
	if winChallengeTimer ~= nil then timer.cancel( winChallengeTimer ) end
	if flashFeedbackTransition ~= nil then transition.cancel( flashFeedbackTransition ) end
	
	Runtime:removeEventListener( "enterFrame", onEnterFrame )
	Runtime:removeEventListener( "accelerometer", onAccelerometer )
	Runtime:removeEventListener( "gyroscope", onGyro )
end

function scene:destroyScene( event )

end

onEnterFrame = function( event )
	local dt = ( event.time - previousTime ) / 1000
	previousTime = event.time
	
	if currentState == 0 and flashFeedbackCount <= 0 then
		currentState = 1
		flashFeedbackCount = 1
		feedbackLeftText.text = "Go"
		feedbackRightText.text = "Go"
		flashFeedback( feedbackGroup )
	elseif currentState == 1 and flashFeedbackCount <= 0 then
		currentState = 2
		previousOffence = event.time

		if styleIndex == 1 then -- MAXIMIZE
			feedbackLeftText.text = "Faster"
			feedbackRightText.text = "Faster"
		elseif styleIndex == 2 then -- MINIMIZE
			feedbackLeftText.text = "Slower"
			feedbackRightText.text = "Slower"
		end
		
		--local ultimote = require "Ultimote"; ultimote.connect();
		
		winChallengeTimer = timer.performWithDelay( 18000, winChallenge )

		Runtime:addEventListener( "accelerometer", onAccelerometer )
		Runtime:addEventListener( "gyroscope", onGyro )
	elseif currentState == 2 then
		threshold = threshold - ( 5 * dt )
		if threshold < 0 then threshold = 0 end

		if styleIndex == 1 then -- MAXIMIZE
			local scalarMovement = ( currentAccel / 0.6 ) + ( currentGyro / 12.5 )
			
			--print( "MAXIMIZING: ", scalarMovement..", ACCEL: "..(currentAccel / 0.6)..", GYRO: "..(currentGyro / 12.5))
			
			if scalarMovement <= 1.0 then
				if flashFeedbackCount <= 0 then
					flashFeedbackCount = 1
					flashFeedback( feedbackGroup )
				end

				local punishment = 25 * ( ( event.time - previousOffence ) / 1000 )
				if punishment > 25 then punishment = 25 end
				threshold = threshold + punishment
				previousOffence = event.time
				
				--print( "PUNISHED! THRESHOLD = "..threshold..", PUNISHMENT = "..punishment)
			end
		elseif styleIndex == 2 then -- MINIMIZE
			local scalarMovement = ( currentAccel / 0.6 ) + ( currentGyro / 12.5 )
			
			--print( "MINIMIZING: ", scalarMovement..", ACCEL: "..(currentAccel / 0.6)..", GYRO: "..(currentGyro / 12.5))
			
			if scalarMovement >= 1.0 then
				if flashFeedbackCount <= 0 then
					flashFeedbackCount = 1
					flashFeedback( feedbackGroup )
				end

				local punishment = 25 * ( ( event.time - previousOffence ) / 1000 )
				if punishment > 25 then punishment = 25 end
				threshold = threshold + punishment
				previousOffence = event.time
				
				--print( "PUNISHED! THRESHOLD = "..threshold..", PUNISHMENT = "..punishment)
			end
		end

		if threshold >= 100 then
			loseChallenge()
		end
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
	verbText.alpha = 1

	styleIndex = 1 --math.random( 1, #styles )
	
	styleText.text = styles[ styleIndex ]
	styleText.x = display.contentWidth / 2
	styleText.y = 0 - styleText.contentHeight
	styleText.alpha = 1

	hintText.text = hints[ styleIndex ]
	hintText.x = display.contentWidth / 2
	hintText.y = 0 - styleText.contentHeight
	hintText.alpha = 1

	transition.to( roundNumberText, { y = 0 - roundNumberText.contentHeight, time = 1000, transition = easing.inOutExpo })
	
	transition.to( verbText, { y = display.contentHeight / 8, time = 1000, delay = 200, transition = easing.inOutExpo })
	transition.to( styleText, { y = display.contentHeight / 4, time = 1000, delay = 400, transition = easing.inOutExpo })
	transition.to( hintText, { y = display.contentHeight / 2.75, time = 1000, delay = 600, transition = easing.inOutExpo })

	flashFeedback( feedbackGroup )
end

winChallenge = function()
	currentState = 3
	system.vibrate()

	transition.to( verbText, { alpha = 0, time = 500 })
	transition.to( styleText, { alpha = 0, time = 500, delay = 200 })
	transition.to( hintText, { alpha = 0, time = 500, delay = 400, onComplete = function() print("WON") end })
end

loseChallenge = function()
	currentState = 3
	system.vibrate()

	transition.to( verbText, { alpha = 0, time = 500 })
	transition.to( styleText, { alpha = 0, time = 500, delay = 200 })
	transition.to( hintText, { alpha = 0, time = 500, delay = 400, onComplete = function() storyboard.gotoScene( "scenes.frostbitten" ) end })
end

flashFeedback = function( obj )
	obj.alpha = 1.0
	system.vibrate()
	flashFeedbackTransition = transition.to( obj, { alpha = 0, time = 2000, transition = easing.inExpo, onComplete = postFlashFeedback })
end

postFlashFeedback = function( obj )
	flashFeedbackCount = flashFeedbackCount - 1

	if flashFeedbackCount > 0 then
		flashFeedback( obj )
	end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene