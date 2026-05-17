extends CanvasLayer


var material: ShaderMaterial
var circle_size : float 
var elapsed: float
var circle_size_bef : float = 1.0
var current_size : float 
@onready var shader_circle: ColorRect = $ShaderCircle

func _physics_process(_delta:float)->void:
	material = shader_circle.material as ShaderMaterial
	current_size = lerpf(circle_size_bef, set_circle_size(), _delta * 3)
	material.set_shader_parameter("circleSize", current_size)
	circle_size_bef = current_size

func set_circle_size() -> float :
	var t = clampf(GameManager.current_health/(GameManager.MAX_HEALTH-30), 0, 1)
	circle_size = lerpf(0.5, 1.0, t)
	return circle_size
