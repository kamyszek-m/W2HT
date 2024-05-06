extends Camera2D

#Returns dictionary with sprite resolution {
#'x': width
#'y': height}
func get_sprite_size(path_to_sprite):
	var resolution = {
		'x': path_to_sprite.texture.get_width(),
		'y': path_to_sprite.texture.get_height()
	}
	return resolution
	
func zoom_in():
	var current_zoom = self.zoom
	self.set_zoom(current_zoom * 1.05)

func zoom_out():
	var current_zoom = self.zoom
	self.set_zoom(current_zoom * 0.95)

func move_offset(event):
	var rel_x = event.relative.x
	var rel_y = event.relative.y
	var cam_pos = self.get_offset()
	var current_zoom = self.zoom
	
	cam_pos.x -= rel_x / current_zoom.x
	cam_pos.y -= rel_y / current_zoom.y
	self.set_offset(cam_pos)

func _unhandled_input(event):
	if event is InputEventMouseMotion and event.button_mask > 0:
		self.move_offset(event)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP:
		self.zoom_in()
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		self.zoom_out()

#func _physics_process(delta):
#	var speed = 200
#	var border_thickness = 50
#	var mouse_pos = get_global_mouse_position()
#	var map_size = get_sprite_size($"../Sprite2D")
#
#	if mouse_pos.x < border_thickness:
#		print("Mouse is on the left border of the screen.")
#	elif mouse_pos.x > map_size.x - border_thickness:
#		print("Mouse is on the right border of the screen.")
#
#	if mouse_pos.y < border_thickness:
#		print("Mouse is on the top border of the screen.")
#	elif mouse_pos.y > map_size.y - border_thickness:
#		print("Mouse is on the bottom border of the screen.")	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	pass
