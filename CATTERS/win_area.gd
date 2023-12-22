extends MeshInstance2D
#var scene = load("res://winScene.tscn")

func _on_area_2d_body_entered(body):
	print("test")
	get_tree().change_scene_to_file("res://winScene.tscn")
