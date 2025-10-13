extends Control

func _on_reanudar_pressed():
	get_tree().paused = false
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_salir_pressed():
	get_tree().quit()
