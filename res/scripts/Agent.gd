extends Selectable
class_name Agent#, 'res://editor_icons/icon.svg'
func get_class() -> String: return 'Agent'

export var navigation_agent_node: NodePath

var navigation_agent: NavigationAgent2D

func _ready() -> void:
	navigation_agent = get_node_or_null(navigation_agent_node)
	if !navigation_agent: printerr('No navigation agent for %s' % get_script())
