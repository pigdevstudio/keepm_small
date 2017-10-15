extends Sprite

func _ready():
	get_node("starAnimator").set_speed(rand_range(0.25,2))
