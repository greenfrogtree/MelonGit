extends Control
@onready var inventory = get_parent()
@onready var melon = inventory.melons
var origin
var button = preload("res://Button1.tscn")
var mouse
var timer = 0.2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	print("menu spawned" + str(len(melon)))
	for i in range(len(melon)):
		pass
		spawn(button, position,i)
#new, remember to modify

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	timer -=delta
	if Input.is_action_pressed('menu_quit'):
		if mouse:
			get_parent().mouse_in_ui -=1
		queue_free();
	if Input.is_action_pressed("rmb"):
		get_parent().mouse_in_ui -=1
		queue_free();
	if Input.is_action_pressed('lmb')and not mouse and timer <=0:
		queue_free();
		
func spawn(object, position, number):
	inventory = get_parent()
	print("Inventory:"+ str(inventory))
	melon = inventory.melons
	var instance = object.instantiate()
	instance.position = position
	instance.push(melon[number], number, inventory)
	$ScrollContainer/HBoxContainer.add_child(instance)
	


func _on_button_pressed():
	pass # Replace with function body.
	get_parent().mouse_in_ui -=1
	queue_free()



func _on_area_2d_mouse_entered():
	pass # Replace with function body.
	get_parent().mouse_in_ui +=1
	mouse = true

func _on_area_2d_mouse_exited():
	get_parent().mouse_in_ui -=1
	mouse = false
