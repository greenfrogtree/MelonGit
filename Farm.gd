extends Node2D
var inventory_spot
var cur_yield
var menu_spawned = false
var mouse = false
@onready var melons = get_parent().melons
var inventorymenu = preload("res://InventoryMenu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	menuspawn(inventorymenu)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	if mouse == true and not menu_spawned:
		if Input.is_action_just_pressed("lmb") :
			menuspawn(inventorymenu)
			menu_spawned = true
	pass # Replace with function body.
	get_parent().connect("inventory_changed",swap)

func swap(first, second):
	if inventory_spot == first:
		inventory_spot = second
		calcyield()
	elif inventory_spot == second:
		inventory_spot = first
		calcyield()
func calcyield():
	#Determine system later
	cur_yield = 10
	$Label/Amount.text = str(cur_yield)+"/rd"
func grow():
	melons[inventory_spot][0] += cur_yield
func selected(number):
	inventory_spot = number
	$Label/Name.text = melons[number][3]
	calcyield()

func _on_area_2d_mouse_entered():
	pass # Replace with function body.
	$Label.visible = true
	mouse = true

func _on_area_2d_mouse_exited():
	pass # Replace with function body.
	$Label.visible = false
	mouse = false
func menuspawn(object):
	print("menu spawned")
	var inventorymenuinstance = object.instantiate()
	inventorymenuinstance.global_position = self.global_position
	print(inventorymenuinstance)
	inventorymenuinstance.origin = self
	get_parent().add_child(inventorymenuinstance)
