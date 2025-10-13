extends RigidBody3D

@export var chance_to_boom = 100
@export var explosion: PackedScene
var current_boom = 0

func _ready():
	contact_monitor = true
	max_contacts_reported = 5
	
func _physics_process(delta):
	if self.get_parent().get_parent().is_in_group("player"):
		for node in get_colliding_bodies():
			if node.is_in_group("player") and node != get_parent().get_parent():
				explode(100)
			elif node.is_in_group("pickuplocal"):
				explode(160)
			elif not node.is_in_group("player"):
				current_boom += 1
		if current_boom == chance_to_boom:
				current_boom = 0
				explode(50)
			
func explode(force):
	var nueva_explosion = explosion.instantiate()
	add_child(nueva_explosion)
	nueva_explosion.position = self.position
	pass
