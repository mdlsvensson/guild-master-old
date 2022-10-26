extends Control
class_name UI
func get_class() -> String: return 'Control'

onready var bot_panel_label_1 = $VBoxContainer/Label1

func ui_fields_fill(node: Node) -> void:
	if node is Hero:
		bot_panel_label_1.text = node.action
