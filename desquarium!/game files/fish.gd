extends RigidBody2D

@export var speed = 50
@export var minimum = -10
@export var maximum = 10

#2 states for the fishes
enum states {wandering, hungry}
#state when game is first started
var currentstate: states = states.hungry
var food_in_area: Array
var food_not_available: bool
var food

#function for the movement of the fishes
func fish_move():
	if currentstate == states.wandering or len(food_in_area) <= 0:
		apply_force(Vector2(randf_range(minimum,maximum), randf_range(minimum,maximum)) * speed)
	elif currentstate == states.hungry and len(food_in_area) > 0:
		if food == null:
			food = food_in_area.pick_random()
		apply_force((food.position - position))
		
	if linear_velocity.x > 0:
		$Sprite2D.flip_h = true
	elif linear_velocity.x < 0:
		$Sprite2D.flip_h = false
		


func _on_timer_timeout() -> void:
	fish_move()

#function for fishes to detect food
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("eat"):
		food_in_area.append(body)

#function for fishes to go back to wandering state after eating food
func _on_eat_area_body_entered(body: Node2D) -> void:
	if body.has_method("eat") and currentstate == states.hungry:
		body.eat()
		currentstate = states.wandering

func _on_detect_area_body_exited(body: Node2D) -> void:
	if body in food_in_area:
		food_in_area.erase(body)


func _on_hunger_timeout() -> void:
	currentstate = states.hungry
