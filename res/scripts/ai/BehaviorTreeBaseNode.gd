extends BehaviorTreeNode
class_name BehaviorTreeBaseNode
func get_class() -> String: return 'BehaviorTreeBaseNode'

var _bad_child_node: bool = false

func _ready() -> void:
	set_physics_process(false)
	set_process(false)
	_validate_child_nodes()

func _validate_child_nodes() -> void:
	for child in get_children():
		if !child is BehaviorTreeNode:
			printerr('Only BehaviorTreeNode allowed in tree. Bad node at %s' % child.get_path())
			_bad_child_node = true
			break

func has_bad_children() -> bool:
  return _bad_child_node

