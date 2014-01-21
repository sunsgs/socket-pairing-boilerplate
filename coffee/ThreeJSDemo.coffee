class ThreeJSDemo
	scene:null
	camera:null
	mesh:null
	renderer:null

	constructor:->
		@scene = new THREE.Scene()
		@camera = new THREE.PerspectiveCamera(50, window.innerWidth / window.innerHeight, 1, 10000)
		
		@camera.position.z = 500
		@scene.add @camera
		
		geometry = new THREE.CubeGeometry(200, 200, 200)
		material = new THREE.MeshNormalMaterial()
		@mesh = new THREE.Mesh(geometry, material)
		
		@scene.add @mesh
		
		@renderer = new THREE.CanvasRenderer()
		@renderer.setSize window.innerWidth, window.innerHeight
		
		$("body").append @renderer.domElement

	render:(x,y,z)->
		@mesh.rotation.x = x*.1
		@mesh.rotation.y = y*.1
		@mesh.rotation.z = z*.1

		@renderer.render(@scene, @camera)