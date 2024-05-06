extends Sprite3D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.texture = load("res://Levels/1. In-Game/Map/region_map.png")

func load_regions():
	var image = self.get_texture().get_image()
	var pixel_color_dict = get_pixel_color_dict(image)
	
func get_pixel_color_dict(image):
	var pixel_color_dict = {}
	for y in range(image.get_height()):
		for x in range(image.get_width()):
			
