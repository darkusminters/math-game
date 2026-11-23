extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("Player touched the enemy!")

func battle_started(body: Node2D) -> void:
	if body.name == "player":
		print("BATTLE STARTED!")
		get_tree().paused = true
