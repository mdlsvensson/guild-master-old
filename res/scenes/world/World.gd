extends Node2D

signal temp_signal(temp)

export var noise: OpenSimplexNoise

const map_seed = 1

var member_2

func _init() -> void:
	randomize()

onready var member_3

func _ready() -> void:
  noise.seed = randi()

func _process(delta: float) -> void:
  pass

func _physics_process(delta: float) -> void:
  pass 

