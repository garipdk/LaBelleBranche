extends StaticBody3D

@onready var label_3d: Label3D = $Label3D
@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

@export_category("Main Button")
@export var text: String = "default text"
@export var texture: Texture2D = preload("res://icon.svg")
@export var x_scale: int = 3

var texture_height: int
var texture_width: int
var width_on_height_ratio: float

signal turn

func _ready() -> void:
	label_3d.text = text
	sprite_3d.texture = texture
	self.texture_height = texture.get_height()
	self.texture_width = texture.get_width()
	self.width_on_height_ratio  = self.texture_width/self.texture_height
	var shape = BoxShape3D.new()
	shape.size = Vector3(x_scale*width_on_height_ratio,1,1)
	collision_shape_3d.set_shape(shape)
	sprite_3d.scale = Vector3(x_scale*width_on_height_ratio,1,1)


	
	
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
