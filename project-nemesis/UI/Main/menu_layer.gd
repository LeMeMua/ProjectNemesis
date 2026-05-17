extends CanvasLayer

func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("pause"):
        if get_tree().paused:
            resume()
        else:
            pause()

func pause() -> void:
    get_tree().paused = true
    $PauseMenu.visible = true
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func resume() -> void:
    get_tree().paused = false
    $PauseMenu.visible = false
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)