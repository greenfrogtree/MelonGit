extends Node2D
#body, stripes, outline, shine

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func push(colors):
	$WatermelonBody.material.set_shader_parameter("value", colors[0])
	$WatermelonStripes.material.set_shader_parameter("value", colors[1])
	$WatermelonOutline.material.set_shader_parameter("value", colors[2])
	$WatermelonShine.material.set_shader_parameter("value", colors[3])	
	#print("push received")
	#print($WatermelonBody.material)
	#print(colors)
