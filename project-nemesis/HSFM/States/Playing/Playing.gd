extends StateBasePlayer

class_name StatePlayerPlaying
var gravity: float = 9.81
func on_physics_process(delta: float)-> void:
    if not player.is_on_floor():
        player.velocity.y -= gravity * delta
    else:
        player.velocity.y = 0.0


