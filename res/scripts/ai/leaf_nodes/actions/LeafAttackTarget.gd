extends BehaviorTreeLeaf
class_name LeafAttackTarget
func get_class() -> String: return 'LeafAttackTarget'

func tick(delta: float, blackboard: Blackboard, result: BehaviorTreeResult, nav: NavMap) -> void:
  var agent: NPC = blackboard.agent
  var target: Unit = blackboard.data.target

  if target.global_position != agent.destination: agent.destination = target.global_position

  result.set_success()
