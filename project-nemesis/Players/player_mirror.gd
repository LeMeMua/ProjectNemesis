extends CharacterBody3D

class_name PlayerMirror

@export var player: Player
@onready var sub_viewport: SubViewport = $SubViewport
@onready var camera: Camera3D = $SubViewport/Referencia/Camera3D
@onready var referencia: Node3D = $SubViewport/Referencia
@onready var notifier: VisibleOnScreenNotifier3D = $MeshInstance3D/VisibleOnScreenNotifier3D

func _ready() -> void:
	notifier.screen_entered.connect(GameManager.emit_notifier_screen)
	notifier.screen_exited.connect(GameManager.emit_notifier_screen)

func _physics_process(_delta: float) -> void:
	# Posición invertida en X (espejo horizontal)
	velocity = Vector3(-player.velocity.x, player.velocity.y, -player.velocity.z)
	
	# Rotación invertida
	global_rotation = Vector3(player.global_rotation.x, -player.global_rotation.y, player.global_rotation.z)
	referencia.global_position = global_position
	referencia.rotation.y = -player.global_rotation.y 
	move_and_slide()
