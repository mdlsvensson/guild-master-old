extends Agent
class_name Hero
func get_class() -> String: return 'Hero'

var action: String

func _init() -> void:
  pass

onready var member_3

func _process(delta: float) -> void:
  pass

func _physics_process(delta: float) -> void:
  navigation_agent.get_next_location()
