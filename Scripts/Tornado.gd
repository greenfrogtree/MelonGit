extends Node2D
var level
var timer
var force
var targets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	timer -= delta
	if timer <= 0:
		queue_free()
	for n in targets:
		if n != null:
			n.get_parent().apply_central_force(-force*10*(n.global_position-global_position)+Vector2(0, -300))
func apply_upgrades(upgrades):
	timer = upgrades[11]
	force = upgrades[11]/10


func _on_area_2d_area_entered(area):
	if(area.get_parent().name == "RigidBody2D" and area.is_in_group("enemy")):
		targets.append(area)
		area.get_parent().freeze(timer)
	pass # Replace with function body.
func pull_in(object):
	while(object.global_position != self.global_position):
		object.get_parent().linear_velocity = -force*(object.global_position-global_position)
