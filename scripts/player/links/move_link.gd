class_name MoveLink
extends ChainLink

@export var terminal_speed: float = 25.0

@export var speed: float = 5.0
@export var control: float = 0.8
@export var gravity: float = 9.8

@export var timescale_on_ground: float = 0.15
@export var timescale_on_air: float = 1.0

@export var height: float = 2.0
@export var fov: float = 75.0

func input(character: IKCC) -> Vector3:
	var move_right = Input.get_axis("move_right", "move_left")
	var move_front = Input.get_axis("move_back", "move_front")
	
	return character.global_basis * Vector3(move_right, 0, move_front).normalized()

func blend(delta: float, character: IKCC) -> float:
	var timescale = timescale_on_ground
	
	if not character.is_on_floor:
		timescale = timescale_on_air
	
	return 1.0 - pow(1.0 - control, delta / timescale)

func move(_delta: float, _character: IKCC) -> void:
	pass

func on_activation(e: ChainEvent) -> Dictionary:
	assert(e is MoveEvent)
	
	return {
		"height": height,
		"fov": fov
	}
