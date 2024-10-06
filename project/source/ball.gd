extends Node2D

class_name Ball
# Variables for the ball's tier and max tier
var tier: int = 1
var max_tier: int = 20  # Define the maximum tier for the balls
var is_merging = false
# Reference the Sprite and CollisionShape2D nodes
@onready var sprite = $RigidBody2D/CollisionShape2D/Sprite2D
@onready var collision_shape = $RigidBody2D/CollisionShape2D
@onready var tier_text= $RigidBody2D/RichTextLabel
@onready var this_body = $RigidBody2D
# Called when the node enters the scene tree for the first time
func _ready():
	set_tier(tier)  # Initialize the ball with the default tier
	tier_text.add_text(String.num_int64(tier))
	var scale_factor = 1 + (tier - 1)
	collision_shape.scale = Vector2(scale_factor, scale_factor)
	this_body.mass = 2*(tier*tier)
	
# Function to set the ball's tier and update its visuals
func set_tier(tier_value: int):
	tier = tier_value
	
	# Scale the entire Ball node (Node2D) based on its tier
	var scale_factor = 1 + (tier - 1) * 0.2
	self.scale = Vector2(scale_factor, scale_factor)
	
	# Optionally change the sprite texture based on the tier (if you have different textures)
	#sprite.texture = load("res://textures/ball_tier_%d.png" % tier)

# Function to merge with another ball
func merge_with(other_ball):
	if tier < max_tier and not is_merging and not other_ball.get_parent().is_merging:
		is_merging = true
		other_ball.get_parent().is_merging = true
		print_debug('merge')
		var new_tier = tier + 1
		
		# Create a new ball of the next tier
		var new_ball = preload("res://source/ball.tscn").instantiate()  # Assuming BallScene is preloaded
		new_ball.global_position = this_body.global_position  # Place the new ball at the same position
		new_ball.set_tier(new_tier)
		get_parent().add_child(new_ball)
		print_debug(new_ball.tier, new_ball.position)

		# Remove the old balls
		self.queue_free()
		other_ball.get_parent().queue_free()

func _on_rigid_body_2d_body_entered(body):
	print_debug(self.global_position)
	if body.is_in_group("Balls") and body.get_parent().tier == self.tier and not is_merging:
		print_debug('ball')
		merge_with(body)  # Merge the two balls if they have the same tier


