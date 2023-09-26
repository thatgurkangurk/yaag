extends CharacterBody2D

@export var acceleration := 10.0
@export var max_speed := 360.0

func prevent_outside_movement(viewport_size: Vector2):
	if global_position.y < 0:
		# player is above the screen
		global_position.y = viewport_size.y
	elif global_position.y > viewport_size.y:
		# player is below the screen
		global_position.y = 0

func _physics_process(delta):
	var input_vector := Vector2(0, Input.get_axis("move_forward", "move_backward"))
	
	velocity += input_vector * acceleration
	velocity = velocity.limit_length(max_speed)
	
	if input_vector.y == 0:
		velocity = velocity.move_toward(Vector2.ZERO, 3)
		
	move_and_slide()
	
	var viewport_size := get_viewport_rect().size
	prevent_outside_movement(viewport_size)
