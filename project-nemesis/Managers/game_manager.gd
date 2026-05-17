extends Node

var lights: Array[bool] = [false, false, false]

var current_health: float = 100.0:
    set(value):
        current_health = clamp(value, 0, 100)
        SignalManager.health_changed.emit()
const MAX_HEALTH: float = 100.0
var getting_damage : bool = false
var elapsed : float 

func _ready() -> void:
    current_health = MAX_HEALTH

func _physics_process(_delta: float) -> void:
    elapsed+=_delta
    if elapsed >1.0:
        print (current_health)
        do_heal_damage()
        elapsed = 0

func emit_notifier_screen()->void:
    getting_damage = !getting_damage

func receive_damage()->void:
    if current_health <= 100 and current_health>0:
        current_health-=15.9
    elif current_health<=0:
        current_health=0

func healing_damage()->void:
    if current_health>=0 and current_health <100:
        current_health+= 10
    elif current_health>=100:
        current_health = 100

func do_heal_damage()->void:
    if getting_damage:
        receive_damage()
    elif !getting_damage:
        healing_damage()