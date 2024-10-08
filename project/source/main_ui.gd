extends Node2D

# Preload the Ball scene
var BallScene = preload("res://source/ball.tscn")
@onready var basket = $StaticBody2D2
@onready var area2d = $StaticBody2D2/Area2D  # Adjust the path according to your scene tree
@onready var basket_sprite = $StaticBody2D2/Sprite2D
# Input function to spawn balls on click

# Function to spawn a new ball
func spawn_ball():
	var new_ball = BallScene.instantiate()
	new_ball.position = get_global_mouse_position()
	#ew_ball.set_tier(1) # Start with tier 1
	add_child(new_ball)

func resize_event():
	basket.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
func _on_ready():
	get_tree().get_root().size_changed.connect(resize_event)
	area2d.area_clicked.connect(spawn_ball)
	if OS.has_feature("mobile") or OS.has_feature("web_android") or OS.has_feature("web_ios"):
		get_tree().root.content_scale_factor = 3.0
	elif OS.has_feature("pc"):
		get_tree().root.content_scale_factor = 1
	#get_tree().root.content_scale_factor = 1
	#calculate_basket_size()
	#get_tree().root.content_scale_factor = 3.0
	resize_event()
	
func calculate_basket_size():
	var screen_size = Vector2(DisplayServer.window_get_size())
	var default_screen_size = Vector2(1920,1080)
	var def_width = 250/1920
	var def_height = 650/1080
	var new_basket_size = Vector2(0.50*screen_size.x, 0.9*screen_size.y)
	var new_basket_scale = Vector2(new_basket_size.x/512, new_basket_size.y/512)
	basket.scale = new_basket_scale
	print_debug('aha', screen_size, default_screen_size, screen_size/default_screen_size, basket_sprite.texture.get_size()*basket_sprite.scale)
func _process(_delta):
	#calculate_basket_size()
	pass
	
