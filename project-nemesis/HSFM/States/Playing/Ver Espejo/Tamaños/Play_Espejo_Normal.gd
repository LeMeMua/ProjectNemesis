extends StatePlayerPlayingVerEspejos
class_name StatePlayerPlayingVerEspejosNormal

var mov_dir: Vector2 = Vector2.ZERO
var look_dir: Vector2 = Vector2.ZERO
var sensitivity : float = 0.2
var sens_control : float = 2.0
const SPEED: float = 5
const JUMPFORCE: float = 10
var jumping: bool
var ver_espejo: Node


func _ready() -> void:
	super()
	ver_espejo = get_parent()
	if SignalManager.toggle_viewport_signal.is_connected(ver_espejo.anim_viewport):
		SignalManager.toggle_viewport_signal.disconnect(ver_espejo.anim_viewport)
	SignalManager.toggle_viewport_signal.connect(ver_espejo.anim_viewport)

func handle_input()->void:
	mov_dir = Input.get_vector("left", "right", "forward", "back")
	look_dir = Input.get_vector("mouse_left", "mouse_right", "mouse_up", "mouse_down")
	#if Input.is_action_just_pressed("left"):
		#print("si entra")

func movement(_delta: float)->void:
	var direction := (player.global_transform.basis * Vector3(mov_dir.x, 0.0, mov_dir.y)).normalized()
	player.velocity.x = direction.x * SPEED
	player.velocity.z = direction.z * SPEED 

func rotate_control(_delta:float):
	player.rotate_y(deg_to_rad(-look_dir.x * sens_control))
	player.head.rotate_x(deg_to_rad(-look_dir.y * sens_control))
	player.head.rotation.x = clamp(player.head.rotation.x, deg_to_rad(-89.0), deg_to_rad(89.0))

func on_input(event: InputEvent):
	if event is InputEventMouseMotion:
		player.rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		player.head.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		player.head.rotation.x = clamp(player.head.rotation.x, deg_to_rad(-89.0), deg_to_rad(89.0))

func on_physics_process(_delta: float)-> void:
	handle_input()
	movement(_delta)
	rotate_control(_delta)
	jump()

	if ver_espejo.grabbing:
		grab_objects()
	#print(player.camera_3d.global_position)
	player.move_and_slide()

	for i in player.get_slide_collision_count():
		var c = player.get_slide_collision(i)
		var collider = c.get_collider()          
		if collider is RigidBody3D:
			var push_dir = -c.get_normal()       
			collider.apply_central_impulse(push_dir * 1.0)

func jump():
	jumping = Input.is_action_just_pressed("jump")
	if jumping and player.is_on_floor():
		player.velocity.y = JUMPFORCE


func grab_objects():
	ver_espejo.grabbed_object.sprite_3d.visible = false
	ver_espejo.grabbed_object.global_position = player.hand.global_position
	


func _exit_tree() -> void:
	ver_espejo = get_parent()
	if SignalManager.toggle_viewport_signal.is_connected(ver_espejo.anim_viewport):
		SignalManager.toggle_viewport_signal.disconnect(ver_espejo.anim_viewport)
