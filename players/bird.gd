extends RigidBody2D

@export var FLAP_FORCE = -200
var started = false

const MAX_ROTATION_DEGREES = -30.0

func _process(delta):
	if Input.is_action_just_pressed("flap"):
		if !started:
			start()
		flap()
	
	if rotation_degrees <= MAX_ROTATION_DEGREES:
		angular_velocity = 0
		rotation_degrees = MAX_ROTATION_DEGREES
		
	if linear_velocity.y > 0:
		if rotation_degrees <= 90:
			angular_velocity = 3
		else:
			angular_velocity = 0

func start():
	if started: return
	started = true
	gravity_scale = 1.0
	$AnimationPlayer.play("flap")
		

func flap():
	linear_velocity.y = FLAP_FORCE
	angular_velocity = -0.8










