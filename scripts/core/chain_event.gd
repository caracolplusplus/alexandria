class_name ChainEvent
extends Node

enum Mode {
	READY,
	PROCESS,
	PHYSICS_PROCESS
}

@export var current_mode: Mode

var last_active_index: int = -1

func process_chain(delta: float) -> void:
	var last = get_child(last_active_index)
	
	for current in get_children():
		assert(current is ChainLink)
		
		var index = current.get_index()
		var ok = current.on_evaluation(self, delta)
		
		if ok:
			if index != last_active_index:
				if last and last_active_index > -1:
					last.deactivated.emit(last.on_deactivation(self)) 
				
				current.activated.emit(current.on_activation(self))
				
				last_active_index = index
			
			return
	
	if last and last_active_index > -1:
		last.deactivated.emit(last.on_deactivation(self))
		
		last_active_index = -1

# CALLBACKS
func _ready() -> void:
	if current_mode == Mode.READY:
		process_chain(0)

func _process(delta: float) -> void:
	if current_mode == Mode.PROCESS:
		process_chain(delta)

func _physics_process(delta: float) -> void:
	if current_mode == Mode.PHYSICS_PROCESS:
		process_chain(delta)
