extends BehaviorTreeBaseNode
class_name CheckBlackboard, 'res://editor_icons/check_blackboard.svg'
func get_class() -> String: return 'CheckBlackboard'

export var blackboard_property_name: String

func tick(delta: float, blackboard: Blackboard, result: BehaviorTreeResult) -> void:
	var property = blackboard.data.get(blackboard_property_name)

	if !property:
		result.set_failure()
		return

	result.set_success()
