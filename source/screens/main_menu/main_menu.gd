extends Control


func _on_main_menu_button_up():
	get_tree().change_scene("res://areas/playground/playground.tscn")

func _on_quit_button_up():
	get_tree().quit()

func _on_credits_button_up():
	get_tree().change_scene("res://screens/credits/credits.tscn")
