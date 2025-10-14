extends Area3D

@export var force = 1
@export var explosion_chain_force = 1.2

func _ready():
	$GPUParticles3D.emitting = true
	$GPUParticles3D2.emitting = true
	$CollisionShape3D.scale *= force
	
	for entity in get_overlapping_areas():
		if entity.has_method("apply_knockback"):
			var distance = self.global_position - entity.global_position
			entity.apply_knockback(distance.normalized()*(force*10 - (abs(distance)/2)))
		if entity.is_in_group("pickuplocal"):
			entity.explode(force * explosion_chain_force)
	
func _process(delta):
	if not ($GPUParticles3D.emitting or $GPUParticles3D2.emitting):
		queue_free()
	
