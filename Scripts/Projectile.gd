extends RigidBody2D
var direction_x
var direction_y
var mouse_position
var total_velocity
var current_velocity
var enemy_found = false
var enemy_direction
var enemy_position
#               0,1,2,3,4,5,6,7,8,9,0,1,2,3
var upgrades = [0,0,0,0,0,0,0,0,0,0,0,0,0]
 # damage, freezing, lightning, exploding, poison, slowness, guided, hardness, piercing, cloud, grease, implosion, weakness
 # damage, fire, wind, water, earth, explosion,   
var maxX = 850
var boom = preload("res://explosion.tscn")
var cloud = preload("res://Cloud.tscn")
var grease = preload("res://Grease.tscn")
var tornado = preload("res://Tornado.tscn")
var location = Vector2(0,0)
var Catapult_location = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	if upgrades[8] >= 1:
		set_collision_mask_value(1, false)
		print("collision"+str(collision_layer))
	print(mouse_position)
	self.apply_torque(10000)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	
func _physics_process(delta):
	pass
func collision(target):
	if target.is_in_group("enemy") or target.is_in_group("ground"):
		location = Vector2(0,0)
		if upgrades[3] > 0:
			spawn(boom, global_position - Catapult_location)
		total_velocity = int(sqrt((linear_velocity.x ** 2)+(linear_velocity.y ** 2))/10)
		#print("hit" + str(total_velocity)+ " (" + str(linear_velocity.x) + ","+ str(linear_velocity.y))
		if target.is_in_group("enemy"):
			target.hit(total_velocity, upgrades)
			if upgrades[8] >=1:
				upgrades[8]-=1
				return null
		if upgrades[7] < 1:
			if upgrades[9] >= 1:
				spawn(cloud, position)
			if upgrades[10] >=1:
				spawn(grease, position + Vector2(0, 50))
			if upgrades[11] >=1:
				spawn(tornado, position)
			
			visible = false
			get_parent().get_parent().gravity_scale = 0
			global_position = Vector2(0,0)
		
			
		else:
			upgrades[7] -= 1
		print("explode")
func _on_area_2d_area_entered(area):
	pass # Replace with function body.
	collision(area)


func _on_damage_box_body_entered(body):
	pass # Replace with function body.
	collision(body)

func spawn(object, position):
	var instance = object.instantiate()
	instance.global_position = position
	instance.apply_upgrades(upgrades)
	get_parent().add_child(instance)


func _on_guided_area_entered(area):
	if upgrades[6] >= 1:
		if area.is_in_group("enemy") and global_position.x >= 400:
			if enemy_found == false:
				enemy_found = true
				current_velocity = linear_velocity
				enemy_direction = global_position - area.global_position
				enemy_position = area.global_position
				print("enemy found"+ str(area.global_position))
				gravity_scale = 1
				linear_velocity = current_velocity.lerp(enemy_direction *-upgrades[6], 0.4)



func _on_node_2d_mouse(mouse_position, upgradesnew, colors):
	pass # Replace with function body.
	Catapult_location = global_position
	upgrades = upgradesnew
	$WatermelonSprite/WatermelonBody.material.set_shader_parameter("value", colors[0])
	$WatermelonSprite/WatermelonStripes.material.set_shader_parameter("value", colors[1])
	$WatermelonSprite/WatermelonShine.material.set_shader_parameter("value", colors[3])	
	print(upgrades)
	print("mouse:" + str(mouse_position))
	print("catapult:" + str(Catapult_location))
	direction_y = min(mouse_position.y - Catapult_location.y,0)
	direction_y *= 3
	direction_x = max(min(maxX,mouse_position.x - Catapult_location.x),0)
	print(Vector2(direction_x, direction_y))
	#print(str(direction_x) + " " + str(direction_y))
	#print(Vector2(direction_x,direction_y))
	apply_impulse(Vector2(direction_x, direction_y), Vector2(0,0))

