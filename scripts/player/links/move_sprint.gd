extends MoveStandard

@export var minimum_speed: float = 4.5
@export var sprint_time: float = 2.0

var timer: float

func on_evaluation(e: ChainEvent, delta: float) -> bool:
	assert(e is MoveEvent)
	
	if e.character.is_on_floor and e.character.velocity.length() > minimum_speed:
		timer += delta
	else:
		timer -= delta
	
	timer = clampf(timer, 0.0, sprint_time)
	
	if timer == sprint_time:
		move(delta, e.character)
		
		return true
	
	return false
