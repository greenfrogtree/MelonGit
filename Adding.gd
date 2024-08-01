extends TextureButton
@export var value = 0
@export var button = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	pass # Replace with function body.
	get_parent().get_parent().change(button, value)
	
