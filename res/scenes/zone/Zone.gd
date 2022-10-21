extends Node
class_name Template#, 'res://editor_icons/icon.svg'
func get_class() -> String: return 'Template'

onready var world: Node2D = get_tree().get_root().get_child(0)

func _ready() -> void:
	connect("input_event", self, "_on_Zone_input_event")

func _on_Zone_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
