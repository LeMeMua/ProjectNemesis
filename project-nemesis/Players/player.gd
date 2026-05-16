extends CharacterBody3D
class_name Player

var state_names : StatesNames
@onready var camera_3d: Camera3D = $Head/Camera3D
@onready var head: Node3D = $Head
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

func start() -> void:
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)