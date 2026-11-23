extends Node2D

var player: Node2D

# Pass 'self' (this specific enemy) when emitting the signal
signal start_math_battle(enemy)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("Player touched the enemy!")
		player = body
		player.can_move = false
		
func battle_started(body: Node2D) -> void:
	if body.name == "player":
		print("BATTLE STARTED!")
		player = body
		player.can_move = false
		start_math_battle.emit(self) # Sends this enemy to node_2d.gd
		
func end_encounter() -> void:
	player.can_move = true
