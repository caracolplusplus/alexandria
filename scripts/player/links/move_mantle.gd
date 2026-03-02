extends MoveLink

@export var max_move_distance: float = 0.5

@export var exit_speed: float = 8.0

var start_position: Vector3
var end_position: Vector3

var exit_velocity: Vector3

var timer: float = 0.0
var duration: float = 0.0

func activate(data: Dictionary) -> void:
	timer = data.duration
	duration = data.duration
	end_position = data.end

func on_evaluation(e: ChainEvent, delta: float) -> bool:
	assert(e is MoveEvent)
	
	if timer == duration:
		start_position = e.character.global_position
		end_position = Vector3(start_position.x, end_position.y, start_position.z)
		
		exit_velocity = e.character.global_basis.z * exit_speed
	
	if timer > 0.0:
		move(delta, e.character)
		
		return true
	
	return false

func move(delta: float, character: IKCC) -> void:
	timer -= delta
	
	var progress = 1.0 - (timer / duration)
	
	var desired = start_position.lerp(end_position, progress)
	desired -= character.global_position
	
	# TODO: If too glitchy, slide start point and end point
	if desired.length() > max_move_distance:
		timer = 0
	
	character.velocity = desired / delta
	
	character.move_and_slide()
	
	character.velocity = exit_velocity
