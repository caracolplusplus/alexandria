extends ChainStandalone

@export var height_offset: float = 0.25
@export var transition_duration: float = 0.25

@export var collider: CollisionShape3D
@export var camera_rig: SpringArm3D

func adjust_height(data: Dictionary) -> void:
	var height = data.height
	
	var tween = create_tween()
	
	tween.set_parallel(true)
	
	tween.tween_property(camera_rig, "position", Vector3(0, height - height_offset, 0), transition_duration)
	tween.tween_property(collider, "position", Vector3(0, height / 2, 0), transition_duration)
	tween.tween_property(collider.shape, "height", height, transition_duration)
