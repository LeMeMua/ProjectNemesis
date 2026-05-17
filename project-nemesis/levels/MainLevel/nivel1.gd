extends Node3D
@onready var puerta: MeshInstance3D = $Puerta
var sombra: bool = false

func _on_area_3d_body_entered(body: Node3D):
    if body.is_in_group("mirror"):
        sombra = true
        print("Entro sombra")
        puerta.mesh = null
        SignalManager.nivel_completed.emit()
    if sombra && body.is_in_group("player"):
        SignalManager.begin_level.emit()
        get_tree().change_scene_to_packed(SceneManager.level2)
        



func _on_area_3d_body_exited(body: Node3D) -> void:
    """if body.is_in_group("player"):
        SignalManager.begin_level.emit()
        print("entro jugador)")"""
