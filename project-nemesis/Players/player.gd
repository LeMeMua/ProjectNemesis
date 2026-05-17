extends CharacterBody3D
class_name Player

@export var player_mirror: PlayerMirror
@export var espejo_material: StandardMaterial3D

var state_names : StatesNames
@onready var camera_3d: Camera3D = $Head/Camera3D
@onready var head: Node3D = $Head
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var rotation_espejo: Node3D = $Head/RotationEspejo
@onready var linterna: Node3D = $Head/Linterna
@onready var ray_cast_3d: RayCast3D = $Head/Camera3D/RayCast3D
@onready var hand: Node3D = $Head/Hand