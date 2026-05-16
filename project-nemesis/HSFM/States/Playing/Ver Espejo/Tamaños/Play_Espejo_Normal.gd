extends StatePlayerPlayingVerEspejos
class_name StatePlayerPlayingVerEspejosNormal

var mov_dir: Vector2 = Vector2.ZERO
var sensitivity : float = 0.2
var speed: float = 5

func handle_input()->void:
	mov_dir = Input.get_vector("left", "right", "back", "forward")
	if Input.is_action_just_pressed("left"):
		print("si entra")

func handle_rotation()->void:
	player.global_rotation.y = player.head.global_rotation.y

func movement(delta: float)->void:
	var direction := (player.global_transform.basis * Vector3(mov_dir.x, 0.0, mov_dir.y)).normalized()
	player.velocity.x = direction.x * speed * delta
	player.velocity.z = direction.z * speed * delta
	

func on_input(event: InputEvent):
	if event is InputEventMouseMotion:
		player.head.rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		player.head.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		player.head.rotation.x = clamp(player.head.rotation.x, deg_to_rad(-89.0), deg_to_rad(89.0))

func on_physics_process(_delta: float)-> void:
	handle_input()
	handle_rotation()
	movement(_delta)
	player.move_and_slide()

