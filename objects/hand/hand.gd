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
	var camera := get_viewport().get_camera_3d()
	var raycast: RayCast3D = $RayCast3D
	#raycast.target_position = 
	var temp := camera.project_ray_origin(viewport_position) - camera.project_ray_normal(viewport_position)
	var temp1 := (camera.global_position - raycast.global_position) * -2
	raycast.target_position = raycast.to_local(temp1)
	print(temp)
	print(temp1)
	print()
	#print(temp)
	#raycast.look_at(Vector3.ZERO, Vector3.BACK)
	#raycast.target_position
	#$RayCast3D.rotation = camera.project_ray_normal(viewport_position) - camera.project_ray_origin(viewport_position)

func _process(_DELTA: float) -> void:
	global_position = get_hand_position()
	#print(position)

func update_viewport_position(DELTA: float) -> void:
	viewport_position += Input.get_vector("left", "right", "up", "down") * 100 * DELTA
	#print(viewport_position)

var plane_distance := 10
func get_hand_position() -> Vector3:
	var camera := get_viewport().get_camera_3d()
	var ray_origin = camera.project_ray_origin(viewport_position)
	var ray_dir = camera.project_ray_normal(viewport_position) # Godot 4

	var cam_origin = camera.global_transform.origin
	var cam_forward = -camera.global_transform.basis.z

	var plane_origin = cam_origin + cam_forward * plane_distance
	var plane_normal = cam_forward

	var denom = plane_normal.dot(ray_dir)
	#if abs(denom) < 1e-6:
		#return

	var t = plane_normal.dot(plane_origin - ray_origin) / denom
	if t < 0:
		return Vector3.ZERO
		
	var hit_point = ray_origin + ray_dir * t
	return hit_point
