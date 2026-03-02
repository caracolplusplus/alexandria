class_name ChainLink
extends Node

signal activated(data: Dictionary)
signal deactivated(data: Dictionary)

# VIRTUAL
func on_activation(_e: ChainEvent) -> Dictionary:
	return {}

func on_deactivation(_e: ChainEvent) -> Dictionary:
	return {}

func on_evaluation(_e: ChainEvent, _delta: float) -> bool:
	return false
