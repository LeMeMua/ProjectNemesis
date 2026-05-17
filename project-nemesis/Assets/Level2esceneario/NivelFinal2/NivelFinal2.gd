extends Node3D


var sombra: bool = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("mirror"):
		sombra = true
		print("Entro sombra")
		SignalManager.nivel_completed.emit()
	


func _on_area_3d_player_entered(body: Node3D) -> void:
	if sombra && body.is_in_group("player"):
		SignalManager.begin_level.emit()
		get_tree().change_scene_to_packed(SceneManager.level2)
