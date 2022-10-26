extends Node2D

signal temp_signal(temp)

export var biome_noise: OpenSimplexNoise
export var tile_noise: OpenSimplexNoise
export var chunk_size: int
export var tile_size: Vector2
export var map_node: NodePath
export var units_node: NodePath

var loaded_chunks_center_point: Vector2 =  Vector2.ZERO
var terrain_textures: Dictionary = {
	grass = [
		preload("res://assets/hex-tiles/grass_0.png"),
		preload("res://assets/hex-tiles/grass_1.png"),
		preload("res://assets/hex-tiles/grass_2.png"),
		preload("res://assets/hex-tiles/grass_3.png"),
		preload("res://assets/hex-tiles/grass_4.png"),
	],
	dirt = preload("res://assets/hex-tiles/dirt.png")
}
var map: Node2D
var units: Node2D

func _init() -> void:
	randomize()

func _ready() -> void:
	biome_noise.seed = randi()
	tile_noise.seed = randi()
	redraw_map()

	map = get_node_or_null(map_node)
	if !map: printerr('No map parent node for %s' % get_script())

	units = get_node_or_null(units_node)
	if !units: printerr('No units parent node for %s' % get_script())


	var hero_instance = preload("res://res/scenes/hero/Hero.tscn").instance()
	units.add_child(hero_instance)

	var first_zone = map.get_child(0)
	var fifteenth_zone = map.get_child(14)

	hero_instance.position = first_zone.position




func _process(delta: float) -> void:
  pass

func _physics_process(delta: float) -> void:
  pass

func _on_Node_clicked(node: Node) -> void:
	print(node)

func redraw_map() -> void:
	for x in chunk_size:
		for y in chunk_size:
			var zone: Zone = preload("res://res/scenes/zone/Zone.tscn").instance()
			map.add_child(zone)

			if y % 2 != 0: zone.position = Vector2(x * tile_size.x + (tile_size.x / 2), y * (tile_size.y - 36))
			else: zone.position = Vector2(x * tile_size.x, y * (tile_size.y - 36))

			var biome_noise_val = biome_noise.get_noise_2d(x, y)
			var tile_noise_val = tile_noise.get_noise_2d(x, y)

			var biome: String
			var terrain: String

			if biome_noise_val > -0.99:
				biome = 'Grass'
				if tile_noise_val < 0:
					zone.hex_sprite.texture = terrain_textures.grass[0]
					terrain = 'Plain'
				elif tile_noise_val < 0.05:
					zone.hex_sprite.texture = terrain_textures.grass[1]
					terrain = 'Forest Edge'
				elif tile_noise_val < 0.3:
					zone.hex_sprite.texture = terrain_textures.grass[2]
					terrain = 'Forest'
				elif tile_noise_val <= 0.4:
					zone.hex_sprite.texture = terrain_textures.grass[3]
					terrain = 'Mountain Edge'
				elif tile_noise_val > 0.4:
					zone.hex_sprite.texture = terrain_textures.grass[4]
					terrain = 'Mountain'
			#if biome_noise_val <= 0: zone.hex

			zone.setup_biome(biome, terrain)

