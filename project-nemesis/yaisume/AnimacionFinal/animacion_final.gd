extends Node3D



@onready var animation_player: AnimationPlayer = $Camera3D/AnimationPlayer


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	run_cutscene()

func run_cutscene():
	animation_player.play("AnimacionFinal")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().quit()
