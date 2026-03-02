extends AnimationLink

func on_disabled(e: AnimationEvent, delta: float) -> void:
	var value = e.tree.get("parameters/Jump/blend_amount")
	
	value = lerp(value, 0.0, blend(delta))
	
	e.tree.set("parameters/Jump/blend_amount", value)

func on_enabled(e: AnimationEvent, delta: float) -> void:
	var value = e.tree.get("parameters/Jump/blend_amount")
	
	value = lerp(value, 1.0, blend(delta))
	
	e.tree.set("parameters/Jump/blend_amount", value)

func on_evaluation(e: ChainEvent, delta: float) -> bool:
	assert(e is AnimationEvent)
	
	if e.character.is_on_floor:
		on_disabled(e, delta)
		
		return false
	else:
		on_enabled(e, delta)
		
		apply_turn_to_avatar(e.avatar, e.character, e.tree, delta)
		
		return true
