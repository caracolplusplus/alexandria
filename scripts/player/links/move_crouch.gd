extends MoveStandard

func on_evaluation(e: ChainEvent, delta: float) -> bool:
	assert(e is MoveEvent)
	
	if not e.character.is_on_floor:
		return false
	
	if e.ceiling.is_colliding() or Input.is_action_pressed("crouch"):
		move(delta, e.character)
		
		return true
	
	return false
	
