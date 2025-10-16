extends SubViewportContainer
class_name Subscreen

func _init() -> void:
	SubscreenResolution.update_resolution.connect(on_update_resolution)

func on_update_resolution(RESOLUTION: Vector2i) -> void:
	var MAX_SCALE := SubscreenResolution.max_scale_of(RESOLUTION)
	
	size = RESOLUTION
	scale = Vector2.ONE * MAX_SCALE
	position = (DisplayServer.window_get_size() / 2) - (RESOLUTION / 2 * MAX_SCALE)
