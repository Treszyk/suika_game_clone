extends Node2D

# Preload the Ball scene
var BallScene = preload("res://source/ball.tscn")

# Input function to spawn balls on click
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		spawn_ball(event.position)

# Function to spawn a new ball
func spawn_ball(position: Vector2):
	var new_ball = BallScene.instantiate()
	new_ball.position = position
	#new_ball.set_tier(1) # Start with tier 1
	add_child(new_ball)
