extends Node3D

@export var objeto: PackedScene

func spawnear():
	var nuevo_objeto = objeto.instantiate()
	get_tree().root.add_child(nuevo_objeto)
	nuevo_objeto.global_position = self.global_position
