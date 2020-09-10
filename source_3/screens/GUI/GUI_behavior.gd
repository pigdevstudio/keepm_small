extends Control

onready var score = globals.score setget set_score
onready var energy = globals.energy setget set_energy

func set_score(value):
	score = value
	get_node("score").set_text("Score: " + str(score))
func set_energy(value):
	energy = value
	get_node("energy").set_value(energy)
	if energy < 0:
		get_tree().quit()
	
func _ready():
	get_node("score").set_text("Score: " + str(score))
	get_node("energy").set_value(energy)