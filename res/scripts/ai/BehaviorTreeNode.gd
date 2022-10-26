extends Node
class_name BehaviorTreeNode
func get_class() -> String: return 'BehaviorTreeNode'

export var debug: bool = false

func has_bad_children() -> bool: return true

func tick(delta: float, blackboard: Blackboard, result: BehaviorTreeResult) -> void:
	result.success()

func break_on_debug() -> void:
	if debug: breakpoint
