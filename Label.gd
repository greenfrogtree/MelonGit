extends Control
var name1
var description

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func info(name1,description):
	$Name2.text = name1
	$Description2.text = description

func _on_button_mouse_entered():
	$Description2.visible = true
	$Name2.visible = true
func _on_button_mouse_exited():
	$Description2.visible = false
	$Name2.visible = false
	pass # Replace with function body.
	
