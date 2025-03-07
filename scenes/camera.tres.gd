extends Node3D

@export_group("Properties")
@export var target: CharacterBody3D

@export_group("Zoom")
@export var zoom_minimum = 10
@export var zoom_maximum = 20
@export var zoom_speed = 10

@export_group("Rotation")
@export var rotation_speed = 120
@export var min_rotation_x = -15
@export var max_rotation_x = -15
@export var min_rotation_y = -40
@export var max_rotation_y = 40

var camera_rotation: Vector3
var zoom = 20

@onready var camera = $Camera

func _ready():
	camera_rotation = rotation_degrees  # Initial rotation

func _physics_process(delta):
	# Set position and rotation to targets
	self.position = self.position.lerp(target.position, delta * 4)
	rotation_degrees = rotation_degrees.lerp(camera_rotation, delta * 6)

	camera.position = camera.position.lerp(Vector3(3, 17, zoom), 8 * delta)

	handle_input(delta)

# Handle input
func handle_input(delta):
	# Rotation
	var input := Vector3.ZERO
	input.y = Input.get_axis("ui_right", "ui_left")

	camera_rotation += input.limit_length(1.0) * rotation_speed * delta
	camera_rotation.x = clamp(camera_rotation.x, min_rotation_x, max_rotation_x)
	camera_rotation.y = clamp(camera_rotation.y, min_rotation_y, max_rotation_y)

func _input(event):
	# Zoom using mouse wheel
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.is_pressed():
			zoom -= zoom_speed * 0.1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.is_pressed():
			zoom += zoom_speed * 0.1
		zoom = clamp(zoom, zoom_minimum, zoom_maximum)
