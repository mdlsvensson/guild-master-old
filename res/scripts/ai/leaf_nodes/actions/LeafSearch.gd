extends BehaviorTreeLeaf
class_name LeafSearch
func get_class() -> String: return 'LeafSearch'

func tick(delta: float, blackboard: Blackboard, result: BehaviorTreeResult, nav: NavMap) -> void:
  var agent: NPC = blackboard.agent
  var search_timer: Timer = agent.search_timer

  search_timer.start()
  agent.search_started = true

  result.set_success()
