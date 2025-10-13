
extends CharacterBody3D


@export var speed: float = 15.0
@export var acceleration: float = 8.0
@export var jump_force: float = 15.0
@export var gravity: float = 40.0

@onready var mesh: MeshInstance3D = $MeshInstance3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# --- GRAVEDAD ---
	if not is_on_floor():
		velocity.y -= gravity * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = jump_force

	# --- ENTRADA DE MOVIMIENTO ---
	var input_dir := Vector3.ZERO

	if Input.is_action_pressed("move_forward"):
		input_dir.z -= 1
	if Input.is_action_pressed("move_back"):
		input_dir.z += 1
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1

	input_dir = input_dir.normalized()

	# --- VELOCIDAD SUAVIZADA ---
	var target_velocity = input_dir * speed
	velocity.x = lerp(velocity.x, target_velocity.x, acceleration * delta)
	velocity.z = lerp(velocity.z, target_velocity.z, acceleration * delta)

	# --- ROTAR EL personaje entero HACIA LA DIRECCIÓN DE MOVIMIENTO ---
	if input_dir.length() > 0.1:
		var target_rotation = atan2(-input_dir.x, -input_dir.z)
		self.rotation.y = lerp_angle(self.rotation.y, target_rotation, delta * 10.0)

	# --- MOVER PERSONAJE ---
	move_and_slide()
	
	if Input.is_action_just_pressed("pickup"):
		if $"pickup point".get_children() != []:
			print($"pickup point".get_children() )
			for i in $"pickup point".get_children():
				i.reparent(self.get_parent())
				if i is RigidBody3D:
						i.gravity_scale = 1
		else:
			for i in $PickupRange.get_overlapping_bodies():
				if i.is_in_group("pickuplocal"):
					print("mem")
					i.reparent($"pickup point")
					if i is RigidBody3D:
						i.gravity_scale = 0
						i.position = $"pickup point".position
					break
			
	
