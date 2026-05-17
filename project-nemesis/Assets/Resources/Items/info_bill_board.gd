extends SubViewport

@export var item_info: item_data
@onready var item_name: Label = $CanvasLayer/Panel/HBoxContainer/HBoxContainer/VBoxContainer/ItemName
@onready var description: Label = $CanvasLayer/Panel/HBoxContainer/HBoxContainer/VBoxContainer/Description
@onready var texture_rect: TextureRect = $CanvasLayer/Panel/HBoxContainer/TextureRect
@onready var canvas_layer: CanvasLayer = $CanvasLayer

func set_names():
	item_name.text = item_info.item_name
	description.text = item_info.description
	texture_rect.texture = item_info.item_image

func set_visibility(booleano: bool):
	canvas_layer.visible = booleano
