extends CanvasLayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(_delta: float) -> void:
	if GameManager.current_health <=0:
		pause()

func pause() -> void:
	get_tree().paused = true
	$GameOver.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
