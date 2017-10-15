extends Node


func _on_retry_button_up():
	get_tree().change_scene("res://areas/playground/playground.tscn")

func _on_quit_button_up():
	get_tree().quit()
