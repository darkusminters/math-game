extends Node2D

@onready var player: CharacterBody2D = $player
@onready var camera: Camera2D = $player/Camera2D
@onready var math_window: Window = $Popup/Window

var current_enemy: Node2D = null
var original_zoom: Vector2
var battle_zoom: Vector2

func _ready() -> void:
	# 1. Force the math window to hide immediately when the game starts
	math_window.hide()
	
	# 2. Automatically remember whatever zoom you set in the Inspector
	original_zoom = camera.zoom
	# Zoom in 1.4x closer than your original zoom (tweak 1.4 if you want more/less zoom)
	battle_zoom = original_zoom * 1.4
	
	math_window.math_solved.connect(_on_math_solved)

# BATTLE START -> CENTER & ZOOM -> POPUP
func _on_enemy_2d_start_math_battle(enemy: Node2D) -> void:
	current_enemy = enemy
	player.can_move = true
	# Turn off camera drag so it doesn't fight our centering animation
	camera.drag_horizontal_enabled = false
	camera.drag_vertical_enabled = false
	# Find the exact middle point between the player and the enemy
	var midpoint: Vector2 = (player.global_position + enemy.global_position) / 2.0
	
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	# set_parallel(true) makes the zoom AND the centering move happen at the exact same time!
	tween.set_parallel(true)
	tween.tween_property(camera, "zoom", battle_zoom, 0.5)
	tween.tween_property(camera, "global_position", midpoint, 0.5)
	
	await tween.finished
	math_window.popup_centered()

# ANSWERED -> RESET CAMERA -> ENEMY DIES
func _on_math_solved() -> void:
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_parallel(true)
	# Zoom back out to your original zoom
	tween.tween_property(camera, "zoom", original_zoom, 0.4)
	# Return camera's local position to (0, 0) so it's centered back on the player
	tween.tween_property(camera, "position", Vector2.ZERO, 0.4)
	
	await tween.finished
	
	# Turn your camera drag back on
	camera.drag_horizontal_enabled = true
	camera.drag_vertical_enabled = true
	player.can_move = true
	if current_enemy != null:
		current_enemy.queue_free()
		current_enemy = null
	
