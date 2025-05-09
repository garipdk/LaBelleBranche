extends StaticBody3D

@onready var label_3d: Label3D = $Label3D
@onready var sprite_3d: Sprite3D = $Sprite3D

@export_category("Main Button")
@export var text : String = "default text"
@export var texture: Texture2D = preload("res://icon.svg")

signal turn

func _ready() -> void:
	label_3d.text = text
	sprite_3d.texture = texture
	label_3d.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	
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
