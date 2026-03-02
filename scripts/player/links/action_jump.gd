extends ActionLink

@export var jump: float = 5.5

func on_action(e: ChainEvent, _delta: float) -> bool:
	assert(e is ActionEvent)
	
	if Input.is_action_just_pressed("jump") and e.character.is_on_floor:
		e.character.velocity.y += jump
		
		return true
	
	return false
