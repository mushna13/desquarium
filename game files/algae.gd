extends CanvasLayer

@onready var opacity = 0

#timer for algae
func _on_timer_timeout() -> void:
	opacity += 0.1
	$TextureRect.modulate = Color(1,1,1,opacity)

#clean button function
func _on_clean_button_pressed() -> void:
	opacity = 0
	$TextureRect.modulate = Color(1,1,1,0)
