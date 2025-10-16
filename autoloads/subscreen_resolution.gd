extends Node

const RESOLUTIONS: Array[Vector2i] = [
	Vector2i(720, 450),
]

signal update_resolution(RESOLUTION: Vector2i)

func _init() -> void: DisplayServer.window_set_min_size(RESOLUTIONS[0])
func _ready() -> void:
	get_tree().get_root().size_changed.connect(update_subscreen_resolution)
	update_subscreen_resolution()

func _input(EVENT: InputEvent) -> void:
	if not EVENT.is_action_pressed("toggle_fullscreen"): return
	
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func update_subscreen_resolution() -> void:
	var resolution := RESOLUTIONS[0]
	for it in RESOLUTIONS:
		if aspect_difference(it) >= aspect_difference(resolution): continue
		if max_scale_of(it) < max_scale_of(resolution): continue
		resolution = it
	
	update_resolution.emit(resolution)

func aspect_difference(RESOLUTION: Vector2i) -> float:
	return absf(RESOLUTION.aspect() - DisplayServer.window_get_size().aspect())

func max_scale_of(RESOLUTION: Vector2i) -> int:
	var MAX_SCALE := DisplayServer.window_get_size() / RESOLUTION
	return mini(MAX_SCALE.x, MAX_SCALE.y)
