extends BehaviorTreeBaseNode
class_name BehaviorTreeSequence, 'res://editor_icons/sequence.svg'
func get_class() -> String: return 'BehaviorTreeSequence'

export var random: bool = false
export var disabled: bool = false

var _last_result: int = -1
var _last_children: Array = []

func tick(delta: float, blackboard: Blackboard, result: BehaviorTreeResult) -> void:
	if has_bad_children():
		result.set_success()
		return

	if disabled:
		result.set_success()
		return

	for child in _get_children():
		var bt_node: BehaviorTreeNode = child
		bt_node.break_on_debug()
		bt_node.tick(delta, blackboard, result)

		if !result.is_succeeded(): break

	_last_result = result.result

func _get_children() -> Array:
	var children: Array = get_children()

	if random:
		# If last result was running, keep the same random order
		if _last_result == BehaviorTreeResult.Result.RUNNING:
			return _last_children
		children.shuffle()
		_last_children = children

	return children
