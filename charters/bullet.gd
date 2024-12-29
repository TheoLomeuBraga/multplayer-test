extends MeshInstance3D

@export var speed : float = 5

func _physics_process(delta: float) -> void:
	if multiplayer.is_server():
		global_position -= basis.z * speed * delta
		if $ShapeCast3D.is_colliding():
			queue_free()
