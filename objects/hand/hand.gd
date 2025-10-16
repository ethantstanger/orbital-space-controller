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

func _process(_DELTA: float) -> void:
	position = get_hand_position()
	#print(position)

func update_viewport_position(DELTA: float) -> void:
	viewport_position += Input.get_vector("left", "right", "up", "down") * 100 * DELTA
	#print(viewport_position)

func get_hand_position() -> Vector3:
	var CAMERA := get_viewport().get_camera_3d()
	var from = CAMERA.project_ray_origin(viewport_position)
	var dir = CAMERA.project_ray_normal(viewport_position)
	var Y_POSITION := 0
	var t = (Y_POSITION - from.y) / dir.y
	return from + dir * t
