extends Control






func _on_salir_button_pressed() -> void:
	get_tree().quit()

func _on_inicio_button_pressed() -> void:
	get_tree().change_scene_to_packed(SceneManager.main_level)