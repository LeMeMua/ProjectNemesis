extends Node

var lights: Array[bool] = [false, false, false]

var current_health: float
const MAX_HEALTH: float = 100
var getting_damage : bool = false
var elapsed : float 

func _ready() -> void:
    current_health = MAX_HEALTH

func _physics_process(_delta: float) -> void:
    do_heal_damage(_delta)
    elapsed+=_delta
    if elapsed >1.0:
        print (current_health)
        elapsed = 0

func emit_notifier_screen()->void:
    getting_damage = !getting_damage

func receive_damage(_delta:float)->void:
    if current_health <= 100 and current_health>0:
        current_health-=_delta*16
    elif current_health<=0:
        current_health=0

func healing_damage(_delta: float)->void:
    if current_health>=0 and current_health <100:
        current_health+=_delta*32
    elif current_health>=100:
        current_health = 100

func do_heal_damage(_delta:float)->void:
    if getting_damage:
        receive_damage(_delta)
    elif !getting_damage:
        healing_damage(_delta)