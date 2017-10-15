extends Node

signal tapped(selected_planet)

func _on_input_handler_tapped( selected_planet ):
	var left = get_tree().get_root().get_node("playground/hand_left")
	var right = get_tree().get_root().get_node("playground/hand_right")
	var s = selected_planet
	if s.get_global_pos().x > OS.get_window_size().x/2:
		right.move_to(s.get_pos())
	else:
		left.move_to(s.get_pos())
