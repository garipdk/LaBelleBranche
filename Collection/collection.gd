extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var save = Save.load_save()
	print(save)
	
