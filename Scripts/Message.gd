extends Node2D
signal upgrades(upgrades)
var upgrades2 = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func apply_upgrades(newupgrades):
	upgrades2 = newupgrades
	emit_signal("upgrades", upgrades2)
	
