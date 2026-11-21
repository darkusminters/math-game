extends Node2D
# Called when the node enters the scene tree for the first time.
func battle_started(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("BATTLE STARTED!")
		get_tree().paused = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
