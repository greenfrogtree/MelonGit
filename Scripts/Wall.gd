extends Node2D
var health = 500



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$ProgressBar.value = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func damage(damage):
	health -= damage
	$ProgressBar.value = health
	if health <= 0:
		queue_free()
