extends CharacterBody3D

@export var speed: float = 5.0
@export var acceleration: float = 8.0
@onready var camera: Camera3D = $Pivot/Camera3D
@export var jump_force: float = 15.0
@export var gravity: float = 40.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
	# Si está en el suelo y se presiona saltar
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_force
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_dir.y = Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")

	if input_dir.length() > 0:
		input_dir = input_dir.normalized()
		var forward = -camera.global_transform.basis.z
		var right = camera.global_transform.basis.x
		var direction = (right * input_dir.x + forward * input_dir.y).normalized()

		velocity.x = lerp(velocity.x, direction.x * speed, acceleration * delta)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, acceleration * delta)
		velocity.z = lerp(velocity.z, 0.0, acceleration * delta)
	rotation.y = pivot.rotation.y
	move_and_slide()



@onready var pivot = $Pivot
@export var mouse_sensitivity := 0.3

var camera_angle := 0.0  # Ángulo horizontal de la cámara

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# Rotar la cámara horizontalmente (orbitando alrededor del personaje)
		camera_angle -= event.relative.x * mouse_sensitivity
		pivot.rotation.y = deg_to_rad(camera_angle)
