extends AnimationLink

func on_enabled(e: AnimationEvent, _delta: float) -> void:
	var speed = e.character.velocity.length()
	var height = e.collider.shape.height
	
	var position = Vector2(speed, height)
	
	e.tree.set("parameters/Locomotion/blend_position", position)
