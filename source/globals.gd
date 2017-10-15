extends Node

export(Color) var clear_color = Color('000516')

func _ready():
	VisualServer.set_default_clear_color(clear_color)
