extends Node2D

@onready var mapImage = $Sprite2D
@onready var debug = false

func _ready():
	load_regions()
func _process(delta):
	pass

#IMPORT JSON files and converts to list or dict
func import_file(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file != null:
		return JSON.parse_string(file.get_as_text().replace('_', " "))
	else:
		print('Failed to open file: ', file_path)
		return null 
#LOADS REGIONS AND SET THEIR NAME
func load_regions():
	var image = mapImage.get_texture().get_image()
	var pixel_color_dict = get_pixel_color_dict(image)
	var regions_dict = import_file("res://Map_data/regions.txt")
	
	for region_color in regions_dict:
		var region = load("res://Scenes/Region_Area.tscn").instantiate()
		region.region_name = regions_dict[region_color]
		region.set_name(region_color)
		get_node("Regions").add_child(region)
		
		var polygons = get_polygons(image, region_color, pixel_color_dict)
	
		for polygon in polygons:
			var region_collision = CollisionPolygon2D.new()
			var region_polygon = Polygon2D.new()
			
			region_collision.polygon = polygon
			region_polygon.polygon = polygon
			
			region.add_child(region_collision)
			region.add_child(region_polygon) 
	
	
	if debug == true:
		#print('Regions dict: ' + str(regions_dict))
		#print('Pixel color dict: ' + str(pixel_color_dict))
		pass
#GETS INFORMATIONS ABOUT REGION COLORS	
func get_pixel_color_dict(image):
	var pixel_color_dict = {}
	for y in range(image.get_height()):
		for x in range(image.get_width()):
			var pixel_color = "#" + str(image.get_pixel(int(x), int(y)).to_html(false))
			if pixel_color not in pixel_color_dict:
				pixel_color_dict[pixel_color] = []
			pixel_color_dict[pixel_color].append(Vector2(x, y))
	return pixel_color_dict

func get_polygons(image, region_color, pixel_color_dict):
	var targetImage = Image.create(image.get_size().x, image.get_size().y, false, Image.FORMAT_RGBA8)
	for value in pixel_color_dict[region_color]:
		targetImage.set_pixel(value.x, value.y, "#ffffff")
	
	var bitMap = BitMap.new()
	bitMap.create_from_image_alpha(targetImage)
	var polygons = bitMap.opaque_to_polygons(Rect2(Vector2(0,0), bitMap.get_size()), 0.1)
	return polygons