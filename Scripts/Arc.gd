extends Sprite2D
@export var order = 0
var mouse_position = Vector2()
var Catapult_location = Vector2()
var temp_position = 0.0
var max_distance = 800
var force = Vector2()
var velocity = 0.0
var angle = 0.0
var maxX = 850
@onready var catapult = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	#print(get_parent().global_position)
	Catapult_location = get_parent().global_position

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if catapult.mode == "selected":
		visible = true
	else:
		visible = false
	mouse_position = get_global_mouse_position()
	force.y = min(0,(mouse_position.y - Catapult_location.y) * 3)
	#print("force.y" + str(force.y))
	force.x = abs(max(min(maxX, mouse_position.x - Catapult_location.x),0))
	velocity = 0.055*sqrt(pow(force.y,2) + pow(force.x, 2))
	angle = atan2(force.y,force.x)
	if cos(angle) == 0:
		print("cos issue")
		angle+=0.2
	if velocity == 0:
		#print("velocity issue")
		velocity +=0.1


	if Input.is_action_just_pressed("lmb"):
		pass
		#print(angle)
		#print(force)
		#print(position)
	#trajectory: y = x tan θ − gx2/2v2 cos2 θ

	position.y = ((position.x) * tan(angle) + (9.8*pow(position.x, 2))/(2*pow(velocity,2)*pow(cos(angle),2)))

	#position.y = (-9.8*pow(position.x/100,2) + 1*(position.x))*-1
	
	global_position.x = min(Catapult_location.x + (order*0.166)* (mouse_position.x - Catapult_location.x), Catapult_location.x + (order*0.166) * max_distance)
	if position.x <= 0:
		position.y = -position.y
		position.x = 0
