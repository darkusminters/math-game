extends CharacterBody2D

@export var speed: float = 100.0

# Automatically grab a reference to your AnimatedSprite2D node
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	# Store the input direction vector directly so it's accessible here
	var current_direction = get_input()
	move_and_slide()
	update_animation(current_direction)

func get_input() -> Vector2:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	return input_direction # Fixed: Must return this value to use it outside this function!

func update_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		animated_sprite.play("Idle")
	else:
		# Priorities 4-way direction based on your available animations
		if abs(direction.x) > abs(direction.y):
			# Moving horizontally
			animated_sprite.play("Right Walk")
			animated_sprite.flip_h = direction.x < 0
		else:
			# Moving vertically
			if direction.y < 0:
				animated_sprite.play("Back Walk")
			else:
				animated_sprite.play("Forward Walk")
