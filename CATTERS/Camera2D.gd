extends Camera2D

@onready var pelaaja =  $"../CharacterBody2D"

func _physics_process(delta):
	position = pelaaja.position
