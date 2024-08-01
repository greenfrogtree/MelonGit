extends Node2D
var upgrades
var invisible = preload("res://invisibleexplosion.tscn")
var timer = 0.5
var counter
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	print("counter:" +str(counter))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	timer -= delta
	print(str(upgrades[9]))
	if timer <= 0 and upgrades[9] > 0:
		timer = 0.5
		upgrades[9] -= 1
		spawn(invisible, position)
		print("spawned" +str(counter))
	if upgrades[9] <= 0:
		print("delete2")
		queue_free()
		
			
		
	
func apply_upgrades(upgradesnew):
	upgrades = upgradesnew
func spawn(object, position):
	var instance = object.instantiate()
	instance.global_position = position
	instance.apply_upgrades(upgrades)
	get_parent().add_child(instance)
