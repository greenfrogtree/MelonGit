extends Camera2D
var velocity = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("left")&& global_position.x >= 960:
		print("left")
		if velocity <= 3:
			velocity +=2*delta
		global_position += Vector2(-pow(velocity,3),0)
	elif Input.is_action_pressed("right"):
		position += Vector2(pow(velocity,3),0)
		if velocity <= 3:
			velocity+=2*delta
	else:
		velocity = 2
