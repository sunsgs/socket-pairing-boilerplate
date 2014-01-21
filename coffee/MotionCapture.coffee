class MotionCapture

	gyro:{}
	acceleration:{}
	orientation: 0

	constructor: ->
		@resetVars()

		window.addEventListener("deviceorientation", (e)=>@onDeviceOrientation(e))
		window.addEventListener("orientationchange", (e)=>@onOrientationChange(e))
		window.addEventListener("devicemotion", (e)=>@onDeviceMotion(e))
		@orientation = window.orientation

		console.log 'MotionCapture'

	destroy: ->
		window.removeEventListener("deviceorientation", (e)=>@onDeviceOrientation(e))
		window.removeEventListener("orientationchange", (e)=>@onOrientationChange(e))
		window.removeEventListener("devicemotion", (e)=>@onDeviceMotion(e))

	resetVars:->
		@gyro =
			x: 0
			y: 0
			z: 0
			alpha: 0
			beta: 0
			gamma: 0
			multiplier: 2
			tilt: 30

		@acceleration =
			x: 0
			y: 0
			z: 0
			gx: 0
			gy: 0
			gz: 0
			alpha: 0
			beta: 0
			gamma: 0

		@orientation = 0

	#----------------------------------------#
	# EVENT HANDLERS
	#----------------------------------------#
	onDeviceOrientation: (e) ->
		console.log 'onDeviceOrientation',e

		switch @orientation
			when 90
				@gyro.beta  = e.beta
				@gyro.gamma = -e.gamma - @gyro.tilt
				@gyro.alpha = 180 - (e.alpha + 180) % 360
			when 180
				@gyro.beta  = -e.beta - @gyro.tilt
				@gyro.gamma = e.gamma
				@gyro.alpha = 180 - (e.alpha) % 360
			when -90
				@gyro.beta  = -e.beta
				@gyro.gamma = e.gamma - @gyro.tilt
				@gyro.alpha = 180 - (e.alpha + 180) % 360
			#when 0
			else
				@gyro.beta  = e.beta - @gyro.tilt
				@gyro.gamma = e.gamma
				@gyro.alpha = 180 - (e.alpha + 180) % 360

		@gyro.x = @gyro.gamma * @gyro.multiplier
		@gyro.y = @gyro.beta * @gyro.multiplier
		@gyro.z = @gyro.alpha

	onOrientationChange: (e) ->
		console.log 'window.orientation',window.orientation, e
		@orientation = window.orientation

	onDeviceMotion: (e) ->
		console.log 'onDeviceMotion',e
		@acceleration.x     = e.acceleration.x
		@acceleration.y     = e.acceleration.y
		@acceleration.z     = e.acceleration.z
		@acceleration.gx    = e.accelerationIncludingGravity.x
		@acceleration.gy    = e.accelerationIncludingGravity.y
		@acceleration.gz    = e.accelerationIncludingGravity.z
		@acceleration.alpha = e.rotationRate.alpha
		@acceleration.beta  = e.rotationRate.beta
		@acceleration.gamma = e.rotationRate.gamma

		output = ""
		output += "x: " + @acceleration.x + "<br>"
		output += "y: " + @acceleration.y  + "<br>"
		output += "z: " + @acceleration.z  + "<br>"
		output += "gx: " + @acceleration.gx  + "<br>"
		output += "gy: " + @acceleration.gy  + "<br>"
		output += "gz: " + @acceleration.gz  + "<br>"
		output += "alpha: " + @acceleration.alpha  + "<br>"
		output += "beta: " + @acceleration.beta  + "<br>"
		output += "gamma: " + @acceleration.gamma

		$("#debug").html(output)