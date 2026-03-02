class_name ActionLink
extends ChainLink

@export var cooldown_duration: float = 0.3

var cooldown_timer: float = 0.0

func on_action(_e: ChainEvent, _delta: float) -> bool:
	return true

func on_activation(e: ChainEvent) -> Dictionary:
	assert(e is ActionEvent)
	
	return {
		"duration": cooldown_duration
	}

func on_evaluation(e: ChainEvent, delta: float) -> bool:
	assert(e is ActionEvent)
	
	if cooldown_timer > 0.0:
		cooldown_timer -= delta
		
		return true
	
	var result = on_action(e, delta)
	
	if result:
		cooldown_timer = cooldown_duration
	
	return result
