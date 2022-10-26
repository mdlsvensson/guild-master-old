extends Node
class_name BehaviorTree, 'res://editor_icons/behavior_tree.svg'
func get_class() -> String: return 'BehaviorTree'

onready var nav = get_node('/root/World/Map/Main')

enum SyncType {
	Idle,
	Physics
}

export var agent: NodePath
export var blackboard: NodePath
export var visibility_notifier: NodePath
export (SyncType) var sync_type = SyncType.Physics

var _agent: Node
var _blackboard: Blackboard
var _current_running_node: Node

func _ready() -> void:
	set_process(false)
	set_physics_process(false)

	var errors: bool = false

	if blackboard:
		_blackboard = get_node_or_null(blackboard)
	if !_blackboard:
		printerr("BehaviorTree: no blackboard.")
		errors = true

	if agent:
		_agent = get_node(agent)
	if !_agent:
		printerr("BehaviorTree: no agent.")
		errors = true

	_blackboard.agent = _agent

	if !errors and visibility_notifier:
		var vn: VisibilityNotifier2D = get_node_or_null(visibility_notifier)
		if !vn:
			printerr("BehaviorTree: no visibility notifier.")
			errors = true
		else:
			vn.connect('screen_entered', self, '_on_VisibilityNotifier2D_screen_entered')
			vn.connect('screen_exited', self, '_on_VisibilityNotifier2D_screen_exited')

	if errors or not _validate_children():
		printerr("BehaviorTree: Errors occured. Can't proceed.")

	if sync_type == SyncType.Idle:
		set_process(true)
	else:
		set_physics_process(true)

func _validate_children() -> bool:
	if get_child_count() != 1:
		printerr("BehaviorTree: Needs a single child node.")
		return false

	var child = get_child(0)
	if !child is BehaviorTreeNode:
		printerr("BehaviorTree: Child node must be a BehaviorTreeNode.")
		return false

	return true

func _process(delta: float) -> void:
	_run(delta)

func _physics_process(delta: float) -> void:
	_run(delta)

func _run(delta: float) -> void:
	var result: BehaviorTreeResult = BehaviorTreeResult.new()

	var child: BehaviorTreeNode = get_child(0)
	child.break_on_debug()
	child.tick(delta, _blackboard, result)

func _on_VisibilityNotifier2D_screen_entered():
	if sync_type == SyncType.Idle:
		set_process(true)
	else:
		set_physics_process(true)

func _on_VisibilityNotifier2D_screen_exited():
	set_process(false)
	set_physics_process(false)

