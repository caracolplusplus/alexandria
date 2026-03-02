extends MoveLink

@export var deceleration: float = 2.5
@export var maximum_speed: float = 5.5
@export var minimum_speed: float = 2.5
@export var downhill_threshold: float = -0.15

var active: bool = false

func on_evaluation(e: ChainEvent, delta: float) -> bool:
	assert(e is MoveEvent)
	
	if not e.character.is_on_floor:
		active = false
	
	if Input.is_action_pressed("crouch") and e.character.velocity.length() > maximum_speed:
		active = true
	elif Input.is_action_pressed("crouch") and going_downhill(e.character):
		active = true
	elif not Input.is_action_pressed("crouch") or e.character.velocity.length() < minimum_speed:
		active = false
	
	if active:
		move(delta, e.character)
		
		return true
	
	return false

func move(delta: float, character: IKCC) -> void:
	var velocity = character.velocity
	
	if character.is_on_floor and going_downhill(character):
		var normal = character.last_floor_normal
		var downhill = Vector3.DOWN.slide(normal)
		
		var direction = input(character).slide(normal)
	
		direction = (direction + downhill).normalized()
		
		character.velocity = direction * speed
	elif character.is_on_floor:
		var direction = input(character)
		var momentum = velocity.length()
		
		var previous_direction = velocity.normalized()
		
		if direction:
			previous_direction = previous_direction.slerp(direction, blend(delta, character)).normalized()
		
		momentum = move_toward(momentum, 0.0, deceleration * delta)
		
		character.velocity = previous_direction * momentum
	else:
		var horizontal = Vector3(1, 0, 1) * velocity
		var vertical = Vector3.UP * velocity
		
		var direction = input(character)
		var momentum = horizontal.length()
		
		var previous_direction = horizontal.normalized()
		
		if direction:
			previous_direction = previous_direction.slerp(direction, blend(delta, character)).normalized()
		
		momentum = move_toward(momentum, 0.0, deceleration * delta)
		
		horizontal = previous_direction * momentum
		
		vertical += Vector3.DOWN * gravity * delta
		
		character.velocity = horizontal + vertical.limit_length(terminal_speed)
	
	character.move_and_slide()

func going_downhill(character: IKCC) -> bool:
	if character.is_on_floor and not character.last_floor_normal.is_equal_approx(Vector3.UP):
		return input(character).slide(character.last_floor_normal).y < downhill_threshold
	
	return false
