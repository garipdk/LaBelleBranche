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

@onready var tree_basic_0 = $TreeBasic0
@onready var tree_basic_1 = $TreeBasic1
@onready var tree_science_1 = $TreeScience1
@onready var tree_magic_1 = $TreeMagic1
@onready var tree_science_2 = $TreeScience2
@onready var tree_basic_2 = $TreeBasic2
@onready var tree_magic_2 = $TreeMagic2
@onready var tree_science_3 = $TreeScience3
@onready var tree_basic_3 = $TreeBasic3
@onready var tree_magic_3 = $TreeMagic3

@onready var particles_turn_0 = $GPUParticles3DTurn0
@onready var particles_turn_1 = $GPUParticles3DTurn1
@onready var particles_turn_2 = $GPUParticles3DTurn2
@onready var timer = $Timer

var selected_objects:Array
var all_objects:Array
var all_trees:Array
var all_turn_objects:Array
var all_turn_particles:Array

var statistic_science_magic:int = 0
var object_point:int = 10

var current_turn_object:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	all_objects = [oiseau, engrais, peinture, livre, briquet, bar_de_fer, feuille_morte, lunettes]
	all_trees = [tree_basic_0,\
				 tree_basic_1, tree_science_1, tree_magic_1,\
				 tree_science_2, tree_basic_2, tree_magic_2,\
				 tree_science_3, tree_basic_3, tree_magic_3]
	all_turn_particles = [particles_turn_0,particles_turn_1, particles_turn_2]
	for object in all_objects:
		if not object.is_node_ready():
			await object.ready
	for object in all_trees:
		if not object.is_node_ready():
			await object.ready
	for object in all_turn_particles:
		if not object.is_node_ready():
			await object.ready
	
	if not timer.is_node_ready():
		await timer.ready
	all_turn_objects.resize(3)
	all_turn_objects[0] = {"oiseau" : 1,
							"engrais" : -1,
							"next_trees" : { "science" : tree_basic_1,\
									"magic" : tree_basic_1},
							"next_objects" : [peinture, livre]}
	
	all_turn_objects[1] = {"peinture" : 1,
							"livre" : -1,
							"next_trees": { "science" : tree_basic_2,\
											"basic" : tree_basic_2,\
											"magic" : tree_basic_2},
							"next_objects" : [briquet, bar_de_fer, feuille_morte, lunettes]}
	
	all_turn_objects[2] = {"briquet" : 1,
							"bar_de_fer" : -1,
							"feuille_morte" : 1,
							"lunettes" : -1,
							"next_trees" : { "science" : tree_science_3,\
											"basic" : tree_basic_3,\
											"magic" : tree_magic_3},
							"next_objects" : []}
	Save.load_save()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_turn(turn_object:Dictionary, played_object_str:String, played_object=null):
	current_turn_object = turn_object
	if turn_idx == turn_number - 1:
		if selected_objects.is_empty():
			selected_objects.append(played_object_str)
			played_object.visible = false
		else:
			selected_objects.append(played_object_str)
			played_object = null
	else:
		selected_objects = [played_object_str]
	
	applic_statistic(turn_object, played_object_str)
	
	if turn_idx != turn_number - 1:
		selected_objects = []
	if played_object == null :
		next_turn(turn_object)
		turn_idx += 1
	if turn_idx == turn_number:
		if statistic_science_magic > 0:
			Save.save_tree_win("emotion")
		elif statistic_science_magic < 0:
			Save.save_tree_win("rationalite")
		else:
			Save.save_tree_win("multifruit")

func applic_statistic(turn_object:Dictionary, played_object:String):
	statistic_science_magic += turn_object[played_object] * object_point

func next_turn(turn_object:Dictionary):
	make_invisible(all_objects)
	for object in turn_object["next_objects"]:
		object.visible = true
	
	var particles = all_turn_particles[turn_idx]
	
	if statistic_science_magic > 0:
		particles.change_color(particles.Type.EMOTIONAL)
		particles.emitting = true
	elif statistic_science_magic < 0:
		particles.change_color(particles.Type.SCIENCE)
		particles.emitting = true
	else:
		particles.change_color(particles.Type.NEUTRAL)
		particles.emitting = true
	timer.start()

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


func _on_timer_timeout() -> void:
	make_invisible(all_trees)
	if statistic_science_magic > 0:
		current_turn_object["next_trees"]["magic"].visible = true
	elif statistic_science_magic < 0:
		current_turn_object["next_trees"]["science"].visible = true
	else:
		current_turn_object["next_trees"]["basic"].visible = true
