extends Control

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS  

func _on_salir_button_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(SceneManager.main_menu)

func _on_inicio_button_button_down() -> void:
	get_owner().resume()  # llama al CanvasLayer
