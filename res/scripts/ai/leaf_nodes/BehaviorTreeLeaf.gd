extends BehaviorTreeBaseNode
class_name BehaviorTreeLeaf, 'res://editor_icons/leaf.svg'
func get_class() -> String: return 'BehaviorTreeLeaf'

func _validate_child_nodes() -> void:
	if get_child_count() > 0:
		printerr('BehaviorTreeLeaf: Leaf nodes should not have children. Leaf node error at: %s' % get_path())
		_bad_child_node = true

func tick(delta: float, blackboard: Blackboard, result: BehaviorTreeResult) -> void:
	if has_bad_children():
		result.set_failure()
		return

	result.set_success()

