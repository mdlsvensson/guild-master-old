extends Area2D
class_name Selectable
func get_class() -> String: return 'Selectable'

signal clicked(zone)

export var hover_sprite_node: NodePath

var hover_sprite: Sprite

onready var world: Node2D = get_tree().get_root().get_node("World")

func _ready() -> void:
	connect("clicked", world, "_on_Node_clicked")
	connect("input_event", self, "_on_Selectable_input_event")
	connect("mouse_entered", self, "_on_Selectable_mouse_entered")
	connect("mouse_exited", self, "_on_Selectable_mouse_exited")

	hover_sprite = get_node_or_null(hover_sprite_node)

	if !hover_sprite: printerr('No hover sprite for %s' % get_script())

func _on_Selectable_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_action_pressed("select"):
		emit_signal("clicked", self)

func _on_Selectable_mouse_entered() -> void:
	Global.hovered_selectables.append(self)
	_hover_top_z()

func _on_Selectable_mouse_exited() -> void:
	Global.hovered_selectables.erase(self)
	_hover_top_z()
	hover_sprite.visible = false

func _hover_top_z() -> void:
	var top_z: Selectable

	for selectable in Global.hovered_selectables:
		selectable.hover_sprite.visible = false

		if !top_z: top_z = selectable
		elif top_z.z_index < selectable.z_index:
			top_z = selectable


	if top_z: top_z.hover_sprite.visible = true

