extends Node3D

@onready var game_to_collection_button = $Buttons/Game_to_Collection
@onready var victory_label: Label3D = $VictoryLabel

@onready var collection = $Collection
@onready var grow_tree = $GrowTree
var is_need_reset:bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not game_to_collection_button.is_node_ready():
		await game_to_collection_button.ready
	if not collection.is_node_ready():
		await collection.ready
	if not grow_tree.is_node_ready():
		await grow_tree.ready
	var save = Save.load_save()
	
	for tree_name in save:
		if save[tree_name]:
			game_to_collection_button.visible = true
			break
	


func _on_grow_tree_game_finished() -> void:
	game_to_collection_button.visible = true
	victory_label.visible = true


func _on_reset_collection_turn() -> void:
	Save.create_new_save()
	collection.show_collection()


func _on_game_to_collection_turn() -> void:
	is_need_reset = true
	collection.show_collection()


func _on_start_game_turn() -> void:
	if is_need_reset:
		grow_tree.restart_game()
		is_need_reset = false
		victory_label.visible = false
