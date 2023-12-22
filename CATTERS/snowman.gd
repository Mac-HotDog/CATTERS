extends CharacterBody2D


const speed = 150.0
const JUMP_VELOCITY = -300.0
var died = false
var hp = 2#? 2 lyöntiä/päälle hyppyä
@onready var animation_player = $AnimationPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if hp == 0:
		dead()
	movement(delta)
	
func play_animation(animation):
	if animation:
		animation_player.play(animation)

func dead():
	died = true
	play_animation("dead")

func movement(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	velocity.x = speed
	move_and_slide()

func turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		print("käänny")


func _on_area_2d_area_entered(area):#pelaajan meleen hitboxi
	#if area.get_parent() 
		#print("lyönti")
	print(area)
	hp = -1



