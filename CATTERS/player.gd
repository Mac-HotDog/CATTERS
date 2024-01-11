class_name Player
extends CharacterBody2D



const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var attackarea = $Sprite2D/Area2Dattack/CollisionShape2D
var attacking
var suunta = "oikea"
var timer_called = false #lippu timer funktiolle
var hp = 10

var state_machine
var allow_sit_idle = false #lippu
var jumped #lippu animaatiolle
@onready var anim_tree = $AnimationTree



func _ready():
	attackarea.disabled = true 
	state_machine = anim_tree.get("parameters/playback")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumped = true
		await get_tree().create_timer(0.1).timeout
		jumped = false
	if Input.is_action_just_pressed("attack"):
		attackarea.disabled = false
		attacking = true 
		#print($Sprite2D/Area2Dattack/CollisionShape2D.position)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		allow_sit_idle = false
		velocity.x = direction * SPEED
		if direction == 1:
			suunta = "oikea"
			$Sprite2D.flip_h = false
			attackarea.global_position.x = self.global_position.x + 17
			#print(velocity)
		if direction  == -1:
			suunta = "vasen"
			$Sprite2D.flip_h = true
			attackarea.global_position.x = self.global_position.x - 17
			#print(velocity)
		#print(should_walk_right())
		#print(velocity.x)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if hp <= 0:
		get_tree().change_scene_to_file("res://youLose.tscn")

	#animaation ehdot
	anim_tree.set("parameters/conditions/melee fast",should_attack())
	anim_tree.set("parameters/conditions/kävely",should_walk())
	anim_tree.set("parameters/conditions/seisomis idle",should_stand_idle())
	anim_tree.set("parameters/conditions/istumis idle",should_sit_idle())
	anim_tree.set("parameters/conditions/hyppy",should_jump())
	#print(should_sit_idle())

	move_and_slide()

#animaatioita varten
func should_walk():
	if is_on_floor() and (velocity.x == SPEED or velocity.x == -SPEED):
		#print("walking")
		return true
	else:
		return false

func should_sit_idle():
	if is_on_floor() and velocity == Vector2.ZERO:
		if not timer_called and not allow_sit_idle:
			timer_func("allow_sit_idle")
		if allow_sit_idle:
			return true
	else:
		return false

func should_stand_idle():
	if velocity.x == 0:
		#print("töt")
		return true
	else:
		return false

func should_jump():
	if jumped:
		return true
	else:
		return false

func should_attack():
	if attacking:
		timer_func("attack")
		attacking = false
		return true
	else:
		return false

func bounce():
	pass

func timer_func(x):
	timer_called = true
	if x == "allow_sit_idle":
		await get_tree().create_timer(5).timeout
		allow_sit_idle = true
	if x == "attack":
		await get_tree().create_timer(0.3).timeout
		attackarea.disabled = true 
	timer_called = false


func _on_animation_tree_animation_started(anim_name):
	if anim_name == "jump":
		allow_sit_idle = false

func take_damage(ammount):
	hp = hp - ammount
	$HPbar/Control/hpvalue.value = hp
