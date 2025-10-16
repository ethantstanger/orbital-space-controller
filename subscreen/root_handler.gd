extends Node

@export var sub_root: SubRoot

func on_change_root(ROOT: SubRoot) -> void:
	sub_root.queue_free()
	sub_root = ROOT
	
	add_child.call_deferred(sub_root)
	sub_root.change_root.connect.call_deferred(on_change_root)
	
