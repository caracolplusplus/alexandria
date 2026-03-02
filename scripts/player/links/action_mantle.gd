extends ActionLink

var end_position: Vector3

func on_activation(e: ChainEvent) -> Dictionary:
	assert(e is ActionEvent)
	
	return {
		"duration": cooldown_duration,
		"end": end_position
	}

func on_action(e: ChainEvent, _delta: float) -> bool:
	assert(e is ActionEvent)
	
	if Input.is_action_just_pressed("jump") and e.mantle.is_colliding() and not e.ceiling.is_colliding():
		end_position = e.mantle.get_collision_point(0)
		
		return true
	
	return false
