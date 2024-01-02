extends CharacterBody2D


@export var speed = 100
const JUMP_VELOCITY = -300.0
var died = false
var hp = 2#? 2 lyöntiä/päälle hyppyä
var should_jump = true #lippu hyppimiselle, true toistaseks
var suunta
var vektori#move_and_collide, hyppy liike
var hyppää = false# lippu hyppy animaatiolle
@onready var animation_player = $AnimationPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	var x = randf()
	if x > 0.5:
		suunta = "oikea"
	else:
		suunta = "vasen"
	
	play_animation("idle")

func _physics_process(delta):
	if hp == 0:
		dead()
	movement(delta)
	print(velocity)
	
func play_animation(animation):
	if animation:
		animation_player.play(animation)

func dead():
	died = true
	play_animation("dead")

func movement(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if suunta == "oikea":# and should_jump:
		vektori += global_position.x + 3
		vektori += global_position.y + 1
		
		var collision = move_and_collide(vektori * delta * 2)
		if collision:
			print("lumiukko osui johonki")
			#var collateral = collision.get_collider()
			#if collateral is Enemy:
				#collateral.change_health(-player.kick_dmg_returner())
	#velocity.x = speed
	#move_and_slide()



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



