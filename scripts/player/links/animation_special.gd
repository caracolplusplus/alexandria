extends AnimationLink

func on_disabled(e: AnimationEvent, delta: float) -> void:
	var value = e.tree.get("parameters/Special/blend_amount")
	
	value = lerp(value, 0.0, blend(delta))
	
	e.tree.set("parameters/Special/blend_amount", value)

func on_enabled(e: AnimationEvent, delta: float) -> void:
	var value = e.tree.get("parameters/Special/blend_amount")
	
	value = lerp(value, 1.0, blend(delta))
	
	e.tree.set("parameters/Special/blend_amount", value)
