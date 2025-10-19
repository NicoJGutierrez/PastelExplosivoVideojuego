extends RigidBody3D

@export var chance_to_boom = 50
var current_boom = 0

func _ready():
	contact_monitor = true
	max_contacts_reported = 5
	
func _physics_process(delta):
	if self.get_parent().get_parent() != null and self.get_parent().get_parent().is_in_group("player"):
		for node in get_colliding_bodies():
			if is_instance_valid(node):
				if node.is_in_group("player") and node != get_parent().get_parent():
					print("2")
					explode(3)
				elif node.is_in_group("ingrediente"):
					pass
				elif node.is_in_group("pickuplocal"):
					print("1")
					explode(4)
				else: 
					if not node.is_in_group("player"):
						current_boom += 1
		if current_boom == chance_to_boom:
				current_boom = 0
				print("3")
				explode(2)
			
func explode(force):
	var nueva_explosion = preload("res://scripts/explosion.tscn").instantiate()
	print("bum")
	nueva_explosion.force = force
	
	get_tree().root.add_child(nueva_explosion)
	nueva_explosion.global_position = self.global_position
	queue_free()
