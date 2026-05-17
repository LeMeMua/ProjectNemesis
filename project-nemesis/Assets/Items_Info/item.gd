extends RigidBody3D

@export var item_info: item_data
var subview : SubViewport
@onready var sprite_3d: Sprite3D = $Sprite3D
var direction: Vector3 = Vector3.ZERO
var last_direction: Vector3 = Vector3.ZERO
var hitting: bool
var hit_timer: float = 0.0
var hit_duration: float = 0.3
@onready var collision: CollisionShape3D = $CollisionShape3D

func _ready() -> void:
    subview = get_child(0)
    subview.item_info = item_info
    subview.set_names()
    #body_entered.connect(add_force)

"""func _physics_process(_delta: float):
    if hit_timer>0.0:
        apply_central_force(direction * 20)

func add_force(body: Node) -> void:
    if body.is_in_group("player"):
        print("hay fuerza")
        var diff = global_position - body.global_position
        direction = diff.normalized()
        last_direction = direction
        hit_timer=hit_duration

func delete_force(body:Node)->void:
    if body.is_in_group("player"):
        hitting = false
        print("no hay fuerza")"""



