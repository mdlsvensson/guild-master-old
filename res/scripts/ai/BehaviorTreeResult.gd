extends Reference
class_name BehaviorTreeResult
func get_class() -> String: return 'BehaviorTreeResult'

enum Result {
	FAILURE,
	SUCCESS,
	RUNNING
}

var result: int = Result.FAILURE
var running_node: Node

func set_success() -> void:
	result = Result.SUCCESS
	running_node = null

func set_failure() -> void:
	result = Result.FAILURE
	running_node = null

func set_running(node: Node) -> void:
	result = Result.RUNNING
	running_node = node

func is_succeeded() -> bool:
	return result == Result.SUCCESS

func is_failed() -> bool:
	return result == Result.FAILURE

func is_running() -> bool:
	return result == Result.RUNNING

