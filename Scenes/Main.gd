extends Node2D
func _ready():
	get_node("Sprite2D").load_regions()
	get_node("Camera2D")
