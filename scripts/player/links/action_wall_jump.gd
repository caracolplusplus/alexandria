extends ActionLink

@export var bounce: float = 4.5
@export var jump: float = 5.5

@export var wall_jump_limit: int = 1

@onready var wall_jump_count: int = wall_jump_limit

func on_action(e: ChainEvent, _delta: float) -> bool:
	assert(e is ActionEvent)
	
	if e.character.is_on_floor:
		wall_jump_count = wall_jump_limit
	
	if Input.is_action_just_pressed("jump") and e.character.is_on_wall and wall_jump_count:
		var normal = e.character.last_wall_normal
		var direction = normal.slide(Vector3.UP).normalized()
		
		e.character.velocity += direction * bounce
		e.character.velocity.y += jump / 2
		
		wall_jump_count -= 1
		
		return true
	
	return false
