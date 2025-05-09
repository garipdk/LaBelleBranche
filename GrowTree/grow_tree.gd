extends Node3D

var turn_idx = 0
@export var turn_number:int = 3
@onready var oiseau = $ToolBar/Oiseau
@onready var engrais = $ToolBar/Engrais
@onready var peinture = $ToolBar/Peinture
@onready var livre = $ToolBar/Livre
@onready var briquet = $ToolBar/Briquet
@onready var bar_de_fer = $ToolBar/BarDeFer
@onready var feuille_morte = $ToolBar/FeuilleMorte
@onready var lunettes = $ToolBar/Lunettes

var oiseau_str = "oiseau"
var engrais_str = "engrais"
var peinture_str = "peinture"
var livre_str = "livre"
var briquet_str = "briquet"
var bar_de_fer_str = "bar_de_fer"
var feuille_morte_str = "feuille_morte"
var lunettes_str = "lunettes"

@onready var tree_basic_1 = $TreeBasic1
@onready var tree_science_1 = $TreeScience1
@onready var tree_magic_1 = $TreeMagic1
@onready var tree_science_2 = $TreeScience2
@onready var tree_basic_2 = $TreeBasic2
@onready var tree_magic_2 = $TreeMagic2
@onready var tree_science_3 = $TreeScience3
@onready var tree_basic_3 = $TreeBasic3
@onready var tree_magic_3 = $TreeMagic3

var selected_objects:Array
var all_objects:Array
var all_trees:Array
var all_turn_objects:Array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	all_objects = [oiseau, engrais, peinture, livre, briquet, bar_de_fer, feuille_morte, lunettes]
	all_trees = [tree_basic_1, tree_science_1, tree_magic_1,\
				 tree_science_2, tree_basic_2, tree_magic_2,\
				 tree_science_3, tree_basic_3, tree_magic_3]
	for object in all_objects:
		if not object.is_node_ready():
			await object.ready
	for object in all_trees:
		if not object.is_node_ready():
			await object.ready
	all_turn_objects.resize(3)
	all_turn_objects[0] = {"oiseau" : 1,
							"engrais" : -1,
							"next_trees" : { "science" : tree_science_1,\
									"magic" : tree_magic_1},
							"next_objects" : [peinture, livre]}
	
	all_turn_objects[1] = {"peinture" : 1,
							"livre" : -1,
							"next_trees": { "science" : tree_science_2,\
											"basic" : tree_basic_2,\
											"magic" : tree_magic_2},
							"next_objects" : [briquet, bar_de_fer, feuille_morte, lunettes]}
	
	all_turn_objects[2] = {"briquet" : 1,
							"bar_de_fer" : -1,
							"feuille_morte" : 1,
							"lunettes" : -1,
							"next_trees" : { "science" : tree_science_3,\
											"basic" : tree_basic_3,\
											"magic" : tree_magic_3},
							"next_objects" : []}

var statistic_science_magic:int = 0
var object_point:int = 10
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_turn(turn_object:Dictionary, played_object_str:String, played_object=null):
	if turn_idx == turn_number - 1:
		if selected_objects.is_empty():
			selected_objects.append(played_object_str)
			played_object.visible = false
		else:
			selected_objects.append(played_object_str)
			played_object = null
	else:
		selected_objects = [played_object_str]
	
	for object in selected_objects:
		applic_statistic(turn_object, object)
	
	if turn_idx != turn_number - 1:
		selected_objects = []
	if played_object == null :
		next_turn(turn_object)
		turn_idx += 1

func applic_statistic(turn_object:Dictionary, played_object:String):
	statistic_science_magic += turn_object[played_object] * object_point

func next_turn(turn_object:Dictionary):
	make_invisible(all_objects)
	make_invisible(all_trees)
	for object in turn_object["next_objects"]:
		object.visible = true
	
	if statistic_science_magic > 0:
		turn_object["next_trees"]["magic"].visible = true
	elif statistic_science_magic < 0:
		turn_object["next_trees"]["science"].visible = true
	else:
		turn_object["next_trees"]["basic"].visible = true
		
	
func make_invisible(things:Array):
	for thing in things:
		thing.visible = false


func _on_oiseau_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		play_turn(all_turn_objects[turn_idx], oiseau_str)


func _on_engrais_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		play_turn(all_turn_objects[turn_idx], engrais_str)


func _on_peinture_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		play_turn(all_turn_objects[turn_idx], peinture_str)


func _on_livre_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		play_turn(all_turn_objects[turn_idx], livre_str)


func _on_briquet_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		play_turn(all_turn_objects[turn_idx], briquet_str, briquet)


func _on_bar_de_fer_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		play_turn(all_turn_objects[turn_idx], bar_de_fer_str, bar_de_fer)


func _on_feuille_morte_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		play_turn(all_turn_objects[turn_idx], feuille_morte_str, feuille_morte)


func _on_lunettes_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		play_turn(all_turn_objects[turn_idx], lunettes_str, lunettes)
