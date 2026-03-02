extends ActionLink

@export var max_stamina: float = 2.0
@export var stamina_per_second: float = 1.0/6.0

var available: bool = true

@onready var stamina: float = max_stamina

func on_action(e: ChainEvent, delta: float) -> bool:
	assert(e is ActionEvent)
	
	if e.character.is_on_floor:
		available = true
	
	stamina = min(stamina + stamina_per_second * delta, max_stamina)
	
	if Input.is_action_just_pressed("jump") and available and stamina > 1.0:
		available = false
		stamina -= 1.0
		
		return true
	
	return false
