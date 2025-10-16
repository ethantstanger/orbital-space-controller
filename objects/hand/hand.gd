extends Node3D
class_name Hand

func _init() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _input(EVENT: InputEvent) -> void:
	if EVENT is InputEventMouseMotion:
		viewport_position = EVENT.position

var viewport_position: Vector2

func _physics_process(DELTA: float) -> void:
	update_viewport_position(DELTA)
	position = get_viewport().get_camera_3d().project_position(viewport_position, 5.0)

func update_viewport_position(DELTA: float) -> void:
	viewport_position += Input.get_vector("left", "right", "up", "down") * 100 * DELTA
