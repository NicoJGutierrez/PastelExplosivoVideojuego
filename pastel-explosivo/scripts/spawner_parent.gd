extends Node3D

var hijos
var hijo_spawneando = 0

func _ready():
	hijos = get_children()

func _on_timer_timeout():
	var hijo = hijos[hijo_spawneando]
	if hijo.has_method("spawnear"):
		hijo.spawnear()
	hijo_spawneando += 1
	if hijo_spawneando >= len(hijos):
		hijo_spawneando = 0
