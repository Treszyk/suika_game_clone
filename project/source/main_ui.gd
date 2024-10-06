extends Node2D

# Preload the Ball scene
var BallScene = preload("res://source/ball.tscn")
@onready var basket = $StaticBody2D2
# Input function to spawn balls on click
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		spawn_ball(event.position)

# Function to spawn a new ball
func spawn_ball(position: Vector2):
	var new_ball = BallScene.instantiate()
	new_ball.position = position
	#ew_ball.set_tier(1) # Start with tier 1
	add_child(new_ball)

func resize_event():
	basket.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
func _on_ready():
	get_tree().get_root().size_changed.connect(resize_event)
	resize_event()
