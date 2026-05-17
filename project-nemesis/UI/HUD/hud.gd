extends CanvasLayer

@onready var health: TextureRect = $Fullsize/health
@onready var objective: Label = $VBoxContainer/Objective
@onready var tiempo: Label = $VBoxContainer/Tiempo

var tween: Tween
var current_health: float
@onready var timer: Timer = $Timer

func _ready() -> void:
    SignalManager.health_changed.connect(update_health_animation)
    SignalManager.nivel_completed.connect(pause_timer)
    SignalManager.begin_level.connect(restart_timer)

func _physics_process(_delta: float) -> void:
    set_time_text()

func update_health_animation() -> void:
    if tween:
        tween.kill()
    
    if GameManager.current_health >= 80:
        health.modulate = Color.WHITE
    else:
        var speed = lerp(0.1, 0.6, GameManager.current_health / 80.0)
        var danger_color = Color("#4646a1", 0.1)  # color oscuro con alpha bajo
        tween = create_tween().set_loops()
        tween.tween_property(health, "modulate", danger_color, speed)
        tween.tween_property(health, "modulate", Color.WHITE, speed)

func start_timer():
    timer.start(60.0)

func pause_timer():
    timer.paused= true

func restart_timer():
    timer.stop()
    timer.start(60.0)

func set_time_text() -> void:
    tiempo.text = "%.2f" % timer.time_left
