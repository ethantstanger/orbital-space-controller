extends Node

@export var SUBSCREEN_RESOLUTIONS: Array[Vector2i]
@export var SUB_VIEWPORT_CONTAINER: SubViewportContainer

func _ready() -> void:
	DisplayServer.window_set_min_size(SUBSCREEN_RESOLUTIONS[0])
	get_tree().get_root().size_changed.connect(update_subscreen)
	update_subscreen()

func _input(EVENT: InputEvent) -> void:
	if not EVENT.is_action_pressed("toggle_fullscreen"): return
	
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func update_subscreen() -> void:
	var SUBSCREEN_RESOLUTION := get_appropriate_subscreen_resolution()
	var MAX_SCALE := max_scale_of(SUBSCREEN_RESOLUTION)
	
	SUB_VIEWPORT_CONTAINER.size = SUBSCREEN_RESOLUTION
	SUB_VIEWPORT_CONTAINER.scale = Vector2i.ONE * MAX_SCALE
	SUB_VIEWPORT_CONTAINER.position = (DisplayServer.window_get_size() / 2) - (SUBSCREEN_RESOLUTION / 2 * MAX_SCALE)

func get_appropriate_subscreen_resolution() -> Vector2i:
	var resolution := SUBSCREEN_RESOLUTIONS[0]
	for it in SUBSCREEN_RESOLUTIONS:
		if aspect_difference(it) >= aspect_difference(resolution): continue
		if max_scale_of(it) < max_scale_of(resolution): continue
		resolution = it
	return resolution

func aspect_difference(RESOLUTION: Vector2i) -> float:
	return absf(RESOLUTION.aspect() - DisplayServer.window_get_size().aspect())

func max_scale_of(RESOLUTION: Vector2i) -> int:
	var MAX_SCALE := DisplayServer.window_get_size() / RESOLUTION
	return mini(MAX_SCALE.x, MAX_SCALE.y)
