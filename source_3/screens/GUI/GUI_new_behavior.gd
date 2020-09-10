extends Control

onready var e = get_node("energy")
onready var s = get_node("score")
func _ready():
	set_process(true)
	
func _process(delta):
	e.set_val(globals.energy)
	s.set_text("Score: " + str(globals.score))
