extends Node

onready var gui = get_node("GUI_new")
var score = 0
var energy = 100

func _ready():
	for planet in get_tree().get_nodes_in_group('planet'):
		planet.connect('energy_update', self, '_planet_energy_update')
		planet.connect('score_update', self, '_planet_score_update')
		planet.connect('selected', self, '_planet_selected')

func _planet_energy_update(d_energy):
	energy += d_energy
	energy = min(100, energy)
	if energy <= 0:
		get_tree().change_scene("res://screens/game_over/game_over.tscn")
	gui.get_node("energy").set_val(energy)

func _planet_score_update(d_score):
	score += d_score
	gui.get_node("score").set_text("Score: %s" % score)

func _planet_selected(planet_pos):
	if planet_pos.x > OS.get_window_size().x/2:
		get_node("hand_right").move_to(planet_pos)
	else:
		get_node("hand_left").move_to(planet_pos)
