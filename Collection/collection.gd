extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_collection()

func show_collection() -> void:
	var pot_dict = {
		"emotion": $PotList/PotEmotion,
		"rationalite": $PotList/PotRationalite,
		"multifruit": $PotList/PotMultifruit,
	}
	var save = Save.load_save()
	for tree_name in save:
		pot_dict[tree_name].set_tree_visibility(save[tree_name])
		
	
	
