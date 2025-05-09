extends Camera3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_ready() -> void:
	pass


func _on_colletion_turn_collection() -> void:
	animation_player.play("turn_left")

func _on_start_game_turn_game() -> void:
	animation_player.play("turn_right")
