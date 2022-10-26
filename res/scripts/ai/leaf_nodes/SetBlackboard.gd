extends BehaviorTreeBaseNode
class_name SetBlackboard, 'res://editor_icons/set_blackboard.svg'
func get_class() -> String: return 'SetBlackboard'

export var node: NodePath
export var node_property_or_function_name: String
export var blackboard_property_name: String

var _invalid: bool = true
var _node: Node
var _is_function_call: bool = false

func _ready() -> void:
	if node:
		_node = get_node(node)

	if !_node:
		printerr('SetBlackboard: Must set node. %s' % get_path())
		return
	if node_property_or_function_name == null or node_property_or_function_name == '':
		printerr('SetBlackboard: Must provide node property or function name.')
		return

	if _node.has_method(node_property_or_function_name):
		_is_function_call = true

	if !blackboard_property_name:
		blackboard_property_name = node_property_or_function_name

	_invalid = false

func tick(delta: float, blackboard: Blackboard, result: BehaviorTreeResult) -> void:
	if _invalid:
		result.set_failure()
		return

	if _is_function_call:
		blackboard.data[blackboard_property_name] = _node.call(node_property_or_function_name)
	else:
		blackboard.data[blackboard_property_name] = _node.get(node_property_or_function_name)

	result.set_success()

