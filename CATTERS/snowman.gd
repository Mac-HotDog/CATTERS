extends CharacterBody2D


const speed = 300.0
const JUMP_VELOCITY = -400.0
var hp = 2#? 2 lyöntiä/päälle hyppyä

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	movement(delta)



func movement(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	velocity.x = speed
	move_and_slide()

func turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		print("käänny")


func _on_area_2d_area_entered(area):#pelaajan meleen hitboxi
	print(area)


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print(area)
