extends Node3D
@onready var pause_menu = $CanvasLayer/PauseMenu


func _ready():
	pause_menu.visible = false

func _input(event):
	if event.is_action_pressed("ui_cancel"): # "ui_cancel" es por defecto la tecla Esc
		if get_tree().paused:
			resume_game()
		else:
			pause_game()

func pause_game():
	get_tree().paused = true
	pause_menu.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	print("Juego pausado")

func resume_game():
	get_tree().paused = false
	pause_menu.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print("Juego reanudado")
