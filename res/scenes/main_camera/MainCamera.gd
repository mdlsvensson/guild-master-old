extends Camera2D
class_name MainCamera
func get_class() -> String: return 'MainCamera'

export var speed: int

var input_vector: Vector2 = Vector2.ZERO

onready var world: Node2D = get_tree().get_root().get_child(0)

func _process(delta: float) -> void:
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength('camera_right') - Input.get_action_strength('camera_left')
	input_vector.y = Input.get_action_strength('camera_down') - Input.get_action_strength('camera_up')
	input_vector = input_vector.normalized()

	move()

func move() -> void:
	position += input_vector * speed

	var chunks_center_point: Vector2 = world.loaded_chunks_center_point

	if position.x >= chunks_center_point.x + world.chunk_size * 128 or position.x <= chunks_center_point.x - world.chunk_size * 128:
		world.loaded_chunks_center_point.x = position.x

	if position.y >= chunks_center_point.y + world.chunk_size * 128 or position.y <= chunks_center_point.y - world.chunk_size * 128:
		world.loaded_chunks_center_point.y = position.y

	if world.loaded_chunks_center_point != chunks_center_point:
		world.redraw_map()
