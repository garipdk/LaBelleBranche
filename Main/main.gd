extends Node3D

@onready var game_to_collection_button = $Buttons/Game_to_Collection

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not game_to_collection_button.is_node_ready():
		await game_to_collection_button.ready



func _on_grow_tree_game_finished() -> void:
	game_to_collection_button.visible = true
