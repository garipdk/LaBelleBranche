extends GPUParticles3D

enum Type {
	SCIENCE,
	NEUTRAL,
	EMOTIONAL,
}
@onready var poof = $Poof
var material: Material

func change_color(type:Type) -> void:
	if not poof.is_node_ready():
		await poof.ready
	material = self.draw_pass_1.surface_get_material(0)
	match type:
		Type.SCIENCE:
			material.albedo_color = Color8(0,0,255)
		Type.NEUTRAL:
			material.albedo_color = Color8(50,200,50)
		Type.EMOTIONAL:
			material.albedo_color = Color8(255,0,0)

func launch_poof():
	poof.playing = true
