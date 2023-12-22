extends CharacterBody2D


const speed = 300.0
const JUMP_VELOCITY = -400.0
var hp = 4#? 2 lyöntiä/päälle hyppyä

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	movement(delta)
	if hp <= 0:
		queue_free()


func movement(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	velocity.x = speed
	move_and_slide()

func turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		print("käänny")




func _on_area_2d_area_entered(area):
	print(area.get_groups()[0])
	if area.get_groups()[0] == "nyrkki":
		hp = hp -2
		$HPbar/Control/hpvalue.value = hp
