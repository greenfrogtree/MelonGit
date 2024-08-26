extends Area2D
var timer = 0.25
@export var damage = 100
var upgrades = []
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
		
	
func apply_fupgrades(newupgrades):
	upgrades = newupgrades

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		print("explosion damaage")
		area.hit(upgrades[5]/2, upgrades)
	pass # Replace with function body.


func _on_explosion_upgrades(upgrades2):
	pass # Replace with function body.
	upgrades = upgrades2
	


func _on_node_2d_upgrades(upgrades):
	pass # Replace with function body.
