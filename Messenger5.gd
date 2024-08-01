extends Control
var sprite
var inventoryreference
var refresh_timer = 0
var melonnumber
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	refresh_timer -= delta
	if refresh_timer <= 0:
		refresh_timer = 1
		$Counter.text = "x" + str(inventoryreference.melons[melonnumber][0])
func push(info, number, inventory):
	$Button.push(info, number)
	$Button.set_pressed(false)
	sprite = preload("res://watermelon_sprite.tscn")
	var newsprite = sprite.instantiate()
	add_child(newsprite)
	newsprite.push(info[2])
	inventoryreference = inventory
	melonnumber = number
	#print("Inventory received:")
	#print(inventory)

