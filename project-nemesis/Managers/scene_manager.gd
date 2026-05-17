extends Node

var main_menu: PackedScene
var main_level: PackedScene
var level2: PackedScene

func _ready() -> void:
    main_menu = load("res://yaisume/CutScene Inicio/AnimacionInicio.tscn")
    main_level = load("res://levels/MainLevel/MainLevel2.tscn")
    level2 = load("res://levels/MainLevel/Level2.tscn")