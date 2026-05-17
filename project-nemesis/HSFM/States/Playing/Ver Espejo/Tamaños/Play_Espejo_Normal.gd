extends StatePlayerPlayingVerEspejos
class_name StatePlayerPlayingVerEspejosNormal

var mov_dir: Vector2 = Vector2.ZERO
var sensitivity : float = 0.2
const SPEED: float = 5
const JUMPFORCE: float = 10
var jumping: bool

func _ready() -> void:
	super()
	var ver_espejo = get_parent()
	if SignalManager.toggle_viewport_signal.is_connected(ver_espejo.anim_viewport):
		SignalManager.toggle_viewport_signal.disconnect(ver_espejo.anim_viewport)
	SignalManager.toggle_viewport_signal.connect(ver_espejo.anim_viewport)

func handle_input()->void:
	mov_dir = Input.get_vector("left", "right", "forward", "back")
	if Input.is_action_just_pressed("left"):
		print("si entra")

func movement(_delta: float)->void:
	var direction := (player.global_transform.basis * Vector3(mov_dir.x, 0.0, mov_dir.y)).normalized()
	player.velocity.x = direction.x * SPEED
	player.velocity.z = direction.z * SPEED 
	

func on_input(event: InputEvent):
	if event is InputEventMouseMotion:
		player.rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		player.head.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		player.head.rotation.x = clamp(player.head.rotation.x, deg_to_rad(-89.0), deg_to_rad(89.0))

func on_physics_process(_delta: float)-> void:
	handle_input()
	movement(_delta)
	jump()
	#print(player.camera_3d.global_position)
	player.move_and_slide()

func jump():
	jumping = Input.is_action_just_pressed("jump")
	if jumping and player.is_on_floor():
		player.velocity.y = JUMPFORCE


func _exit_tree() -> void:
	var ver_espejo = get_parent()
	if SignalManager.toggle_viewport_signal.is_connected(ver_espejo.anim_viewport):
		SignalManager.toggle_viewport_signal.disconnect(ver_espejo.anim_viewport)




