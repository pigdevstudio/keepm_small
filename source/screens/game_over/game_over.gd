extends Node


func _on_retry_button_up():
	get_tree().change_scene("res://areas/playground/playground.tscn")
	globals.score = 0
	globals.energy = 100


func _on_quit_button_up():
	get_tree().quit()
