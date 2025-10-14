
extends CharacterBody3D


@export var speed: float = 15.0
@export var acceleration: float = 8.0
@export var jump_force: float = 15.0
@export var gravity: float = 40.0
@export var force_strength: float = 30.0
@export var pickup_damping_distance: float = 1.0
@export var player_number = "1"

@onready var mesh: MeshInstance3D = $MeshInstance3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# --- GRAVEDAD ---
	if not is_on_floor():
		velocity.y -= gravity * delta
	elif Input.is_action_just_pressed("jump_p" + player_number):
		velocity.y = jump_force

	# --- ENTRADA DE MOVIMIENTO ---
	var input_dir := Vector3.ZERO

	if Input.is_action_pressed("move_forward_p" + player_number):
		input_dir.z -= 1
	if Input.is_action_pressed("move_back_p" + player_number):
		input_dir.z += 1
	if Input.is_action_pressed("move_left_p" + player_number):
		input_dir.x -= 1
	if Input.is_action_pressed("move_right_p" + player_number):
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
	
	
	
	if Input.is_action_just_pressed("pickup_p" + player_number):
		if $"pickup point".get_children() != []:
			for i in $"pickup point".get_children():
				i.reparent(self.get_parent())
				if i is RigidBody3D:
						i.gravity_scale = 1
		else:
			for i in $PickupRange.get_overlapping_bodies():
				if i.is_in_group("pickuplocal"):
					i.reparent($"pickup point")
					if i is RigidBody3D:
						i.gravity_scale = 0
						i.position = $"pickup point".position
					break

	if $"pickup point".get_children() != []:
		for i in $"pickup point".get_children():
			if i is RigidBody3D:
				var direction = $"pickup point".global_position - i.global_position
				var distance = direction.length()
				if distance > pickup_damping_distance:
					direction = direction.normalized()
					var force = direction * force_strength
					i.apply_central_force(force)
				i.set_axis_velocity(Vector3.ZERO)
				

func apply_knockback(fuerza):
	velocity += fuerza
	print("a")
