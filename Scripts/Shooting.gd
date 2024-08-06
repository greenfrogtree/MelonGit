extends Node2D

# Initialize variables
var mouse_position = Vector2()
var direction = Vector2()
var upgrades = [0,2,0,0,0,0,0,0,0,0,0,0,0] # damage, freezing, lightning, exploding, poison, slowness, guided, hardness, piercing, cloud, grease, implosion, weakness 
var watermelon = preload("res://Watermelon.tscn")
var saved_angle = Vector2()
var mode = "standby"
var mouse = false
var timer = 1.0
var auto_time = 1.0
var current_melon = 0
var inventorymenu = preload("res://InventoryMenu.tscn")
var inventorymenuinstance
var object_pool =[]
var tempinstance

# Get references to scene nodes
@onready var sprite = $Catapult
@onready var building = get_parent()
@onready var inventory = building

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Initial setup can be done here
	for i in range(10):
		spawn(watermelon, Vector2(0,0))
	print("object pool prepared")	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta  # Decrement timer by delta

	# Handle Building Input
	if Input.is_action_just_pressed("Building") and mode == "selected":
		mode = "standby"  # Switch to standby mode if building input is detected
	# Handle different modes
	match mode:
		"standby":
			handle_standby_mode()
		"selected":
			handle_selected_mode(delta)
		"armed":
			handle_armed_mode(delta)
	#print($Circle.global_position)

# Handle the standby mode logic
func handle_standby_mode():
	if mouse:
		if Input.is_action_just_released("lmb") and timer <= 0 and not building.building and building.mouse_in_ui <=1:
			mode = "selected"
			menuspawn(inventorymenu)
			show_arc(true)  # Show the arc when transitioning to selected mode
			#print("Switched to selected mode and showing arc")

# Handle the selected mode logic
func handle_selected_mode(delta):
	if not building.building:
		show_arc(true)  # Ensure arc is shown in selected mode
		#print("In selected mode and showing arc")
		if Input.is_action_just_pressed("Building"):
			mode = "standby"
			show_arc(false)  # Hide arc when switching to standby mode
			print("Switched to standby mode and hiding arc")
			
			
		
		if timer <= 0 and sprite.frame <= round(min((get_global_mouse_position() - global_position).length() / 200, 3)):
			sprite.frame +=1
			timer = 0.2  # Reset the timer
		
		if mouse:
			if Input.is_action_just_released("lmb"):
				mode = "standby"
				show_arc(false)  # Hide arc and reset sprite frame when switching to standby mode
				print("Switched to standby mode and hiding arc after release")
				sprite.frame = 0
		if Input.is_action_just_released("lmb")and building.mouse_in_ui< 1:
			print(min((get_global_mouse_position() - global_position).length() / 200, 3))
			if sprite.frame >= min((get_global_mouse_position() - global_position).length() / 200, 3) and building.melons[current_melon][0]>=1:
				sprite.frame = 0
				
				saved_angle = get_global_mouse_position()
				tempinstance = object_pool.pop_front()
				activate(tempinstance, global_position)  # Spawn watermelon at the current position
				object_pool.append(tempinstance)
		if Input.is_action_just_pressed("rmb")and building.mouse_in_ui<1:
			mode = "armed"
			saved_angle = get_global_mouse_position()
			show_arc(false)  # Hide arc when switching to armed mode
			print("Switched to armed mode and hiding arc")

# Handle the armed mode logic
func handle_armed_mode(delta):
	if timer <= 0 and building.melons[current_melon][0]>=1:
		timer = auto_time
		tempinstance = object_pool.pop_front()
		activate(tempinstance, global_position)  # Spawn watermelon at the current position
		object_pool.append(tempinstance)  # Spawn watermelon periodically in armed mode
		sprite.frame = 0
	else:
		update_sprite_frame(timer)  # Update the sprite frame based on the timer
	
	if mouse:
		if Input.is_action_just_released("lmb"):
			mode = "selected"
			show_arc(true)  # Show arc when switching back to selected mode
			print("Switched to selected mode and showing arc")

# Update the sprite frame based on the remaining timer
func update_sprite_frame(timer):
	if timer <= 0.25:
		sprite.frame = 3
	elif timer <= 0.5:
		sprite.frame = 2
	elif timer <= 0.75:
		sprite.frame = 1

# Spawn a new object at the specified position
func spawn(object, position):
	var instance = object.instantiate()
	instance.position = Vector2(0,0)
	instance.rb.gravity_scale = 0
	instance.visible = false
	object_pool.append(instance)
	print(building.melons[current_melon][1])
	get_parent().add_child(instance)
func activate(object, position):
	object.position = position
	object.info(saved_angle,building.melons[current_melon][1], building.melons[current_melon][2]) 	  # Pass angle and upgrades to the instance
	building.melons[current_melon][0] -=1
# Show or hide the arc based on the 'on' parameter
func show_arc(on):
	$Circle.visible = on
	$Circle2.visible = on
	$Circle3.visible = on
	$Circle4.visible = on
	$Circle5.visible = on
	$Circle6.visible = on
	#print("Arc visibility set to: ", on)

# Mouse entered event handler
func _on_area_2d_mouse_entered():
	mouse = true
	#print("Mouse entered")

# Mouse exited event handler
func _on_area_2d_mouse_exited():
	mouse = false
	print("Mouse exited")
func selected(num):
	current_melon = num		
	print("Received selection"+ str(num))
	
func menuspawn(object):
	print("menu spawned")
	var inventorymenuinstance = object.instantiate()
	inventorymenuinstance.global_position = self.global_position
	print(inventorymenuinstance)
	inventorymenuinstance.origin = self
	get_parent().add_child(inventorymenuinstance)
	
