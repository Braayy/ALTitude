extends Node2D

export var player_node: NodePath
export var platform_gap: float

export var noise_multiplier: float
export(Array, PackedScene) var platform_types: Array
export(Array, float) var platform_types_chances: Array

onready var current_height := get_viewport().size.y * 2 - platform_gap
onready var player: Node2D = get_node(player_node)

onready var PLATFORMS_PER_SCREEN := get_viewport().size.y * 2 / platform_gap

var noise = OpenSimplexNoise.new()
var chooser = WeightedRandomChooser.new()

func _ready() -> void:
	randomize()
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	
	chooser.set_values(platform_types_chances)
	
	generate_platforms()
	generate_platforms()

func _process(delta: float) -> void:
	if player.position.y <= $"Generate Platforms Threshold".position.y:
		generate_platforms()
		move_threshold_up()

func generate_platforms() -> void:
	for i in range(PLATFORMS_PER_SCREEN):
		var random_platform_index = chooser.choose()
		var platform: Node2D = platform_types[random_platform_index].instance()
		var x = 90 + ((noise.get_noise_1d(current_height * noise_multiplier) + 1) / 2) * get_viewport().size.x * 2 - 90 * 2
		
		platform.position.x = x
		platform.position.y = current_height
		
		if platform.has_signal("stepped_above"):
			platform.connect("stepped_above", player, "_on_jumped_above_special_platform")
		
		self.add_child(platform)
		
		current_height -= platform_gap

func move_threshold_up() -> void:
	$"Generate Platforms Threshold".position.y -= get_viewport().size.y * 2
