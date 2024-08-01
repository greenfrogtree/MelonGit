extends Node2D
@onready var inventory = get_parent()
@onready var melon = inventory.melons
var button = preload("res://Button2.tscn")
var melon1
var quantity1 = 0
var melon2
var quantity2 = 0
var setting

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

	if Input.is_action_just_pressed('Inventory'):
		print("Inventory open")
		visible = !visible
	elif Input.is_action_just_pressed('menu_quit'):
		visible = false
func spawn(object, position, number):
	inventory = get_parent()
	print("Inventory:"+ str(inventory))
	melon = inventory.melons
	var instance = object.instantiate()
	instance.position = position
	instance.push(melon[number], number, inventory)
	$Inventory/ScrollContainer/GridContainer.add_child(instance)
func selected(number, button):
	print("selected"+str(number))
	if melon1 == null: melon1 = number
	else: melon2 = number
	
func add():
	spawn(button, position,len(melon)-1)
func change(button, value):
	if button == 1:
		$Melon1/RichTextLabel.text = "[center]" + str(value)
		quantity1 += value
		if quantity1 >= melon[melon1][0]:
			quantity1 = melon[melon1][0]
	elif button == 2:
		$Melon2/RichTextLabel.text = "[center]" + str(value)
		quantity2+= value
		if quantity2 >= melon[melon2][0]:
			quantity2 = melon[melon2][0]
func crush():
	var num = min(quantity1, quantity2)
	var array = melon[melon1][1] +melon[melon2][2]
	inventory.synthesize(array, num)
	melon[melon1][0] -= num
	melon[melon2][0] -= num
func blend():
	var num = min(quantity1, quantity2)
	var children1 =[]
	var children2 =[]
	for i in range(len(melon[melon1][1])):
		if melon[melon1][1][i] == 1:
			children1.append(melon.graph[i])
	for i in range(len(melon[melon2][1])):
		if melon[melon2][1][i] == 1:
			children1.append(melon.graph[i])
	for i in range(len(children1)):
		for j in range(len(children1[i])):
			if children1[i][j] in 
	
