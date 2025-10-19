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
					explode(3)
				elif self.is_in_group("ingrediente") and node.is_in_group("ingrediente"):
					crear_masa(node)
				elif self.is_in_group("masa") and node.is_in_group("masa"):
					crear_pastel(node)
				elif node.is_in_group("pickuplocal"):
					explode(4)
				else: 
					if not node.is_in_group("player"):
						current_boom += 1
		if current_boom == chance_to_boom:
				current_boom = 0
				explode(2)
			
func explode(force):
	var nueva_explosion = preload("res://scripts/explosion.tscn").instantiate()
	nueva_explosion.force = force
	
	get_tree().root.add_child(nueva_explosion)
	nueva_explosion.global_position = self.global_position
	queue_free()

func crear_masa(combinado):
	combinado.queue_free()
	var nueva_masa = load("res://ingredientes/masa.tscn")
	var masa_instancia = nueva_masa.instantiate()
	get_parent().add_child(masa_instancia)
	masa_instancia.global_position = self.global_position
	queue_free()
	
func crear_pastel(combinado):
	combinado.queue_free()
	var nueva_masa = load("res://ingredientes/torta.tscn")
	var masa_instancia = nueva_masa.instantiate()
	get_parent().add_child(masa_instancia)
	masa_instancia.global_position = self.global_position
	queue_free()
