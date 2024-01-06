extends CharacterBody2D


@export var speed = 100
const JUMP_VELOCITY = -300.0
var died = false
var hp = 2#? 2 lyöntiä/päälle hyppyä
var should_jump = false #lippu hyppimiselle, true toistaseks
var suunta
var vektori#move_and_collide, hyppy liike
var hyppää = false# lippu hyppy animaatiolle
@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer#hyppytimer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	timer.start()
	var x = randf()
	if x > 0.5:
		suunta = "oikea"
	else:
		suunta = "vasen"
	
	play_animation("idle")

func _physics_process(delta):
	if hp == 0:
		dead()
	if is_on_floor():
		play_animation("idle")
	movement(delta)
	#print(velocity)
	
func play_animation(animation):
	if animation:
		animation_player.play(animation)

func dead():
	died = true
	play_animation("dead")

func movement(delta):
	if is_on_floor():
		velocity.x = 0
	if not is_on_floor():
		velocity.y += gravity * delta
	if suunta == "oikea" and should_jump:
		#vektori = Vector2(global_position.x + 300, global_position.y + 400)
		play_animation("jump")
		velocity.y = JUMP_VELOCITY
		velocity.x = 200
		should_jump = false
		print("hyppy")
	if suunta == "vasen" and should_jump:
		#vektori = Vector2(global_position.x - 300, global_position.y + 400)
		play_animation("jump")
		velocity.y = JUMP_VELOCITY
		velocity.x = -200
		should_jump = false
		print("hyppy")
	
	#velocity = Vector2.ZERO
	move_and_slide()


func turn_around():#ei toimi
	if not $RayCast2D.is_colliding() and is_on_floor():
		if suunta == "vasen":#??
			suunta = "oikea"
		else:
			suunta = "vasen"
		print("käänny")

func should_you_jump():#täältlä should_jump
	pass


func _on_area_2d_area_entered(area):#pelaajan meleen hitboxi
	#if area.get_parent() 
		#print("lyönti")
	print(area)
	hp = -1


func _on_timer_timeout():#timer kutsuu tätä func x määrä sekuntien jälkeen
	if is_on_floor():
		print("timer")
		should_jump = true
		timer.start()

