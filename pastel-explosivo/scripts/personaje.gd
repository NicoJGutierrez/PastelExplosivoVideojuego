extends CharacterBody3D

@export var speed = 5.0
@export var jump_velocity = 4.5
@export var gravity = 9.8

func _physics_process(delta):
	# Apply gravity if not on the floor
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump input
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and normalize it
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Apply movement
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	velocity = velocity.rotated(Vector3.UP, -90)
	move_and_slide()
