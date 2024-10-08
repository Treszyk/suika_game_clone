extends Area2D

# Define a signal for when the area is clicked
signal area_clicked
@onready var col = $CollisionShape2D
@onready var hover_sprite = $Sprite2D
var mouse_inside = false
func _ready():
	set_process_input(true)

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if true:
				print("Mouse clicked inside Area2D!")
				# Emit the signal to notify the parent node
				emit_signal("area_clicked")
				


func _on_mouse_entered():
	print_debug('entered')
	mouse_inside = true

func _on_mouse_exited():
	print_debug('exited')
	mouse_inside = false
	
	
func _process(_delta):
	if mouse_inside:
		hover_sprite.visible = true  # Show the hover sprite
		hover_sprite.position = get_local_mouse_position()  # Update sprite position to mouse
	else:
		hover_sprite.visible = false  # Hide the hover sprite when outside
	


