extends Camera2D

@onready var pelaaja = $"../../Player"

func _physics_process(delta):
	position = pelaaja.position
