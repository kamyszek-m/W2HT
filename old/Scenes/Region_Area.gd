extends Area3D

var region_name = ""
func _on_child_entered_tree(node):
	if node.is_class("Polygon2D"):
		node.color = Color(1, 1, 1, 0.5)
	


func _on_mouse_entered():
	#print(region_name)
	for node in get_children():
		if node.is_class("Polygon2D"):
			node.color = Color(1, 1, 1, 1)


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		print("Clicked: " + str(region_name))
		#shape_idx.color = Color(1, 0, 0, 0.5)




func _on_mouse_exited():
	for node in get_children():
		if node.is_class("Polygon2D"):
			node.color = Color(1, 1, 1, 0.5)
