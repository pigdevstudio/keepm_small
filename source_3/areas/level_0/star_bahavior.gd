extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	randomize()
	get_node("starAnimator").set_speed(rand_range(0.25,2))
