extends Node2D
#building stuff
var building
var buildingchoice = 0
				   #catapult, farm, blender, wall
var current_cost = [50, 25, 100, 25]
@onready var sprites = [$Catapult2, $Farm, $Blender, $Wall]
@onready var buildings = [preload("res://Catapult.tscn"),preload("res://Farm.tscn"),preload("res://blender.tscn"),preload("res://Wall.tscn")]
@onready var current = buildings[0]
@onready var current_sprite =  sprites[0]
@onready var sprite_template = preload("res://watermelon_sprite.tscn")

signal inventory_changed(first, second)
var mouse_in_ui = 0
#inventory
var melons = []
var temp
#each melon has values: amount, upgrades, reference to sprite, name (derived from upgrades), description, 
#upgrades: [0,0,0,0,0,0,0,0,0,0,0,0,0]
# ------------------------graph stuff---------------------#
var graph = [
	
]

#------------------------------------- dictionaries --------------------#
var color_dict ={
	"1": [Vector4(0.458, 0.6549019607843137, 0.2627450980392157, 1),Vector4(0.27450980392156865, 0.5098039215686274, 0.19607843137254902, 1),Vector4(0.1450980392156863, 0.33725490196078434, 0.1803921568627451, 1),Vector4(0.7411764705882353, 0.8627450980392157, 0.2980392156862745, 1)],
	#"0": [Vector4(1,0,0,1), Vector4(1,0,0,1), Vector4(0,1,0,1), Vector4(0,0,1,1)],
	"01": [],
	"00001": [Vector4(0.678, 0.847, 0.902, 1),Vector4(0.941, 0.973, 0.996, 1),Vector4(0.529, 0.808, 0.922, 1),Vector4(1, 1, 1, 1)]
	
}
var text_dict = {
	"1": "Your average melon, delicious, refreshing, and useful as a form of currency or ballistic ammunition",
	"00001":"A cold, icy melon. While certainly refreshing, it holds little value as currency due to its side effects. Freezes enemies on contact."
}
var name_dict = [
 "Water","Fire","Earth","Wind","Ice"
]
	


#-----------------------ready + process---------------#
func _ready():
	pass # Replace with function body.
	#var temp = [100, [0,0,0,0,0,0,0,0,0,0,0,0,0], "#000000", 'Watermelon', "Your average melon, delicious and useful as a form of currency or ballistic ammunition"]
	synthesize([1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],1000)
	temp = [100, [0,0,0,0,0,0,0,0,0,0,0,0,0], "#000000", 'Icemelon', "An icy melon, will freeze enemies on contact"]
	synthesize([0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0],100)
#$Inventory.initialize()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TextEdit2.text = str(mouse_in_ui)
	$TextEdit.text = str(melons[0][0])
	if building:
		# Calculate the position rounded to the nearest 96 units
		var mouse_pos = get_global_mouse_position()
		var rounded_pos = round(mouse_pos / 96) * 96
		#catapult_sprite.global_position = rounded_pos
		current_sprite.global_position = rounded_pos
		if Input.is_action_just_pressed("lmb") and mouse_in_ui <=0:
			spawn(current, rounded_pos)
			print("built" + str(mouse_in_ui))
			melons[0][0] -= current_cost[buildingchoice]

		
	if Input.is_action_just_pressed("Building"):
		if building == true:
			current_sprite.global_position = Vector2(-100,-100)
		building = !building
		$BuildingUi.visible = !$BuildingUi.visible
		
#--------------------------custom functions--------------------#	

func spawn(object, position2):
	var instance = object.instantiate()
	instance.global_position = position2
	add_child(instance)
func add(place, quantity):
	melons[0][0] += quantity
func synthesize(upgrades, quantity):
	var temp= ""
	var temp_array
	var tempname = ""
	var sprite
	for i in upgrades:
		if i == 0:
			temp += str(i)
		if i == 1:
			temp += str(i)
			break;
	for i in range(len(upgrades)):
		if upgrades[i] == 1:
			tempname += name_dict[i]
	if tempname == "":
		tempname = "Water"
	tempname+="melon"
	temp_array = [quantity, upgrades, color_dict[str(temp)], tempname, text_dict[str(temp)]]	
	print(temp)
	melons.append(temp_array)
	$Inventory.add()

	
#---------------------------------Signals------------------------------------#

func _on_catapult_pressed():
	current_sprite.global_position = Vector2(-100,100)
	current_sprite = sprites[0]
	current = buildings[0]
	

func _on_farm_pressed():
	pass # Replace with function body.
	current_sprite.global_position = Vector2(-100,100)
	current_sprite = sprites[1]
	current = buildings[1]

func _on_blender_pressed():
	pass # Replace with function body.
	current_sprite.global_position = Vector2(-100,100)
	current_sprite = sprites[2]
	current = buildings[2]

func _on_wall_pressed():
	pass # Replace with function body.
	current_sprite.global_position = Vector2(-100,100)
	current_sprite = sprites[3]
	current = buildings[3]
	
func _on_area_2d_mouse_entered():
	mouse_in_ui +=1
	print("mouse in ui")
func _on_area_2d_mouse_exited():
	mouse_in_ui -=1
