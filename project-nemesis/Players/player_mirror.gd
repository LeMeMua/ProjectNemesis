"""extends CharacterBody3D

class_name PlayerMirror

@export var player: Player
@onready var sub_viewport: SubViewport = $SubViewport
@onready var camera: Camera3D = $SubViewport/Referencia/Camera3D
@onready var referencia: Node3D = $SubViewport/Referencia
@onready var notifier: VisibleOnScreenNotifier3D = $MeshInstance3D/VisibleOnScreenNotifier3D
@onready var light: OmniLight3D = $OmniLight3D

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
"""

extends CharacterBody3D
class_name PlayerMirror

@export var player: Player
@onready var sub_viewport: SubViewport = $SubViewport
@onready var camera: Camera3D = $SubViewport/Referencia/Camera3D
@onready var referencia: Node3D = $SubViewport/Referencia
@onready var notifier: VisibleOnScreenNotifier3D = $MeshInstance3D/VisibleOnScreenNotifier3D
@onready var light: OmniLight3D = $OmniLight3D

const SPEED: float = 5.0
const JUMPFORCE: float = 10.0
var level_completed : bool = false

func _ready() -> void:
	notifier.screen_entered.connect(GameManager.emit_notifier_screen)
	notifier.screen_exited.connect(GameManager.emit_notifier_screen)
	SignalManager.nivel_completed.connect(set_visibility_off)
	SignalManager.begin_level.connect(set_visibility_on)

func _physics_process(_delta: float) -> void:
	if !level_completed:
		var mov_dir = Input.get_vector("left", "right", "forward", "back")
		
		var direction = (global_transform.basis * Vector3(-mov_dir.x, 0.0, -mov_dir.y)).normalized()
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

		global_position.y = player.global_position.y
		velocity.y = player.velocity.y

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMPFORCE

		global_rotation = Vector3(player.global_rotation.x, -player.global_rotation.y, player.global_rotation.z)
		referencia.global_position = global_position
		referencia.rotation.y = -player.global_rotation.y

		move_and_slide()

func set_visibility_off():
	visible=false

func set_visibility_on():
	visible=false
	change_input()
	freeze_player()

func change_input():
	level_completed = true

func freeze_player() -> void:
	set_physics_process(false)
	velocity = Vector3.ZERO
