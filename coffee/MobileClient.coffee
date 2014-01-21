class MobileClient

	animationRequest:null

	constructor:(@motionData = null)->
		if @motionData is null
			throw new Error('Must pass a MotionCapture instance')
			return

		@socket = io.connect()
		@socket.on "connect", =>@onConnect()

	broadcastMobileData:->
		# console.log '@motionData',@motionData
		@socket.emit "mobile-send",{gyro:@motionData.gyro, acceleration:@motionData.acceleration, orientation:@motionData.orientation}

	broadcastConnection:(sessionID_)-> 
		data = session: sessionID_
		@socket.emit "session-connect", data

	endAnimation:->
		window.cancelAnimationFrame @animationRequest

	#----------------------------------------#
	# EVENT HANDLERS
	#----------------------------------------#
	onConnect:->
		@socket.addListener "connection-established", (data)=>@onConnectionEstablished(data)

		sessionID = window.location.search.replace("?sessionID=", '');
		console.log sessionID.length, isNaN(sessionID), sessionID
		if isNaN(sessionID) is false and sessionID.length is 4
			@broadcastConnection sessionID

	onConnectionEstablished: (data) ->
		console.log 'onConnectionEstablished', data
		$("#session-form").remove()
		$("body").html("begin rotating phone")

		@onAnimationFrame()

	onAnimationFrame:->
		@animationRequest = window.requestAnimationFrame(=>@onAnimationFrame())
		@broadcastMobileData()