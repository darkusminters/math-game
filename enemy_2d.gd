extends Node2D

# Pass 'self' (this specific enemy) when emitting the signal
signal start_math_battle(enemy)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("Player touched the enemy!")

func battle_started(body: Node2D) -> void:
	if body.name == "player":
		print("BATTLE STARTED!")
		get_tree().paused = true
		start_math_battle.emit(self) # Sends this enemy to node_2d.gd
