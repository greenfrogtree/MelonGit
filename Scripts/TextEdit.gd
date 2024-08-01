extends RichTextLabel
var timer = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	timer -= get_process_delta_time()
	if timer <= 0:
		get_parent().queue_free()


func _on_node_2d_damage_2(hp):
	text = hp
	pass # Replace with function body.


func _on_control_damage_2(hp):
	text = hp
	pass # Replace with function body.
