extends BehaviorTreeBaseNode
class_name BehaviorTreeInverter, 'res://editor_icons/inverter.svg'
func get_class() -> String: return 'BehaviorTreeInverter'

func _validate_child_nodes() -> void:
	._validate_child_nodes()
	if _bad_child_node:
		_bad_child_node = get_child_count() == 1

func tick(delta: float, blackboard: Blackboard, result: BehaviorTreeResult) -> void:
	if has_bad_children():
		result.set_success()
		return

	var child: BehaviorTreeNode = get_child(0)
	child.break_on_debug()
	child.tick(delta, blackboard, result)

	if result.is_succeeded():
		result.set_failure()
	elif result.is_failed():
		result.set_success()
