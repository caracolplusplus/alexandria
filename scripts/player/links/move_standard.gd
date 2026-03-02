class_name MoveStandard
extends MoveLink

func move(delta: float, character: IKCC) -> void:
	var velocity = character.velocity
	
	if character.is_on_floor:
		var normal = character.last_floor_normal
		
		var direction = input(character).slide(normal).normalized()
		
		var target = direction * speed
		
		if direction:
			velocity = velocity.lerp(target, blend(delta, character))
		else:
			velocity = velocity.lerp(Vector3.ZERO, blend(delta, character))
		
		character.velocity = velocity.limit_length(terminal_speed)
	else:
		var horizontal = Vector3(1, 0, 1) * velocity
		var vertical = Vector3.UP * velocity
		
		var direction = input(character)
		var momentum = max(horizontal.length(), speed)
		
		var target = direction * momentum
		
		if direction:
			horizontal = horizontal.lerp(target, blend(delta, character))
		else:
			horizontal = horizontal.lerp(Vector3.ZERO, blend(delta, character))
		
		vertical += Vector3.DOWN * gravity * delta
		
		character.velocity = horizontal.limit_length(terminal_speed) + vertical.limit_length(terminal_speed)
	
	character.move_and_slide()
