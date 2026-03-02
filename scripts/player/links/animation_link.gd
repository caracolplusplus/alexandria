class_name AnimationLink
extends ChainLink

@export var active: bool = false

@export var control: float = 0.15
@export var timescale: float = 0.15
@export var minimum_speed: float = 1.0

func activate(_data: Dictionary) -> void:
	active = true

func deactivate(_data: Dictionary) -> void:
	active = false

func on_enabled(_e: AnimationEvent, _delta: float) -> void:
	pass

func on_disabled(_e: AnimationEvent, _delta: float) -> void:
	pass

func on_evaluation(e: ChainEvent, delta: float) -> bool:
	assert(e is AnimationEvent)
	
	if not active:
		on_disabled(e, delta)
		
		return false
	else:
		on_enabled(e, delta)
		
		apply_turn_to_avatar(e.avatar, e.character, e.tree, delta)
		
		return true

func blend(delta: float) -> float:
	return 1 - pow(control, delta / timescale)

func apply_turn_to_avatar(avatar: Node3D, character: IKCC, tree: AnimationTree, delta: float) -> void:
	var turn = tree.get("parameters/Turn/blend_amount")
	var velocity = Vector3(1, 0, 1) * character.velocity
	
	avatar.top_level = true
	
	avatar.global_position = character.global_position
	
	var target = avatar.global_basis.z
	
	if velocity.length() > minimum_speed:
		target = target.slerp(velocity.normalized(), blend(delta))
		turn = lerp(turn, 0.0, blend(delta))
	else:
		target = target.slerp(character.global_basis.z, blend(delta))
		
		turn = lerp(turn, avatar.global_basis.z.angle_to(character.global_basis.z) / 2 * PI, blend(delta))
	
	tree.set("parameters/Turn/blend_amount", turn)
	
	avatar.look_at(avatar.global_position - target)
