extends TextureProgress

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	
func _process(delta):
	set_hidden(!get_parent().is_selected)
	if get_parent().can_rank:
		set_max(get_parent().needed_tics)
		set_value(get_parent().tics)
