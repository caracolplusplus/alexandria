extends ChainLink

var motion: Vector2

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		motion += event.relative / get_viewport().get_visible_rect().size

func on_evaluation(e: ChainEvent, _delta: float) -> bool:
	assert(e is LookEvent)
	
	if motion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		e.character.rotation.y -= motion.x * e.sensitivity
		e.camera_rig.rotation.x += motion.y * e.sensitivity
		
		e.camera_rig.rotation.x = clamp(e.camera_rig.rotation.x, -PI/2, PI/2)
		
		motion = Vector2.ZERO
		
		return true
	
	return false
