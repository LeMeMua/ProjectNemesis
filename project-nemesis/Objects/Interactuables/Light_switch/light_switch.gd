extends StaticBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var light:Node3D
# Called when the node enters the scene tree for the first time.


func toggle_switch()-> void:
	if light.visible == false:
		animation_player.play("toggle_switch")
		light.visible = true
		GameManager.lights[0]= true
	elif light.visible == true:
		animation_player.play_backwards("toggle_switch")
		light.visible = false
		GameManager.lights[0]= false

