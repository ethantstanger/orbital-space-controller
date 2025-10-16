extends SubViewportContainer
class_name SubscreenContainer

func _init() -> void:
	SubscreenResolution.update_resolution.connect(on_update_resolution)

func on_update_resolution(RESOLUTION: Vector2i) -> void: size = RESOLUTION
 
