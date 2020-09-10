extends Node2D
#data
export (float) var min_wait_time
export (float) var max_wait_time

var can_play = true
onready var sprites = get_node("sprites")
onready var animator = get_node("animator")
onready var timer = get_node("timer")
export (int) var score_potential
export (int) var energy_consumption
export (float) var time_needed
var rank = 0

#Input handling
var already_pressed = false
var time_holding = 0
var is_selected = false
var mouse_on = false
func _ready():
	randomize()
	timer.set_wait_time(rand_range(min_wait_time, max_wait_time))
	timer.start()
	set_process(true)
	
func _process(delta):
	select()
	already_pressed = Input.is_action_pressed("tap")
		#only when selected
	if Input.is_action_pressed("tap") and is_selected:
		time_holding += delta
	lower_rank()
#####################################
func _on_timer_timeout():
	randomize()
	if not is_selected:
		if rank < 5:
			rank += 1
			set_rank(rank)
	timer.set_wait_time(rand_range(min_wait_time, max_wait_time))
	timer.start()
#####################################
func _on_area_mouse_enter():
	mouse_on = true
#####################################
func _on_area_mouse_exit():
	mouse_on = false
	is_selected = false
#####################################
func set_rank(rank, grow = true):
	if can_play:
		if rank == 1:
			animator.play("rank_one")
		elif rank == 2:
			animator.play("rank_two")
		elif rank == 3:
			animator.play("rank_three")
		elif rank == 4:
			animator.play("rank_four")
		elif rank == 5:
			print(rank)
			animator.play("rank_five")
		if grow == false:
			animator.play_backwards(animator.get_current_animation())
			globals.score += score_potential * (rank + 1)
			globals.energy += energy_consumption
		else:
			globals.energy -= energy_consumption
	can_play = false
#####################################
func lower_rank():
	if time_holding >= time_needed:
		if rank > 0:
			rank -= 1
			set_rank(rank,false)
			time_holding = 0
			can_play = false
#####################################
func select():
	#condition to select
	if Input.is_action_pressed("tap") and not already_pressed:
		if mouse_on:
			is_selected = true
		else:
			is_selected = false
#	#resets values
	if not Input.is_action_pressed("tap") and already_pressed:
		time_holding = 0
		is_selected = false
#####################################
func _on_animator_finished():
	can_play = true
