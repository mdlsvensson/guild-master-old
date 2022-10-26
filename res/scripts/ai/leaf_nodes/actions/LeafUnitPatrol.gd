extends BehaviorTreeLeaf
class_name LeafUnitPatrol
func get_class() -> String: return 'LeafUnitPatrol'

onready var world = get_node('/root/World')

func tick(delta: float, blackboard: Blackboard, result: BehaviorTreeResult, nav: NavMap) -> void:
  var agent = blackboard.agent
  if agent.destination != agent.patrol_destination: agent.destination = agent.patrol_destination

  result.set_success()
