extends Node2D

onready var t = get_node("tween")
onready var initial_pos = get_pos()
var can_squeeze = false

func back():
	t.interpolate_property(self, "transform/pos", get_pos(), can_squeeze, 0.2, Tween.TRANS_LINEAR,\
	Tween.EASE_IN)
	t.start()
	can_squeeze = false
func move_to( pos ):
	t.interpolate_property(self, "transform/pos", get_pos(), pos, 0.2, Tween.TRANS_LINEAR,\
	Tween.EASE_IN)
	t.start()
	can_squeeze = false

func _on_tween_tween_complete( object, key ):
	can_squeeze = true
	get_node("animator").play("squeeze")

func _on_animator_finished():
	if get_node("animator").get_current_animation() != "idle":
		get_node("animator").play("idle")
