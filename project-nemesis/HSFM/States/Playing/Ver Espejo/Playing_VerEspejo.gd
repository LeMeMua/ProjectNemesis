extends StatePlayerPlaying
class_name StatePlayerPlayingVerEspejos

var viewport_texture: ViewportTexture
var viewing_mirror: bool = false
var hiding : bool = false
var flashlight_power : bool = false
var view_animation: float = 3.0
var elapsed: float
var timer: SceneTreeTimer
var tween: Tween

func _ready() -> void:
	tween = create_tween()
	tween.stop()
	if player.player_mirror:
		viewport_texture = player.player_mirror.sub_viewport.get_texture()
		player.espejo_material.albedo_texture = viewport_texture


func on_physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_mirror"):
		toggle_viewport()
	if Input.is_action_just_pressed("flashlight"):
		toggle_flashlight()
	if Input.is_action_just_pressed("Interact"):
		interact()

func anim_viewport() -> void:
	#print("anim_viewport en: ", name, " viewing_mirror es: ", viewing_mirror)
	if player.player_mirror:
		hiding = false
		if viewing_mirror:
			kill_tween()
			player.rotation_espejo.visible = true
			tween.tween_property(player.rotation_espejo, "rotation:x", deg_to_rad(0), 2.0)
			
			"""timer = get_tree().create_timer(view_animation)
			var t = 1.0 - (timer.time_left / view_animation)
			var rotation = lerp_angle(deg_to_rad(-45), deg_to_rad(0), t)
			player.rotation_espejo.rotation.x = rotation"""
		elif !viewing_mirror:
			kill_tween()
			hiding = true
			tween.tween_property(player.rotation_espejo, "rotation:x", deg_to_rad(-60), 2.0)
			tween.finished.connect(make_invisible, CONNECT_ONE_SHOT)
			"""timer = get_tree().create_timer(view_animation)
			var t = 1.0 - (timer.time_left / view_animation)
			var rotation = lerp_angle(deg_to_rad(0), deg_to_rad(-45), t)
			player.rotation_espejo.rotation.x = rotation"""

func toggle_viewport() -> void:
	viewing_mirror = !viewing_mirror
	timer = null
	SignalManager.toggle_viewport_signal.emit()

func toggle_flashlight() ->void:
	flashlight_power = !flashlight_power
	if flashlight_power:
		player.linterna.visible = true
	elif !flashlight_power:
		player.linterna.visible = false

func interact()-> void:
	if player.ray_cast_3d.is_colliding():
		var hit= player.ray_cast_3d.get_collider()
		if hit.is_in_group("light"):
			hit.toggle_switch()

func kill_tween()->void:
	if tween:
		tween.kill()
	tween=create_tween()

func make_invisible()->void:
	if hiding:
		player.rotation_espejo.visible=false
