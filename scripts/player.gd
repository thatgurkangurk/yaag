extends CharacterBody2D

@export var acceleration := 10.0
@export var max_speed := 360.0
@export var rotation_speed := 100.0

func prevent_outside_movement(viewport_size: Vector2):
	if global_position.y < 0:
		# player is above the screen
		global_position.y = viewport_size.y
	elif global_position.y > viewport_size.y:
		# player is below the screen
		global_position.y = 0
		
	if global_position.x < 0:
		# player is too far to the left of the screen
		global_position.x = viewport_size.x
	elif global_position.x > viewport_size.x:
		# player is too far to the right of the screen
		global_position.x = 0

func _physics_process(delta):
	var input_vector := Vector2(0, Input.get_axis("move_forward", "move_backward"))
	
	velocity += input_vector * acceleration
	velocity = velocity.limit_length(max_speed)
	
	if Input.is_action_pressed("rotate_right"):
		rotate(deg_to_rad(rotation_speed*delta))
		
	if Input.is_action_pressed("rotate_left"):
		rotate(deg_to_rad(-rotation_speed*delta))
	
	if input_vector.y == 0:
		velocity = velocity.move_toward(Vector2.ZERO, 3)
		
	move_and_slide()
	
	var viewport_size := get_viewport_rect().size
	prevent_outside_movement(viewport_size)
