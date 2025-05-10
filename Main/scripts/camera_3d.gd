extends Camera3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass


func _on_colletion_turn_collection() -> void:
	animation_player.play("Main_to_Collection")

func _on_start_game_turn_game() -> void:
	animation_player.play("Main_to_Game")
	
func _on_collection_to_main_turn() -> void:
	animation_player.play("Collection_to_Main")
