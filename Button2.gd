extends Button
var areaentered = false
@onready var inventorylogic = get_parent().get_parent().get_parent().get_parent()
var info
var number
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		

func push(newinfo, newnumber):
	info = newinfo

	#get_parent().modulate = hex_to_color((info[2]))
	number = newnumber
	$Label.info(info[3],info[4])


func hex_to_color(hex: String) -> Color:
	# Remove the '#' character if it exists
	if hex.begins_with("#"):
		hex = hex.substr(1, hex.length())
	
	# Parse the hex string into RGB components
	var r = int("0x" + hex.substr(0, 2)) / 255.0
	var g = int("0x" + hex.substr(2, 2)) / 255.0
	var b = int("0x" + hex.substr(4, 2)) / 255.0
	
	# Create and return the Color object
	return Color(r, g, b)


	


func _on_pressed():
	pass # Replace with function body.
	inventorylogic.selected(number,self)
	#print("selected:" + str(number))
