extends Node2D

var min = 0
var max = 4672
var vihu = preload("res://snowman.tscn")

var vihu2


func _on_timer_timeout():
	var random_float_range = randf() * (max - min) + min
	#print(random_float_range)
	top_level = true
	vihu2 = vihu.instantiate()
	vihu2.transform.origin = Vector2(random_float_range, 0)
	add_child(vihu2)
