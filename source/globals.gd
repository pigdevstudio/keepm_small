extends Node

var score = 0 
var energy = 100 setget set_energy

func set_energy(value):
	if energy < 0:
		get_tree().change_scene("res://screens/game_over/game_over.tscn")
	if energy <= 100:
		energy = value