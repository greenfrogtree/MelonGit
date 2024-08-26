extends Control
@onready var inventory = get_parent()
@onready var melon = inventory.melons
var button = preload("res://Button2.tscn")
var selected_button
var selected_number
var temp1
var temp2
var camera_pos
var opened = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
#func initialize():
	#print("menu spawned" + str(len(melon)))
	#for i in range(len(melon)):
		#pass
		#spawn(button, position,i)

#new, remember to modify

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = camera_pos
	if Input.is_action_just_pressed('Inventory') and !opened:
		print("Inventory open")
		visible = true
		opened = true
		get_parent().mouse_in_ui +=1
	elif Input.is_action_just_pressed('menu_quit') and opened:
		visible = false
		get_parent().mouse_in_ui -=1
		opened = false
	
func spawn(object, position, number):
	inventory = get_parent()
	print("Inventory:"+ str(inventory))
	melon = inventory.melons
	var instance = object.instantiate()
	instance.position = position
	instance.push(melon[number], number, inventory)
	$ScrollContainer/GridContainer.add_child(instance)
func selected(number, button):
	print("selected"+str(number))
	if selected_number != null:
		print("two selected")
		print(str(number)+str(button))
		print(str(selected_number)+str(selected_button))
		if selected_number != number:
			print("swap")
			temp1 = melon[selected_number]

			temp2 = melon[number]
			print(temp2)
			melon[selected_number] = temp2
			melon[number]  = temp1
			get_parent().swap()
			selected_button.get_parent().push(melon[selected_number],selected_number, inventory)
			button.get_parent().push(melon[number], number, inventory)
			selected_number = null
			selected_button = null
	elif selected_number == null:
		print("one selected")
		print(str(number)+str(button))
		selected_number = number
		selected_button = button
func add():
	spawn(button, position,len(melon)-1)
	
