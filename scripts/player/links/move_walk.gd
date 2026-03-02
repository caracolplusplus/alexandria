extends MoveStandard

func on_evaluation(e: ChainEvent, delta: float) -> bool:
	assert(e is MoveEvent)
	
	move(delta, e.character)
	
	return true
