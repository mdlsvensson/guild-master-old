extends BehaviorTreeLeaf
class_name LeafFollow
func get_class() -> String: return 'LeafFollow'

func tick(delta: float, blackboard: Blackboard, result: BehaviorTreeResult, nav: NavMap) -> void:
  var agent: NPC = blackboard.agent
  var target_last_seen: Vector2 = blackboard.data.target_last_seen

  if nav.world_to_map(target_last_seen) == nav.world_to_map(agent.global_position):
    agent.detection_area.target_last_seen = null
    result.set_failure()

  if target_last_seen != agent.destination:
    agent.destination = target_last_seen
    result.set_running(self)


