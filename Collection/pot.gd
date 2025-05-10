extends Node3D

@export var tree_scene: PackedScene
@export var show_tree = false
@export var tree_scale_factor = 0.4
@export var tree_y_offset = 0.15

var tree_node: Node3D = null

func _ready() -> void:
	tree_node = tree_scene.instantiate()
	tree_node.scale = tree_scale_factor * Vector3.ONE
	tree_node.position = Vector3(0, tree_y_offset, 0)
	add_child(tree_node)
	tree_node.visible = show_tree

func set_tree_visibility(new_visibility: bool):
	tree_node.visible = new_visibility
	
