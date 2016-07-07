class DesktopClient

	threeJS:null

	constructor:(@threeJS = null)->
		@socket = io.connect()
		@socket.on "connect", =>@onConnect()

	roundTwoDigit:(num)->
		Math.round(num * 100)/100

	#----------------------------------------#
	# EVENT HANDLERS
	#----------------------------------------#
	onConnect:->
		@socket.emit "create-session"
		@socket.addListener "initial-state", @onInitState
		@socket.addListener "connection-established", (data)=>@onConnectionEstablished(data)
		@socket.addListener "mobile-receive", (data)=>@onMobileReceive(data)

	onInitState: (data) ->
		console.log 'onInitState',data
		$("#session-id").append "Scan QR Code or type this code into your phone:  "+data.session
		$('#qrcode').qrcode("//"+window.document.location.host+"/mobile.html?sessionID="+data.session)

	onConnectionEstablished: (data) ->
		console.log 'onConnectionEstablished',data
		$('#qrcode').hide()
		$("#session-id").html "CONNECTED"

	onMobileReceive:(data) ->
		str = ""
		str += "gyro.x "+@roundTwoDigit(data.gyro.x)+"<br>"
		str += "gyro.y "+@roundTwoDigit(data.gyro.y)+"<br>"
		str += "gyro.z "+@roundTwoDigit(data.gyro.z)+"<br>"

		if @threeJS? 
			@threeJS.render(data.gyro.gamma, data.gyro.beta, data.gyro.alpha)
		else
			str += "gyro.alpha "+@roundTwoDigit(data.gyro.alpha)+"<br>"
			str += "gyro.beta "+@roundTwoDigit(data.gyro.beta)+"<br>"
			str += "gyro.gamma "+@roundTwoDigit(data.gyro.gamma)+"<br>"
			str += "gyro.multiplier "+@roundTwoDigit(data.gyro.multiplier)+"<br>"
			str += "gyro.tilt "+@roundTwoDigit(data.gyro.tilt)+"<br>"

			str += "acceleration.x "+@roundTwoDigit(data.acceleration.x)+"<br>"
			str += "acceleration.y "+@roundTwoDigit(data.acceleration.y)+"<br>"
			str += "acceleration.z "+@roundTwoDigit(data.acceleration.z)+"<br>"
			str += "acceleration.gx "+@roundTwoDigit(data.acceleration.gx)+"<br>"
			str += "acceleration.gy "+@roundTwoDigit(data.acceleration.gy)+"<br>"
			str += "acceleration.gz "+@roundTwoDigit(data.acceleration.gz)+"<br>"
			str += "acceleration.alpha "+@roundTwoDigit(data.acceleration.alpha)+"<br>"
			str += "acceleration.beta "+@roundTwoDigit(data.acceleration.beta)+"<br>"
			str += "acceleration.gamma "+@roundTwoDigit(data.acceleration.gamma)+"<br>"

		$("#debug").html str
