extends Control

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS  

func _on_salir_button_button_down() -> void:
	get_tree().paused = false
	GameManager.reset_game()
	get_tree().change_scene_to_packed(SceneManager.main_menu)

func _on_inicio_button_button_down() -> void:
	get_parent().resume()  # llama al CanvasLayer
