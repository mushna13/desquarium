extends Node2D

#function for save and load
func _ready() -> void:
	var file = FileAccess.open("user://savedata.json", FileAccess.READ)
	var json = file.get_as_text()
	var fishes = JSON.parse_string(json)
	
	for fish in fishes["fishes"]:
		var scene = load(fish)
		var inst = scene.instantiate()
		add_child(inst)
		inst.global_position = Vector2(randf_range(100, 1000), randf_range(50, 550))
