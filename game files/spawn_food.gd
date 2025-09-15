extends Node2D
#for spawning food by clicking
var food = preload("res://foodarea.tscn")

func _physics_process(delta):
	if Input.is_action_just_pressed("click") and $"../CheckButton".button_pressed == true:
		inst(get_global_mouse_position())

func inst(pos):
	var fd = food.instantiate()
	fd.position = pos
	add_child(fd)
