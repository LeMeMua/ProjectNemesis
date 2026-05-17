extends Node3D

@onready var animation_player: AnimationPlayer = $Camera3D/AnimationPlayer
@onready var mainmenu: Control = $CanvasLayer/Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	run_cutscene()

func run_cutscene():
	animation_player.play("cutscene")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mainmenu.visible = true
