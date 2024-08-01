extends Area2D
var timer = 0.25
@export var damage = 100
var upgrades = [0,1,1,0,0,0]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	timer -= delta
	if timer <= 0:
		print("delete")
		get_parent().queue_free()
	
func apply_upgrades(newupgrades):
	upgrades = newupgrades

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		print("lightning" + str(upgrades[2]))
		area.hit(0, upgrades)



func _on_node_2d_applyupgrades(upgrades):
	apply_upgrades(upgrades)
	pass # Replace with function body.
