extends CanvasLayer

const MAX_PULLS := 6
const SAVE_PATH = "user://save.cfg"

#fish data (name and sprite path)
var fish_list = [
	{"name": "Goldfish", "sprite": preload("res://fishes/goldfish.png"), "link": "res://goldfish.tscn"},
	{"name": "African Jewelfish", "sprite": preload("res://fishes/african jewelfish.png"), "link":"res://african_jewelfish.tscn"},
	{"name": "Angelfish", "sprite": preload("res://fishes/angelfish.png"), "link":"res://angel_fish.tscn"},
	{"name": "Cichlid", "sprite": preload("res://fishes/cichlid.png"), "link":"res://cichlid.tscn"},
	{"name": "Clownfish", "sprite": preload("res://fishes/clownfish.png"), "link":"res://clownfish.tscn"},
	{"name": "Wonderhoy!", "sprite": preload("res://fishes/emu fish.png"), "link":"res://wonderhoy_fish.tscn"},
	{"name": "Black Beta", "sprite": preload("res://fishes/geto.png"), "link":"res://geto.tscn"},
	{"name": "White Beta", "sprite": preload("res://fishes/gojo.png"), "link":"res://gojo.tscn"},
	{"name": "Guppy", "sprite": preload("res://fishes/guppy.png"), "link":"res://guppy.tscn"},
	{"name": "Hilsha", "sprite": preload("res://fishes/hilsha.png"), "link":"res://hilsha.tscn"},
	{"name": "Neon Tetra", "sprite": preload("res://fishes/neontetra.png"), "link":"res://neon_tetra.tscn"},
	{"name": "Seahorse", "sprite": preload("res://fishes/seahorse.png"), "link":"res://seahorse.tscn"}
	]

var pull_count = 0
var fishes_pulled = []
var saved_data = {}

@onready var start_button = $VBoxContainer/HBoxContainer/Aquarium
@onready var pull_button = $VBoxContainer/HBoxContainer/Pull
#stores random fish in the slots
@onready var slots = [
	$VBoxContainer/GridContainer/VBoxContainer,
	$VBoxContainer/GridContainer/VBoxContainer2,
	$VBoxContainer/GridContainer/VBoxContainer3,
	$VBoxContainer/GridContainer/VBoxContainer4,
	$VBoxContainer/GridContainer/VBoxContainer5,
	$VBoxContainer/GridContainer/VBoxContainer6,
]

func _ready():
	pull_button.pressed.connect(_on_pull_pressed)

#gacha (lottery) function after the pull button is pressed
func _on_pull_pressed():
	pull_button.disabled = false
	var random_fish = fish_list[randi() % fish_list.size()]
	var slot = slots[pull_count]  #the next empty slot based on pull count
	
	var texture_rect = slot.get_node("TextureRect")
	var label = slot.get_node("Label")

	texture_rect.texture = random_fish["sprite"]
	label.text = random_fish["name"]
	
	var file = FileAccess.open("user://savedata.json", FileAccess.WRITE)
	fishes_pulled.append(random_fish["link"])
	saved_data["fishes"] = fishes_pulled
	var json = JSON.stringify(saved_data)
	file.store_string(json)
	file.close()
	
	pull_count += 1
	
	if pull_count >= MAX_PULLS:
		pull_button.disabled = true
	

#function for user to go to the aquarium window by pressing the button
func _on_aquarium_pressed() -> void:
	get_tree().change_scene_to_file("res://main_scene.tscn")
