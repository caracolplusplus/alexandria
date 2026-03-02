extends ChainLink

func on_evaluation(e: ChainEvent, delta: float) -> bool:
	assert(e is LookEvent)
	
	var look_right = Input.get_axis("look_left", "look_right")
	var look_up = Input.get_axis("look_up", "look_down")
	
	e.character.rotation.y -= look_right * e.axis * e.sensitivity * delta
	e.camera_rig.rotation.x += look_up * e.axis * e.sensitivity * delta
	
	e.camera_rig.rotation.x = clamp(e.camera_rig.rotation.x, -PI/2, PI/2)
	
	return true
