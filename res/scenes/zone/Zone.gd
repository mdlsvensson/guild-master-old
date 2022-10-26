extends Selectable
class_name Zone
func get_class() -> String: return 'Zone'

export var navigation_polygon_node: NodePath

var navigation_polygon_instance
var biome: String
var terrain: String
var move_mod: float

onready var hex_sprite: Sprite = $HexSprite

func _ready() -> void:
	navigation_polygon_instance = get_node_or_null(navigation_polygon_node)
	if !navigation_polygon_instance: printerr('No navigation polygon for %s' % get_script())

func setup_biome(biome_type: String, terrain_type: String) -> void:
	biome = biome_type
	terrain = terrain_type

	if biome == 'Grass': move_mod = 1

	if terrain == 'Forest Edge': move_mod *= 0.95
	if terrain == 'Forest' or terrain == 'Mountain Edge': move_mod *= 0.8
	if terrain == 'Mountain': move_mod *= 0.5

