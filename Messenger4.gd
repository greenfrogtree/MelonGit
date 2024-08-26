extends Node2D
signal mouse(mouse_position, upgrades)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	var rb = $RigidBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func info(location, upgrades, colors):
	print("test")
	emit_signal("mouse", location, upgrades, colors)

