extends Area3D

@export var force = 1
@export var explosion_chain_force = 1.2
var mem = 0

func _ready():
	$GPUParticles3D.emitting = true
	$GPUParticles3D2.emitting = true
	$CollisionShape3D.scale *= force

	
func _process(delta):
	if not ($GPUParticles3D.emitting or $GPUParticles3D2.emitting):
		queue_free()
	mem += 1
	if mem == 3:
		for entity in get_overlapping_bodies():
			if entity.has_method("apply_knockback"):
				var distance = self.global_position - entity.global_position
				entity.apply_knockback(distance.normalized()*force*30)
			if entity.is_in_group("pickuplocal"):
				print("chain")
				entity.explode(force * explosion_chain_force)
		
