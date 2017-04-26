extends Node2D

var can_rank = true
var mouse_on = false
var is_selected = false

var tics = 0 setget set_tics
export (int) var needed_tics
var current_rank = 1 setget set_rank

onready var shape = get_node("area/shape").get_shape()
onready var sprites = get_node("sprites")

export (float) var min_wait_time
export (float) var max_wait_time
export (int) var energy_consumption = 7
export (int) var score_potential = 10
var score_multiplier = 1
func _ready():
	randomize()
	var t = get_node("timer")
	t.set_wait_time(rand_range(min_wait_time, max_wait_time))
	t.start()
func set_tics(value):
	tics = value
	if tics >= needed_tics:
		if current_rank > 1:
			set_rank(current_rank - 1)
			tics = 0
		
func set_rank(value):
	if value > current_rank and can_rank:
		increase_rank()
		globals.energy -= energy_consumption
		current_rank = value
		score_multiplier += 1
		tics = 0
	elif value < current_rank and can_rank:
		decrease_rank()
		globals.energy += energy_consumption
		globals.score += score_potential * score_multiplier
		score_multiplier -= 1
		current_rank = value
		tics = 0
func increase_rank():
	can_rank = false
	var t = get_node("tween")
	t.set_active(true)
	t.interpolate_property(shape, "radius", shape.get_radius(),\
	 shape.get_radius() * 1.1, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	t.start()
	t.interpolate_property(sprites, "transform/scale", sprites.get_scale(),\
	 sprites.get_scale() * 1.1, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	get_node("soundeffects").play("grow")
func decrease_rank():
	can_rank = false
	var t = get_node("tween")
	t.set_active(true)
	t.interpolate_property(shape, "radius", shape.get_radius(),\
	 shape.get_radius() * 0.9, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	t.start()
	t.interpolate_property(sprites, "transform/scale", sprites.get_scale(),\
	 sprites.get_scale() * 0.9, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	get_node("soundeffects").play("shrink")
func _on_area_mouse_enter():
	mouse_on = true

func _on_area_mouse_exit():
	mouse_on = false
	is_selected = false
func _on_area_input_event( viewport, event, shape_idx ):
	if event.is_action("tap") and mouse_on:
		input_handler.emit_signal("tapped", self)
		set_tics(tics + 1)
		is_selected = true

func _on_timer_timeout():
	var t = get_node("timer")
	t.set_wait_time(rand_range(min_wait_time, max_wait_time))
	t.start()
	if current_rank < 5:
		set_rank(current_rank + 1)

func _on_tween_tween_complete( object, key ):
	can_rank = true
