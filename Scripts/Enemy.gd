extends RigidBody2D
@export var health = 500
@export var speed = 10
@export var baseX = 150
@export var attack = 10
@onready var sprite = $Goblin
var chain = preload("res://Chain.tscn")
var popup = preload("res://Damage.tscn")
var dragged
var dragdirection
var dragforce
var attack_cooldown = 1
var grounded = false
var greased = 0
var freezetimer = 0
var stopped = false
var step = false
var burn_timer = 0
var burn_counter = 0
var burn_damage = 0
var slowness = 1
var slowtimer = 0
var weakness = 1
var weaknesstimer =0
@onready var debugtext = $TextEdit.text
var rng = RandomNumberGenerator.new()
var target = null
@export var maxSpeed = 0


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	debugtext = ""
	if stopped == false:
		if linear_velocity.x <= -60:
			sprite.play("Running")
		elif linear_velocity.x >= -10:
			sprite.play("Idle")
	attack_cooldown -= delta
	if target != null and attack_cooldown <= 0 :
		target.get_parent().damage(attack/weakness)
		#print("attack")
		if target.get_parent().health <= 0:
			target = null
		attack_cooldown =1
	if burn_counter >=1:
		burn_timer -= delta
		if burn_timer <= 0:
			burn_counter -=1 
			print("burning")
			damage(burn_damage)
			burn_timer = 0.5
	if slowness > 1:
		slowtimer -=  delta
		if slowtimer <= 0:
			slowness = 1	
	if weakness >1:
		weaknesstimer -= delta
		if weaknesstimer <= 0:
			weakness = 1
		
	if stopped == true:
		freezetimer -= delta
		if freezetimer <= 0:
			stopped = false

	
	#elif global_position.x <= baseX + 1000:
		#apply_force(Vector2.RIGHT *linear_velocity.x*-1)

	#if grounded == true:
		#$TextEdit.text = "grounded"
	if step == true:
		$TextEdit.text = "step"
	if !step:
		$TextEdit.text = ""

func _physics_process(delta):
	step = false
	grounded = false
	if $Ground2.is_colliding():
		var collider = $Ground2.get_collider()
		if collider != null:
			if collider.is_in_group("ground"):
				grounded = true
	if $Step.is_colliding():
		var collider = $Step.get_collider()
		if collider != null:
			if collider.is_in_group("ground"):
				step = true
	if $Step2.is_colliding():
		var collider = $Step2.get_collider()
		if collider != null:
			if collider.is_in_group("ground"):
				step = true
	if grounded == true&& global_position.x >= baseX && linear_velocity.x >= -maxSpeed/slowness && !stopped && greased <=0:
		apply_force(Vector2.LEFT *speed)
		#$TextEdit.text = "moving"

		if step == true:
			apply_force(Vector2.UP*5000)
	elif linear_velocity.x <= -maxSpeed:
		#print("too fast")
		#$TextEdit.text = "too fast"
		apply_force(Vector2.RIGHT * linear_velocity.x*-1)
	
	
func _on_area_2d_damage(value, upgrades):
	pass # Replace with function body.
	damage(value)
	print("Hit:" + str(value))
	if upgrades[4] >= 1:
		print("freeze")
		freeze(upgrades[4])
	if upgrades[2] >=1:
		chainfunction(upgrades)
		damage(upgrades[0])
	if upgrades[1] >= 1:
		print("burned")
		burn_counter = upgrades[1]*10
		burn_damage = upgrades[1]*10
	if upgrades[5] > 1:
		slowness =  upgrades[5]
		slowtimer = upgrades[5]+10
	if upgrades[12] > 1:
		weakness = upgrades[12]
		weaknesstimer = upgrades[12]*10
		


func _on_ground_area_entered(area):
	pass # Replace with function body.
	#print("touch")
	#if area.is_in_group("ground"):
		##print("ground")
		#grounded += 1
	if area.is_in_group("grease"):
		greased +=1
		physics_material_override.friction = 0


func _on_ground_area_exited(area):
	pass # Replace with function body.
	#if area.is_in_group("ground"):
		#grounded -= 1
	if area.is_in_group("grease"):
		greased -=1
		if greased <=0:
			physics_material_override.friction = 0.9


func _on_step_area_entered(area):
	pass # Replace with function body.
	if area.is_in_group("ground"):
		#print("step")
		step = true
	

func _on_step_area_exited(area):
	pass # Replace with function body.
	if area.is_in_group("ground"):
		step = false

func spawnchain(object, position,upgrades):
	var instance = object.instantiate()
	instance.global_position = position
	instance.apply_upgrades(upgrades)
	get_parent().add_child(instance)
	instance.global_scale = Vector2(1+1*upgrades[2]/6, 1+1 *upgrades[2]/6)
func spawn(object, position):
	var instance = object.instantiate()
	instance.global_position = position
	get_parent().addchild(instance)


func freeze(level) -> void:
	stopped = true
	freezetimer= level
	sprite.pause()
func chainfunction(upgrades):
	if upgrades[2] >= 0:
		upgrades[2] = upgrades[2]-1
		spawnchain(chain, position, upgrades)
func damage(hp):
	health -= hp * weakness
	var newpopup = popup.instantiate()
	newpopup.global_position = position+Vector2(rng.randf_range(20,-20),rng.randf_range(20,-20))
	get_parent().add_child(newpopup)
	newpopup.damage(str(hp))
	if health <= 0:
		queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group("wall") and target == null:
		target = area
		#print("wall"+str(target))
		

	pass # Replace with function body.

func _on_area_2d_area_exited(area):
	pass # Replace with function body.
