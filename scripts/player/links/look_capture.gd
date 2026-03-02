extends ChainLink

func on_evaluation(_e: ChainEvent, _delta: float) -> bool:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	return true
