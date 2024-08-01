extends Node2D
var enemy = preload("res://Enemy.tscn")
var round = 10
var timer1 = 1
var enemies = 0
var location = Vector2(global_position.x, global_position.y)
var enemies_left = 0

#enemy loadout array, first number is total
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn(enemy, Vector2(global_position.x, global_position.y))
	pass # Replace with function body.
	#print(str(global_position.x) + "," + str(global_position.y))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	timer1-=delta
	

	if timer1<= 0 && enemies < round:

		spawn(enemy, location)
		timer1 = 1
		enemies +=1
		#print("enemy spawned" + str(enemies))
	if enemies == round:
		enemies = 0
		#print("new round")
		round +=1
		timer1 = 10
	
func spawn(object, position):
	var instance = object.instantiate()
	instance.global_position = position
	add_child(instance)
func swap():
	pass
	#play sky animation
	#update info
