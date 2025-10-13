extends Area3D

@export var tamaño = 0

func _ready():
	$GPUParticles3D.emitting = true
	$GPUParticles3D2.emitting = true
	
func _process(delta):
	if not ($GPUParticles3D.emitting or $GPUParticles3D2.emitting):
		queue_free()
