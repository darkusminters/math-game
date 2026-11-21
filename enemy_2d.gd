extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	# Check if the body entering the area is your player
	print("Something touched Area2D: ", body.name)
	if body.is_in_group("player"):
		print("Player touched the enemy!")
		get_tree().paused = true
		
		# Example: Change to your math battle scene
		# get_tree().change_scene_to_file("res://battle_scene.tscn")


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.


func battle_started(body: Node2D) -> void:
	pass # Replace with function body.
