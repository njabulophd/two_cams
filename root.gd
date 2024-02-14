extends Node3D


@export var player : CharacterBody3D;
@export var mouse_sensitivity = 0.03;
@export var invert_y = -1;
@export var invert_x = -1;
@onready var root = get_node(".");
@onready var x_rotation = get_node("x_rotation");
@onready var camera = get_node("x_rotation/SpringArm3D/Camera3D")
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# y rotation
		root.rotate_y(deg_to_rad((event.relative.x * invert_x) * mouse_sensitivity))
		x_rotation.rotate_x(deg_to_rad((event.relative.y * invert_y) * mouse_sensitivity))
		x_rotation.rotation.x = clampf(x_rotation.rotation.x, deg_to_rad(-60), deg_to_rad(30))
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("move_forward"):
		if camera.current == true:
			player.global_rotation.y = root.global_rotation.y
	if Input.is_action_pressed("sprint"):
		camera.fov += 30 * delta
		camera.fov = clampf(camera.fov, 90, 100)
	else:
		camera.fov -= .004;
		camera.fov = clampf(camera.fov, 0.0, 80.0)
	root.global_position = player.global_position
