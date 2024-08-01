extends Sprite2D
@export var health = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_base_health_lost(damage):
	health -= damage
	print(str(health))
	scale -= Vector2(damage/200,0)
	pass # Replace with function body.
