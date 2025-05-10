extends GPUParticles3D


@export_enum("Science:-1","Neutral:0","Emotional:1") var type : int

func _on_ready() -> void:
	print("hello")
	self.draw_passes_1.materiel.albedo_color = Color8(0,255,0)
	print("color ?")
