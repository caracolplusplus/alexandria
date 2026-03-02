extends ChainStandalone

@export var fov_transition_duration: float = 0.5
@export var zoom_transition_duration: float = 0.1

@export var camera: Camera3D

var fov: float = 75.0
var zoom: float = 0.0

func adjust_fov(data: Dictionary) -> void:
	fov = data.fov
	
	var tween = create_tween()
	
	tween.tween_property(camera, "fov", fov - zoom, fov_transition_duration)

func adjust_zoom(data: Dictionary) -> void:
	zoom = data.zoom
	
	var tween = create_tween()
	
	tween.tween_property(camera, "fov", fov - zoom, zoom_transition_duration)
