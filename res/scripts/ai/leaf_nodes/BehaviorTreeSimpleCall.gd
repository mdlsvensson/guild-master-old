extends BehaviorTreeBaseNode
class_name BehaviorTreeSimpleCall, 'res://editor_icons/call_simple_function.svg'
func get_class() -> String: return 'BehaviorTreeSimpleCall'

export var node: NodePath
export var node_function_name: String

var _invalid: bool = true
var _node: Node

func _ready() -> void:
	if node:
		_node = get_node(node)

	if !_node:
		printerr('BehaviorTreeSimpleCall: Must set node. %s' % get_path())
		return
	if node_function_name == null or node_function_name == '':
		printerr('BehaviorTreeSimpleCall: Must set node function name.')
		return

	_invalid = false

func tick(delta: float, blackboard: Blackboard, result: BehaviorTreeResult) -> void:
	if _invalid:
		result.set_failure()
		return

	_node.call(node_function_name)

	result.set_success()
