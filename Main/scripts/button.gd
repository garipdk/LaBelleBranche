extends StaticBody3D

@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

@export_category("Main Button")
@export var texture: Texture2D = preload("res://Assets/UI/Bouton retour.png")

var texture_height: int
var texture_width: int
var width_on_height_ratio: float

signal turn

func _ready() -> void:
	if not sprite_3d.is_node_ready():
		await sprite_3d.ready
	if not collision_shape_3d.is_node_ready():
		await collision_shape_3d.ready
		
	sprite_3d.texture = texture
	
	
func _on_input_event(
	camera: Node,
	 event: InputEvent,
	 event_position: Vector3,
	 normal: Vector3,
	 shape_idx: int,
	) -> void:
	if event is InputEventMouse:
		if event.is_pressed() and event.button_mask == 1: # 1=clic droit
			turn.emit()
			#print(self.text," clicked")
